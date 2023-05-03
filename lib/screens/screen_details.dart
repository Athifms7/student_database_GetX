// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_database/db/functions/dbFunctions.dart';
import 'package:student_database/screens/screen_edit.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails({super.key, required int this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: studentListNotifier.value[index].imagepath == 'x'
                            ? AssetImage('assets/user.png') as ImageProvider
                            : FileImage(File(
                                studentListNotifier.value[index].imagepath!)))),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Name:              ${studentListNotifier.value[index].name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Age:                ${studentListNotifier.value[index].age}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email:              ${studentListNotifier.value[index].email}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Phone:              ${studentListNotifier.value[index].phone}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return StudentUpdate(
                  student: studentListNotifier.value[index], index: index);
            },
          ));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
