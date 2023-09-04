import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database/db/functions/dbFunctions.dart';
import 'package:student_database/db/model/student_model.dart';
import 'package:student_database/screens/screen_details.dart';

class Search extends StatelessWidget {
  final StudentController studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final RxList<StudentModel> searchList = <StudentModel>[].obs;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchList.assignAll(studentController.studentList.where(
                  (student) => student.name.toLowerCase().contains(value.toLowerCase()),
                ));
              },
              style: const TextStyle(),
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('Search'),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Get.to(() => StudentDetails(index: studentController.studentList.indexOf(searchList[index])));
                  },
                  title: Text(searchList[index].name),
                  trailing: IconButton(
                    onPressed: () {
                      studentController.removeStudent(studentController.studentList.indexOf(searchList[index]));
                      searchList.removeAt(index);
                    },
                    icon:const Icon(Icons.delete),
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: searchList[index].imagepath == 'x' || searchList[index].imagepath == null
                      ?const AssetImage('assets/user.png') as ImageProvider<Object>
                      : FileImage(File(searchList[index].imagepath!)),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: searchList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
