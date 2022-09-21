import 'dart:developer';


import 'package:flutter/foundation.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';

class ProviderSearch with ChangeNotifier {
  final List<StudentModel> studentList = DbFunctionProvider.studentList;

  List<StudentModel> foundStudent = [];
  Future<void> getAllStudents() async {
    final students = await DbFunctionProvider().getAllStudents();
    foundStudent = students;

    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    await DbFunctionProvider().deleteStudent(id.toString());
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    List<StudentModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = studentList;
    } else {
      results = studentList
          .where(
            (user) => user.name.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
      log('success');
    }

    foundStudent = results;
    notifyListeners();
  }
}
