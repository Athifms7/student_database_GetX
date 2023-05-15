// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_database/screens/screen_details.dart';
import 'package:student_database/screens/screen_search.dart';
import 'package:student_database/screens/screen_student_add.dart';

import '../db/functions/dbFunctions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Search();
                  },
                ));
              },
              icon: Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return StudentAdd();
            },
          ));
        },
        child: Icon(Icons.person_add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (context, gettingStudendList, child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return StudentDetails(index: index);
                          },
                        ));
                      },
                      title: Text(gettingStudendList[index].name),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('do you want to delete'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          // removeStudent(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          removeStudent(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Yes'))
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete)),
                      leading: gettingStudendList[index].imagepath == 'x'
                          ? Image(image: AssetImage('assets/user.png'))
                          : Image(
                              image: FileImage(
                                  File(gettingStudendList[index].imagepath!))));
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: gettingStudendList.length);
          },
        ),
      ),
    );
  }
}
