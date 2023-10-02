// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../BackEnd/sqflite.dart';

class EditPage extends StatefulWidget {
  EditPage({
    super.key,
    required this.NoteId,
    required this.NoteTitle,
    required this.NoteContent,
  });
  int NoteId;
  String NoteTitle;
  String NoteContent;
  @override
  State<EditPage> createState() => _EditPageState(
      NoteId: NoteId, NoteTitlet: NoteTitle, NoteContentt: NoteContent);
}

class _EditPageState extends State<EditPage> {
  _EditPageState({
    required this.NoteId,
    required this.NoteTitlet,
    required this.NoteContentt,
  });
  int NoteId;
  String NoteTitlet;
  String NoteContentt;

  TextEditingController NoteTitle = TextEditingController();
  TextEditingController NoteContent = TextEditingController();
  sqflite Mydb = sqflite();

  bool enabled = false;

  @override
  void initState() {
    NoteTitle.text = NoteTitlet;
    NoteContent.text = NoteContentt;
    super.initState();
  }

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
                            enabled: enabled,
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
                            enabled: enabled,
                            showCursor: true,
                            maxLines: 20,
                            autofocus: true,
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

  Container MyappBar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  setState(() {
                    enabled = true;
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(59, 59, 59, 1)),
                ),
              ),
              SizedBox(
                width: 20,
              ),
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
                    Alert(
                      context: context,
                      type: AlertType.none,
                      title: "حفظ التغيرات ؟",
                      style: AlertStyle(
                          backgroundColor: Color.fromRGBO(37, 37, 37, 1),
                          titleStyle:
                              TextStyle(fontSize: 18, color: Colors.white)),
                      buttons: [
                        DialogButton(
                          child: Text(
                            "حفظ",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            await Mydb.UpdateData('''
                        UPDATE 'Note'
                         SET NoteTitle = '${NoteTitle.text}', NoteContent = '${NoteContent.text}'
                          WHERE NoteID = '$NoteId'
                        ''');
                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: AwesomeSnackbarContent(
                                  title: 'تم',
                                  message: 'تم تعديل الملاحضة',
                                  messageFontSize: 20,
                                  titleFontSize: 20,
                                  contentType: ContentType.success,
                                ),
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          },
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                        ),
                        DialogButton(
                          child: Text(
                            "الغاء",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(255, 0, 0, 1),
                            Color.fromRGBO(203, 16, 16, 1)
                          ]),
                        ),
                      ],
                    ).show();
                  }
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
            ],
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
