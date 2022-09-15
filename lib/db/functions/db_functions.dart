import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_db/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDatabase = await Hive.openBox<StudentModel>('student_db');
  await studentDatabase.add(value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDatabase = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDatabase.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(index) async {
  final studentDatabase = await Hive.openBox<StudentModel>('student_db');
  studentDatabase.deleteAt(index);
  getAllStudents();
}

Future<void> editList(int id, StudentModel value) async {
  final studentDatabase = await Hive.openBox<StudentModel>('student_db');
  studentDatabase.putAt(id, value);
  getAllStudents();
}

Future<void> searching() async {
  final studentDatabase = await Hive.openBox<StudentModel>('student_db');
}
