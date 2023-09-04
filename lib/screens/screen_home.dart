// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database/screens/screen_details.dart';
import 'package:student_database/screens/screen_search.dart';

import 'package:student_database/screens/screen_student_add.dart';

import '../db/functions/dbFunctions.dart';

class HomePage extends StatelessWidget {
  final studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(Search());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(StudentAdd());
        },
        child: Icon(Icons.person_add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Obx(() {
          return ListView.separated(
            itemBuilder: (context, index) {
              final student = studentController.studentList[index];
              return ListTile(
                onTap: () {
                  Get.to(StudentDetails(index: index));
                },
                title: Text(student.name),
                trailing: IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Do you want to delete?',
                      textConfirm: 'Yes',
                      textCancel: 'No',
                      onConfirm: () {
                        studentController.removeStudent(index);
                        Get.back();
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
                leading: student.imagepath == 'x'
                    ? Image(image: AssetImage('assets/user.png'))
                    : Image(image: FileImage(File(student.imagepath!))),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: studentController.studentList.length,
          );
        }),
      ),
    );
  }
}
