// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqflite {
  Database? _DB;

  Future<Database?> get DB async {
    if (_DB == null) {
      _DB = await intialDb();
      return _DB;
    } else {
      return _DB;
    }
  }

  intialDb() async {
    String DatabasesPath = await getDatabasesPath();
    String Path = join(DatabasesPath, 'Note.db');
    Database Mydb = await openDatabase(
      Path,
      onCreate: onCreate,
      version: 1,
    );
    return Mydb;
  }

  onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE Note (
   "NoteID" integer primary key autoincrement not null,
   "NoteTitle" Text,
   "NoteContent" Text
);
''');
  }

  readData(String SQL) async {
    Database? Mydb = await DB;
    List<Map> response = await Mydb!.rawQuery(SQL);

    return response;
  }

  insertData(String SQL) async {
    Database? Mydb = await DB;
    int response = await Mydb!.rawInsert(SQL);

    return response;
  }

  UpdateData(String SQL) async {
    Database? Mydb = await DB;
    int response = await Mydb!.rawUpdate(SQL);

    return response;
  }

  DeleteeData(String SQL) async {
    Database? Mydb = await DB;
    int response = await Mydb!.rawDelete(SQL);

    return response;
  }
}
