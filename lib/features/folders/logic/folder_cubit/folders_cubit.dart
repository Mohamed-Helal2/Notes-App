import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:note/core/service/sqldb.dart';

part 'folders_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  FoldersCubit() : super(FoldersInitial());
  TextEditingController foldername = TextEditingController();
  GlobalKey<FormState> folderkey = GlobalKey();
  TextEditingController editfoldername = TextEditingController();

  List<String> Folders = [];
  List<int> Foldercolor = [];
  List<int> Folderid = [];

  SqlDb mysql = SqlDb();
  void getallfolder() async {
    List folderdata = await mysql.readData("SELECT * FROM 'Folders'");
    if (folderdata.isNotEmpty) {
      for (var i = 0; i < folderdata.length; i++) {
        Folders.add(folderdata[i]['foldername']);
        Foldercolor.add(folderdata[i]['foldercolor']);
        Folderid.add(folderdata[i]['folderid']);
      }

      emit(Foldersaddstate(foldername: Folders, foldercoloe: Foldercolor));
    }
  }

  void addfolder({required int col}) async {
    Folders.add(foldername.text);
    Foldercolor.add(col);
    await mysql.insertData(
        '''
INSERT INTO 'Folders' ('foldername','foldercolor','datatime')
VALUES ('${foldername.text}','$col','${DateTime.now()}')
''');
    foldername.clear();
    emit(Foldersaddstate(foldername: Folders, foldercoloe: Foldercolor));
  }

  deletefolder(int folderid, int index) async {
    await mysql
        .deleteData('''
DELETE FROM 'Folders' WHERE folderid=$folderid
''');
    await mysql
        .deleteData('''
DELETE FROM 'notes' WHERE nfolderid=$folderid
''');
    await mysql
        .deleteData('''
DELETE FROM 'textnotes' WHERE ntfolderid=$folderid
''');
    Folders.removeAt(index);
    Foldercolor.removeAt(index);
    Folderid.removeAt(index);
    emit(Foldersaddstate(foldername: Folders, foldercoloe: Foldercolor));
  }

  editfolder(int folderid, int cole, int index) async {
    await mysql.updateData(
        '''
UPDATE 'Folders'  
SET foldername='${editfoldername.text}',foldercolor='${cole}'
  WHERE folderid=$folderid
  ''');
    Folders[index] = editfoldername.text;
    Foldercolor[index] = cole;
    emit(Foldersaddstate(foldername: Folders, foldercoloe: Foldercolor));
  }

  List allnotes = [];
  List allFolders = [];
  readtdata() async {
    allnotes = await mysql.readData("SELECT * FROM 'notes'");
    allFolders=await mysql.readData("SELECT * FROM 'Folders'");
    emit(searchstate(allnote: allnotes, allfolder: allFolders));
  }
}
