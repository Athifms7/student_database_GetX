

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/db/functions/dbFunctions.dart';
import 'package:student_database/db/model/student_model.dart'; // Import your StudentController


class StudentAdd extends StatelessWidget {
  final StudentController studentController = Get.find<StudentController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String imagePath = 'x';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  child: InkWell(
                      onTap: () {
                        takePic();
                      },
                      child:
                          
                          imagePath == 'x'
                              ? const Image(image: AssetImage('assets/user.png'))
                              : Image(image: FileImage(File(imagePath)))
                      
                      ),
                ),
              ),
              const SizedBox (
                height: 30,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
             const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ageController,
                maxLength: 2,
                keyboardType: TextInputType.number,
                 decoration:const InputDecoration(
                  hintText: 'Enter Your Age',
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
             const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration:const InputDecoration(
                  hintText: 'Enter Your Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
           const   SizedBox(
                height: 10,
              ),
              TextField(
                controller: phoneController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Phone Number',
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
             const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child:const Text('Cancel'),
                  ),
                 const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.trim().isNotEmpty &&
                          ageController.text.trim().isNotEmpty &&
                          emailController.text.trim().isNotEmpty &&
                          phoneController.text.trim().isNotEmpty) {
                        final newStudent = StudentModel(
                          name: nameController.text.trim(),
                          age: ageController.text.trim(),
                          email: emailController.text.trim(),
                          phone: phoneController.text.trim(),
                          imagepath: imagePath,
                        );

                        studentController.addStudent(newStudent);
                        Get.back();
                      }
                    },
                    child:const Text('Save'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  takePic() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      imagePath = imageFile.path;
    }
  }
}
