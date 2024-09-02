part of 'folders_cubit.dart';

@immutable
sealed class FoldersState {}

final class FoldersInitial extends FoldersState {}

final class Folderscolorstate extends FoldersState {
  final int folcolr;
  Folderscolorstate({required this.folcolr});
}

final class Foldersaddstate extends FoldersState {
  final List<String> foldername;
  final List<int> foldercoloe;
  Foldersaddstate({required this.foldername,required this.foldercoloe});

}

final class searchstate extends FoldersState {
  final List allnote;
    final List allfolder;

  searchstate({required this.allnote,required this.allfolder});
}