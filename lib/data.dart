import 'package:flutter/material.dart';
import 'BackEnd/sqflite.dart';

class Note extends ChangeNotifier {
  sqflite Mydb = sqflite();

  List UserNote = [];

  Note() {
    getNote();
  }

  getNote() async {
    var m = await Mydb.readData("select * from 'Note'");
    UserNote = m;
    notifyListeners();
  }
}
