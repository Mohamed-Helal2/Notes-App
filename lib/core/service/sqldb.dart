import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath(); // تحديد مسار حفظ database
    String path = join(
        databasepath, 'note.db'); //تحددي اسم Database + =. datbasepath/note.db
    Database mydb = await openDatabase(path,
        onCreate: _oncreate,
        version: 1,
        onUpgrade: _onupgrade); // انشاء database
    return mydb;
  }

  _onupgrade(Database db, int oldversion, int newversion) async {
    await db.execute("ALTER TABLE 'notes' ADD 'favourite' Text");
    print('------------------ upgrade');
  }

//انشاء الجداول
  _oncreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
CREATE TABLE Folders (
  folderid INTEGER PRIMARY KEY AUTOINCREMENT,
  foldername TEXT ,
  foldercolor INTEGER,
  datatime TEXT 
)
''');
    batch.execute('''
CREATE TABLE notes (
  nfolderid INTEGER  NOT NULL,
  noteid INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT ,
  text TEXT ,
  favourite Text,
  datatime TEXT 
)
''');
    batch.execute('''
CREATE TABLE textnotes (
  notid INTEGER PRIMARY KEY AUTOINCREMENT, 
  image TEXT ,
  recordpath Text,
  recordname Text,
  audiotimes int,
  recorddata Text,
  pdfpath Text,
  pdfname Text,
  noteid INTEGER NOT NULL,
  ntfolderid INTEGER  NOT NULL,
  datatime TEXT NOT NULL,
  FOREIGN KEY (noteid) REFERENCES notes(noteid)
)
''');
    await batch.commit();
  }

// read
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

// insert
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

// update
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

// delete
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

//  DELETE ALL DATBASE
  mydeletedatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'note.db');
    await deleteDatabase(path);
  }
}
