// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_database/db/functions/dbFunctions.dart';
import 'package:student_database/db/model/student_model.dart';
import 'package:student_database/screens/screen_home.dart';

class StudentUpdate extends StatelessWidget {
  StudentUpdate(
      {super.key, required StudentModel this.student, required int this.index});
  StudentModel student;
  int index;

  late TextEditingController nameController =
      TextEditingController(text: student.name);
  late TextEditingController ageController =
      TextEditingController(text: student.age);
  late TextEditingController emailController =
      TextEditingController(text: student.email);
  late TextEditingController phoneController =
      TextEditingController(text: student.phone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: 120,
              width: 120,
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(20),
                child: Image(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')),
              ),
              // decoration: BoxDecoration(image:Image(image: NetworkImage(''))),
              // color: Colors.amber,
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
                          imagepath: null);

                      studentListNotifier.value.removeAt(index);
                      studentListNotifier.value.insert(index, model);
                      studentListNotifier.notifyListeners();
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
}
