import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database/db/functions/dbFunctions.dart';
import 'package:student_database/screens/screen_edit.dart'; // Import your StudentController

class StudentDetails extends StatelessWidget {
  final StudentController studentController = Get.find<StudentController>();
  final int index;

  StudentDetails({required this.index});

  @override
  Widget build(BuildContext context) {
    final student = studentController.getStudentByIndex(index);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
                    image: student.imagepath == 'x' || student.imagepath == null
                        ? const AssetImage('assets/user.png')
                            as ImageProvider<Object>
                        : FileImage(File(student.imagepath!)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Name: ${student.name}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Age: ${student.age}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Email: ${student.email}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Phone: ${student.phone}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Close'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => StudentUpdate(index: index));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
