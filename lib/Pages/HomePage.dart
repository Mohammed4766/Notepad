// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../BackEnd/sqflite.dart';
import '../data.dart';
import 'AddPage.dart';
import 'EditPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // sqflite Mydb = sqflite();
  // List? useresinf = [];
  List mycoler = [
    Color.fromRGBO(253, 135, 255, 1),
    Color.fromRGBO(255, 158, 158, 1),
    Color.fromRGBO(145, 244, 143, 1),
    Color.fromRGBO(255, 245, 153, 1),
    Color.fromRGBO(158, 255, 255, 1),
    Color.fromRGBO(182, 156, 255, 1),
  ];
  Random random = Random();

  // @override
  // void initState() {
  //   getdata();
  //   super.initState();
  // }

  // getdata() async {
  //   var m = await Mydb.readData("select * from 'Note'");
  //   setState(() {
  //     useresinf = m;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List data = [
      {
        "NoteTitle": "مرحبا",
        "NoteContent": "هذه ملاحظة هذه ملاحظة هذه ملاحظة"
      },
      {"NoteTitle": "اهلا", "NoteContent": "هذه ملاحظة هذه ملاحظة هذه ملاحظة"},
      {
        "NoteTitle": "مرحبا",
        "NoteContent": "هذه ملاحظة هذه ملاحظة هذه ملاحظة"
      },
    ];
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer<Note>(
          builder: (context, Note, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: Color.fromRGBO(37, 37, 37, 1),
              body: data.isEmpty
                  ? Container(
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/rafiki.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "انشاء اول ملاحظة لك !",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ]),
                    )
                  : Column(
                      children: [
                        MyappBar(),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, i) {
                              //List m = useresinf!.reversed.toList();
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return EditPage(
                                        NoteId: Note.UserNote[i]["NoteID"],
                                        NoteTitle: Note.UserNote[i]
                                            ["NoteTitle"],
                                        NoteContent: Note.UserNote[i]
                                            ["NoteContent"],
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(30),
                                  margin: EdgeInsets.only(
                                      top: 20, right: 30, left: 30),
                                  decoration: BoxDecoration(
                                      color: mycoler[random.nextInt(6)],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data[i]["NoteTitle"]}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color:
                                                Color.fromRGBO(37, 37, 37, 1)),
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "${data[i]["NoteContent"]}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Color.fromRGBO(37, 37, 37, 1)),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
              floatingActionButton: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ADD();
                    },
                  ));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 37, 37, 1),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 4,
                          offset: Offset(0, 0),
                        )
                      ]),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
            );
          },
        ));
  }

  Container MyappBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "الملاحظات",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
          ),
          // Container(
          //   height: 50,
          //   width: 50,
          //   padding: EdgeInsets.all(5),
          //   child: Icon(
          //     Icons.exit_to_app,
          //     color: Colors.white,
          //   ),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(50),
          //       color: Color.fromRGBO(59, 59, 59, 1)),
          // ),
        ],
      ),
    );
  }
}
