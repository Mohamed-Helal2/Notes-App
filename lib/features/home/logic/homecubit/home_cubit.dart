import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note/core/service/sqldb.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SqlDb mysql = SqlDb();
  List newdata = [];
  List favdata = [];
  HomeCubit() : super(HomeInitial());
  readNotes({required int folderid}) async {
    List data =
        await mysql.readData("SELECT * FROM 'notes' WHERE nfolderid=$folderid");
    newdata.addAll(data);
    emit(Homereadsucess(readalldata: data));
  }

  readfavourites() async {
    List data1 =
        await mysql.readData("SELECT * FROM 'notes' WHERE favourite='true'");
    favdata.addAll(data1);
    emit(favdatasucess());
  }

  deltenote(int noteid) async {
    await mysql.deleteData(
        '''
        DELETE FROM 'notes' WHERE noteid=$noteid
        ''');
    await mysql.deleteData(
        '''
        DELETE FROM 'textnotes' WHERE noteid=$noteid
        ''');
    newdata.removeWhere((element) => element["noteid"] == noteid);
    emit(Homereadsucess(readalldata: newdata));
  }

  deltefavnote(int noteid) async {
    await mysql.deleteData(
        '''
        DELETE FROM 'notes' WHERE noteid=$noteid
        ''');
    await mysql.deleteData(
        '''
        DELETE FROM 'textnotes' WHERE noteid=$noteid
        ''');
    favdata.removeWhere((element) => element["noteid"] == noteid);
    emit(favdatasucess());
  }

  deleteallnote() async {
    await mysql.mydeletedatabase();
  }
}
