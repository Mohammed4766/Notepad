// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:noteapp/Pages/HomePage.dart';

import '../BackEnd/sqflite.dart';

class ADD extends StatefulWidget {
  const ADD({super.key});

  @override
  State<ADD> createState() => _ADDState();
}

class _ADDState extends State<ADD> {
  TextEditingController NoteTitle = TextEditingController();
  TextEditingController NoteContent = TextEditingController();
  sqflite Mydb = sqflite();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(37, 37, 37, 1),
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MyappBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          TextField(
                            controller: NoteTitle,
                            showCursor: true,
                            maxLines: 2,
                            style: TextStyle(fontSize: 35, color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "العنوان",
                              hintStyle:
                                  TextStyle(fontSize: 35, color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                          TextField(
                            controller: NoteContent,
                            showCursor: true,
                            maxLines: 20,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "اكتب هنا اي شي",
                              hintStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  MyappBar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              if (NoteTitle.text == "" || NoteContent.text == "") {
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: Directionality(
                    textDirection: TextDirection.rtl,
                    child: AwesomeSnackbarContent(
                      title: 'اووه',
                      message: 'لازم تعبي الملاحظة !',
                      messageFontSize: 20,
                      titleFontSize: 20,
                      contentType: ContentType.failure,
                    ),
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                await Mydb.insertData('''
INSERT INTO 'Note'(NoteTitle,NoteContent) VALUES('${NoteTitle.text}','${NoteContent.text}');

''');

                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: Directionality(
                    textDirection: TextDirection.rtl,
                    child: AwesomeSnackbarContent(
                      title: 'تم',
                      message: 'تم اضاقة الملاحضة',
                      messageFontSize: 20,
                      titleFontSize: 20,
                      contentType: ContentType.success,
                    ),
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }

              NoteTitle.clear();
              NoteContent.clear();
            },
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromRGBO(59, 59, 59, 1)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_forward_outlined,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromRGBO(59, 59, 59, 1)),
            ),
          ),
        ],
      ),
    );
  }
}
