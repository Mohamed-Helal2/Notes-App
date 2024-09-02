part of 'edit_note_cubit.dart';

@immutable
sealed class EditNoteState {}

final class EditNoteInitial extends EditNoteState {}

final class EditNoteSucess extends EditNoteState {}

final class EditNoteFailure extends EditNoteState {}
final class favouritestate extends EditNoteState {
  final bool fevo;

  favouritestate({required this.fevo});
}
final class readdatasucess extends EditNoteState {
  final List alldata;

  readdatasucess({required this.alldata});
  
}

final class imagesucess extends EditNoteState {
  final List allimage1;

  imagesucess({required this.allimage1});
  
}
final class pdfsucess extends EditNoteState {
  final List allpdfpath1;
  final List allpdfnames1;

  pdfsucess({required this.allpdfpath1,required this.allpdfnames1});
  
}

final class recordsucess extends EditNoteState {
  final List<String> recordpath;
  final List<PlayerState> playbackStates;

  final List<AudioPlayer> audoplayers;

  final List<int> audiodurations;

  final List<int> timeprogrss;
  final List<int> audiotimes;
    final List<String> recordnames;

  final List<String> recorddata;
   final int dr = 0;

  recordsucess(
      {required this.audiotimes,
      required this.recordpath,
      required this.playbackStates,
      required this.audoplayers,
      required this.audiodurations,
      required this.timeprogrss,
     required this.recordnames, 
    required  this.recorddata, 
      });
}

final class recordpaused extends EditNoteState {
  final PlayerState playstate;
  recordpaused({required this.playstate});
}
final class recordresume extends EditNoteState {
  final PlayerState playstate;
  recordresume({required this.playstate});
}
final class audiodurationstate extends EditNoteState {
  final int audioduration0;
  audiodurationstate({required this.audioduration0});
}

final class timeprogrssstate extends EditNoteState {
  final int timeprogrss0;
  timeprogrssstate({required this.timeprogrss0});
}

final class completestate extends EditNoteState {
  final PlayerState player;
  completestate({required this.player});
}

final class player1 extends EditNoteState {
  final PlayerState player;
  player1({required this.player});
}

final class player2 extends EditNoteState {
  final PlayerState player;
  player2({required this.player});
}

final class player3 extends EditNoteState {
  final PlayerState player;
  player3({required this.player});
}

final class player4 extends EditNoteState {
  final PlayerState player;
  player4({required this.player});
}

class RecordingInProgress extends EditNoteState {
  final int duration;

  RecordingInProgress({required this.duration});
}