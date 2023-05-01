import 'package:flutter/cupertino.dart';

class StudentModel {
  late String name;
  late String age;
  late String email;
  late String phone;
  String? imagepath;
  StudentModel({
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.imagepath,
  });
}
