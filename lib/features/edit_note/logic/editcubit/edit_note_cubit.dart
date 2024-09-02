import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:note/core/service/sqldb.dart';
// import 'package:permission_handler/permission_handler.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit() : super(EditNoteInitial());
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();
  TextEditingController recordnamecontroller = TextEditingController();
  GlobalKey<FormState> recordnamekey = GlobalKey<FormState>();
  SqlDb mysql = SqlDb();
  List newdata = [];
  List idalldata = [];
  List allimage = [];
// record
  final recorder = FlutterSoundRecorder();

  List<String> recordpath = [];
  List<String> recordnames = [];
  List<String> recorddate = [];
  List<int> timeprogrss = [];
  List<int> audiotimes = [];
  List<int> audiodurations = [];
  List<PlayerState> playbackStates = [];
  List<AudioPlayer> audoplayers = [];
  int dr = 0;
  bool fav=false ;

//
  List allpdfpath = [];
  List allpdfname = [];
  FilePickerResult? result;
  PlatformFile? pickedfile;
  String? filename;
  bool isloading = false;
  File? filetodisplay;
  void changefavourite() {
    fav = !fav;
    emit(favouritestate(fevo: fav));
  }

  Future readiddata(int id) async {
    List data1 =
        await mysql.readData("SELECT * FROM 'textnotes'  WHERE noteid=$id");
    idalldata.addAll(data1);
    if (data1.isNotEmpty) {
      //notecontroller.text = data1[0]['text'].toString();
      for (var i = 0; i < data1.length; i++) {
        if (data1[i]['image'] != null) {
          allimage.add(data1[i]['image']);
        }
        if (data1[i]['pdfpath'] != null) {
          allpdfpath.add(data1[i]['pdfpath']);
          allpdfname.add(data1[i]['pdfname']);
        }
        if (data1[i]['recordpath'] != null) {
          playbackStates.add(PlayerState.paused);
          audoplayers.add(AudioPlayer());
          audiodurations.add(0);
          timeprogrss.add(0);
          recorddate.add(data1[i]['datatime']);
          audiotimes.add(data1[i]['audiotimes']);
          recordpath.add(data1[i]['recordpath']);
          recordnames.add(data1[i]['recordname']);
        }
      }
    }
  }

  updateNotes(String noteid) async {
    if (titlecontroller.text == "") {
      emit(EditNoteFailure());
    } else {
      await mysql.updateData(
          '''
UPDATE 'notes'  
SET title='${titlecontroller.text}'
  WHERE noteid=$noteid
  ''');
    await mysql.updateData(
          '''
UPDATE 'notes'  
SET favourite='$fav'
  WHERE noteid=$noteid
  ''');
      await mysql.updateData(
          '''
  UPDATE 'notes'  
  SET text='${notecontroller.text}'
  WHERE noteid=$noteid
  ''');
      emit(EditNoteSucess());
    }
  }

  getmultiimage(int noteid, int folderid) async {
    final picker = ImagePicker();
    final ListpickedImage = await picker.pickMultiImage();
    for (var element in ListpickedImage) {
      await mysql.insertData(
          '''
INSERT INTO 'textnotes' ('ntfolderid','image','noteid','datatime')
VALUES ('$folderid','${element.path}','${noteid}','${DateTime.now()}')
''');
      allimage.add(element.path);
    }
    emit(imagesucess(allimage1: allimage));
  }

  Future<void> AddImage(ImageSource source, int noteid, int folderid) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      await mysql.insertData(
          '''
INSERT INTO 'textnotes' ('ntfolderid','image','noteid','datatime')
VALUES ('$folderid','${pickedImage.path}','${noteid}','${DateTime.now()}')
''');
      allimage.add(pickedImage.path);
      emit(imagesucess(allimage1: allimage));
    }
  }

  Future<void> deleteimage(int index) async {
    await await mysql.deleteData(
        '''
DELETE FROM 'textnotes' WHERE image='${allimage[index]}'
''');
    allimage.removeAt(index);
    emit(imagesucess(allimage1: allimage));
  }

  Future pickFile1(int noteid, int folderid) async {
    result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);
    if (result != null) {
      if (result!.files.first.extension == 'pdf') {
        filename = result!.files.first.name;
        pickedfile = result!.files.first;
        filetodisplay = File(pickedfile!.path.toString());
        allpdfpath.add(pickedfile!.path.toString());
        allpdfname.add(filename!);
        await mysql.insertData(
            '''
INSERT INTO 'textnotes' ('ntfolderid','pdfpath','pdfname','noteid','datatime')
VALUES ('$folderid','${allpdfpath}','${filename}','$noteid','${DateTime.now()}')
''');
        emit(pdfsucess(allpdfpath1: allpdfpath, allpdfnames1: allpdfname));
      }
    }
  }

  deletepdf(int index) async {
    await mysql.deleteData(
        '''
DELETE FROM 'textnotes' WHERE pdfpath='${allpdfpath[index]}'
''');
    allpdfname.removeAt(index);
    allpdfpath.removeAt(index);

    emit(pdfsucess(allpdfpath1: allpdfpath, allpdfnames1: allpdfname));
  }

// record
  Future<void> initrecorder() async {
    // final status = await Permission.microphone.request();
    // if (status != PermissionStatus.granted) {
    //   throw "Microphone permission not granted";
    // }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  void subscribeToRecorderStream(int num) {
    recorder.onProgress!.listen((data) {
      dr = data.duration.inMilliseconds;
      emit(RecordingInProgress(duration: dr));
    });
  }

  Future<void> startRecording() async {
    audoplayers.forEach((audioPlayer) => audioPlayer.pause());

    for (int i = 0; i < playbackStates.length; i++) {
      playbackStates[i] = PlayerState.paused;
      emit(player1(player: playbackStates[i]));
    }
    String newd =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().second}${DateTime.now().microsecond}";

    await recorder.startRecorder(
      //codec: Codec.aacMP4,
      toFile: 'audio${newd}',
    );
    subscribeToRecorderStream(10);
  }

  Future<void> stopRecording(
      {required int noteid, required String name, required folderid}) async {
    try {
      final filepath = await recorder.stopRecorder();

      recordpath.add(filepath!);
      playbackStates.add(PlayerState.paused);
      audoplayers.add(AudioPlayer());
      audiodurations.add(0);
      timeprogrss.add(0);
      audiotimes.add(dr);
      recordnames.add(name);

      String dot = (DateFormat('d:MM:yyyy').format(DateTime.now()));
      recorddate.add(dot);
      await mysql.insertData(
          '''
INSERT INTO 'textnotes' ('ntfolderid','recordpath','recordname','audiotimes','noteid','datatime')
VALUES ('$folderid','${filepath}','${name}','${dr}','$noteid','${dot}')
''');
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
    } catch (err) {
      // print('Error stopping recording: $err');
    }
  }

  deleterecord(int index) async {
    await mysql.deleteData(
        '''
DELETE FROM 'textnotes' WHERE recordpath='${recordpath[index]}'
''');
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
    dr = 0;
    emit(RecordingInProgress(duration: dr));
  }

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

  stopmuic(int indx) async {
    await audoplayers[indx].pause();
  }

  longplay(int index) async {
    if (recorder.isRecording) {
      recorder.pauseRecorder();
      emit(recordpaused(playstate: PlayerState.stopped));
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
}
