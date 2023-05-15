// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student_database/db/functions/dbFunctions.dart';
import 'package:student_database/db/model/student_model.dart';
import 'package:student_database/screens/screen_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<StudentModel> searchList =
      List<StudentModel>.from(studentListNotifier.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: (value) => setState(() {
                searchList = studentListNotifier.value
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
                print(searchList);
              }),
              style: TextStyle(),
              autofocus: true,
              decoration: InputDecoration(
                  label: Text('Search'), suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return StudentDetails(
                                index: studentListNotifier.value
                                    .indexOf(searchList[index]));
                          },
                        ));
                      },
                      title: Text(searchList[index].name),
                      trailing: IconButton(
                          onPressed: () {
                            studentListNotifier.notifyListeners();
                            removeStudent(studentListNotifier.value
                                .indexOf(searchList[index]));

                            searchList.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete)),
                      leading: Image(
                          image: searchList[index].imagepath == 'x'
                              ? AssetImage('assets/user.png') as ImageProvider
                              : FileImage(File(searchList[index].imagepath!))),
                    ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: searchList.length),
          )
        ],
      ),
    );
  }
}
