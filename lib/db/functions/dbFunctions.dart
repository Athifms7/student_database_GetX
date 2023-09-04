import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_database/db/model/student_model.dart';

class StudentController extends GetxController {
  var studentList = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllStudents();
  }

  void getAllStudents() {
    final students = Hive.box<StudentModel>('student_box').values.toList();
    studentList.assignAll(students);
  }

  void addStudent(StudentModel model) {
    final box = Hive.box<StudentModel>('student_box');
    box.add(model);
    studentList.add(model);
  }

  void updateStudent(int index, StudentModel model) {
    final box = Hive.box<StudentModel>('student_box');
    box.putAt(index, model);
    studentList[index] = model;
  }

  void removeStudent(int index) {
    final box = Hive.box<StudentModel>('student_box');
    box.deleteAt(index);
    studentList.removeAt(index);
  }

  StudentModel getStudentByIndex(int index) {
    if (index >= 0 && index < studentList.length) {
      return studentList[index];
    } else {
      // Handle an out-of-range index error or return a default student model.
      return StudentModel(
        name: 'Name Not Found',
        age: 'Age Not Found',
        email: 'Email Not Found',
        phone: 'Phone Not Found',
        imagepath: 'x',
      );
    }
  }
}
