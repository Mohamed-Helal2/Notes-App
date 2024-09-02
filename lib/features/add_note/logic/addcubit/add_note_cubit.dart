import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:note/core/service/sqldb.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:permission_handler/permission_handler.dart';
part 'add_note_state.dart';
// import 'package:permission_handler/permission_handler.dart';


class AddNoteCubit1 extends Cubit<AddNoteState> {
  AddNoteCubit1() : super(TextnotesInitial());

  SqlDb mysql = SqlDb();
  final recorder = FlutterSoundRecorder();
  bool fav = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  TextEditingController recordnamecontroller = TextEditingController();
  GlobalKey<FormState> recordnamekey = GlobalKey<FormState>();
  //  List<String> recordnames = [];
  List<String> selectedImagePaths0 = [];
  List<PlayerState> playbackStates = [];
  List<AudioPlayer> audoplayers = [];
  List<int> audiodurations = [];
  List<int> timeprogrss = [];
  List<int> audiotimes = [];
  List<String> recordpath = [];
  List<String> recordnames = [];
  List<String> recorddate = [];
  List<String> pdfpath = [];
  List<String> pdfnames = [];

  int dr = 0;
  FilePickerResult? result;
  PlatformFile? pickedfile;
  String? filename;
  bool isloading = false;
  File? filetodisplay;
  void changefavourite() {
    fav = !fav;
    emit(favouritestate(fevo: fav));
  }

  addNote({required int folderid}) async {
    if (titleController.text == "") {
      emit(Textnotefailure());
    } else {
      int response = await mysql.insertData(
          '''
INSERT INTO 'notes' ('nfolderid','title','text','datatime','favourite')
VALUES ('$folderid','${titleController.text}','${noteController.text}','${DateTime.now()}','${fav.toString()}')
''');

      if (selectedImagePaths0.isNotEmpty) {
        for (var element in selectedImagePaths0) {
          await mysql.insertData(
              '''
INSERT INTO 'textnotes' ('ntfolderid','image','noteid','datatime')
VALUES ('$folderid','$element','$response','${DateTime.now()}')
''');
        }
      }
      if (pdfpath.isNotEmpty) {
        for (var i = 0; i < pdfpath.length; i++) {
          await mysql.insertData(
              '''
INSERT INTO 'textnotes' ('ntfolderid','pdfpath','pdfname','noteid','datatime')
VALUES ('$folderid','${pdfpath[i]}','${pdfnames[i]}','$response','${DateTime.now()}')
''');
        }
      }
      if (recordpath.isNotEmpty) {
        for (var i = 0; i < recordpath.length; i++) {
          await mysql.insertData(
              '''
INSERT INTO 'textnotes' ('ntfolderid','recordpath','recordname','audiotimes','noteid','datatime')
VALUES ('$folderid','${recordpath[i]}','${recordnames[i]}','${audiotimes[i]}','$response','${(DateFormat('d:MM:yyyy').format(DateTime.now()))}')
''');
        }
      }
      emit(Textnotesucess());
    }
  }

  deleteimage(int index) {
    selectedImagePaths0.removeAt(index);
    emit(imagesucess(allimages: selectedImagePaths0));
  }

  getmultiimage() async {
    final picker = ImagePicker();
    final ListpickedImage = await picker.pickMultiImage();
    for (var element in ListpickedImage) {
      selectedImagePaths0.add(element.path);
    }
    emit(imagesucess(allimages: selectedImagePaths0));
  }

  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      selectedImagePaths0.add(pickedImage.path);
      emit(imagesucess(allimages: selectedImagePaths0));
    }
  }

  Future<void> initrecorder() async {
   // final status = await Permission.microphone.request();
    // if (status != PermissionStatus.granted) {
    //   throw "Microphone permission not granted";
    // }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

//Start recording
  Future<void> startRecording() async {
    audoplayers.forEach((audioPlayer) => audioPlayer.pause());

    for (int i = 0; i < playbackStates.length; i++) {
      // if(playbackStates[i]=PlayerState.)
      playbackStates[i] = PlayerState.paused;
      emit(player1(player: playbackStates[i]));
    }
    //initrecorder();
    String newd =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().second}${DateTime.now().microsecond}";
    try {
      await recorder.startRecorder(
        //codec: Codec.aacMP4,
        toFile: 'audio${newd}',
      );
      subscribeToRecorderStream();
    } catch (err) {}
  }

//Stop recording
  Future<void> stopRecording() async {
    try {
      final filepath = await recorder.stopRecorder();

      recordpath.add(filepath!);
      playbackStates.add(PlayerState.paused);
      audoplayers.add(AudioPlayer());
      audiodurations.add(0);
      timeprogrss.add(0);
      audiotimes.add(dr);
      recorddate.add("${DateTime.now()}");

      emit(recordsucess(
        recorddata: recorddate,
        recordnames: recordnames,
        recordpath: recordpath,
        playbackStates: playbackStates,
        audoplayers: audoplayers,
        audiodurations: audiodurations,
        timeprogrss: timeprogrss,
        audiotimes: audiotimes,
      ));
      dr = 0;
    } catch (err) {}
  }

  deleterecord(int index) {
    playbackStates.removeAt(index);
    audoplayers.removeAt(index);
    audiodurations.removeAt(index);
    timeprogrss.removeAt(index);
    audiotimes.removeAt(index);
    recordpath.removeAt(index);
    recordnames.removeAt(index);
    recorddate.removeAt(index);
    emit(recordsucess(
      recorddata: recorddate,
      recordnames: recordnames,
      recordpath: recordpath,
      playbackStates: playbackStates,
      audoplayers: audoplayers,
      audiodurations: audiodurations,
      timeprogrss: timeprogrss,
      audiotimes: audiotimes,
    ));
  }

  stopwithoutsave() async {
    await recorder.stopRecorder();
    emit(RecordingInProgress(duration: dr));
  }

  void subscribeToRecorderStream() {
    recorder.onProgress!.listen((data) {
      dr = data.duration.inMilliseconds;
      emit(RecordingInProgress(duration: dr));
    });
  }

//play
  playmusic(
    String newaudiofilepath,
    int indx,
  ) async {
    audoplayers[indx].onDurationChanged.listen((Duration duration) {
      audiodurations[indx] = duration.inMilliseconds;
      emit(audiodurationstate(audioduration0: audiodurations[indx]));
    });
    audoplayers[indx].onPositionChanged.listen((Duration p) {
      timeprogrss[indx] = p.inMilliseconds;
      emit(timeprogrssstate(timeprogrss0: timeprogrss[indx]));
    });
    audoplayers[indx].onPlayerComplete.listen((_) {
      playbackStates[indx] = PlayerState.completed;
      emit(completestate(player: playbackStates[indx]));
    });
    var urlSource = DeviceFileSource(newaudiofilepath.toString());
    await audoplayers[indx].play(urlSource);
  }

// Stop
  stopmuic(int indx) async {
    await audoplayers[indx].pause();
  }

//resume

  longplay(int index) async {
    if (recorder.isRecording) {
      recorder.pauseRecorder();
    }
    audoplayers.forEach((audioPlayer) => audioPlayer.pause());
    for (int i = 0; i < playbackStates.length; i++) {
      if (i == index) {
      } else {
        playbackStates[i] = PlayerState.paused;
        emit(player1(player: playbackStates[i]));
      }
    }
    if (playbackStates[index] == PlayerState.paused ||
        playbackStates[index] == PlayerState.stopped) {
      await playmusic(recordpath[index], index);

      playbackStates[index] = PlayerState.playing;
      emit(player2(player: playbackStates[index]));
    } else if (playbackStates[index] == PlayerState.playing) {
      await stopmuic(index);

      playbackStates[index] = PlayerState.stopped;
      emit(player3(player: playbackStates[index]));
    } else if (playbackStates[index] == PlayerState.completed) {
      await playmusic(recordpath[index], index);

      playbackStates[index] = PlayerState.playing;
      emit(player4(player: playbackStates[index]));
    }
  }

  void seekto(int sec, int indx) {
    Duration newposition = Duration(seconds: sec);
    audoplayers[indx].seek(newposition);
  }

  void pickFile1() async {
    try {
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: false);
      if (result != null) {
        if (result!.files.first.extension == 'pdf') {
          filename = result!.files.first.name;
          pickedfile = result!.files.first;
          filetodisplay = File(pickedfile!.path.toString());
          pdfpath.add(pickedfile!.path.toString());
          pdfnames.add(filename!);
          emit(FileSucess(alfiles: pdfpath, allnamed: pdfnames));
        } else {}
      }
    } on Exception catch (e) {}
  }

  deletepdf(int index) {
    pdfnames.removeAt(index);
    pdfpath.removeAt(index);
    emit(FileSucess(alfiles: pdfpath, allnamed: pdfnames));
  }
}
