part of 'add_note_cubit.dart';

@immutable
sealed class AddNoteState {}

final class TextnotesInitial extends AddNoteState {}

final class Textnotesucess extends AddNoteState {}

final class Textnotefailure extends AddNoteState {}

final class imagesucess extends AddNoteState {
  final List<String> allimages;
  imagesucess({required this.allimages});
}

final class favouritestate extends AddNoteState {
  final bool fevo;

  favouritestate({required this.fevo});
}

final class recordsucess extends AddNoteState {
  final List<String> recordpath;
  final List<PlayerState> playbackStates;

  final List<AudioPlayer> audoplayers;

  final List<int> audiodurations;

  final List<int> timeprogrss;
  final List<int> audiotimes;
  final List<String> recordnames;

  final List<String> recorddata;

  final int dr = 0;

  recordsucess({
    required this.audiotimes,
    required this.recordpath,
    required this.playbackStates,
    required this.audoplayers,
    required this.audiodurations,
    required this.timeprogrss,
    required this.recordnames,
    required this.recorddata,
  });
}

final class recordpaused extends AddNoteState {
  final PlayerState playstate;
  recordpaused({required this.playstate});
}

final class recordresume extends AddNoteState {
  final PlayerState playstate;
  recordresume({required this.playstate});
}

final class audiodurationstate extends AddNoteState {
  final int audioduration0;
  audiodurationstate({required this.audioduration0});
}

final class timeprogrssstate extends AddNoteState {
  final int timeprogrss0;
  timeprogrssstate({required this.timeprogrss0});
}

final class completestate extends AddNoteState {
  final PlayerState player;
  completestate({required this.player});
}

final class player1 extends AddNoteState {
  final PlayerState player;
  player1({required this.player});
}

final class player2 extends AddNoteState {
  final PlayerState player;
  player2({required this.player});
}

final class player3 extends AddNoteState {
  final PlayerState player;
  player3({required this.player});
}

final class player4 extends AddNoteState {
  final PlayerState player;
  player4({required this.player});
}

class RecordingInProgress extends AddNoteState {
  final int duration;

  RecordingInProgress({required this.duration});
}

//File
final class FileSucess extends AddNoteState {
  final List<String> alfiles;
  final List<String> allnamed;
  FileSucess({required this.alfiles, required this.allnamed});
}
