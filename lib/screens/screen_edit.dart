// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/db/functions/dbFunctions.dart';
import 'package:student_database/db/model/student_model.dart';
import 'package:student_database/screens/screen_home.dart';

class StudentUpdate extends StatefulWidget {
  StudentUpdate(
      {super.key, required StudentModel this.student, required int this.index});
  StudentModel student;
  int index;

  @override
  State<StudentUpdate> createState() => _StudentUpdateState();
}

class _StudentUpdateState extends State<StudentUpdate> {
  late TextEditingController nameController =
      TextEditingController(text: widget.student.name);

  late TextEditingController ageController =
      TextEditingController(text: widget.student.age);

  late TextEditingController emailController =
      TextEditingController(text: widget.student.email);

  late TextEditingController phoneController =
      TextEditingController(text: widget.student.phone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                updatePic();
              },
              child: SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  child: Image(
                      image:
                          studentListNotifier.value[widget.index].imagepath ==
                                  'x'
                              ? AssetImage('assets/user.png') as ImageProvider
                              : FileImage(File(studentListNotifier
                                  .value[widget.index].imagepath!))),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Enter Your Name',
                  labelText: 'Name',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ageController,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter Your Age',
                  labelText: 'Age',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  labelText: 'Email',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter Your Phone Number',
                  labelText: 'Phone',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isNotEmpty &&
                        ageController.text.trim().isNotEmpty &&
                        emailController.text.trim().isNotEmpty &&
                        phoneController.text.trim().isNotEmpty) {
                      StudentModel model = StudentModel(
                          name: nameController.text.trim(),
                          age: ageController.text.trim(),
                          email: emailController.text.trim(),
                          phone: phoneController.text.trim(),
                          imagepath: widget.student.imagepath);

                      updateStudent(widget.index, model);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Text('Update'),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  updatePic() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        widget.student.imagepath = imageFile.path;
      });
    }
  }
}
