import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_db/db/model/data_model.dart';

// ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

class DbFunctionProvider with ChangeNotifier {
  List<StudentModel> studentList = [];

  void addStudent(StudentModel value) async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    final id = await studentDatabase.add(value);
    value.id = id;
    studentList.add(value);

    getAllStudents();
    notifyListeners();
  }

  Future<List<StudentModel>> getAllStudents() async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDatabase.values);
    return studentList;
  }

  Future<void> deleteStudent(int id) async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    await studentDatabase.deleteAt(id);
    getAllStudents();
    notifyListeners();
  }

  Future<void> editList(int id, StudentModel value) async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    await studentDatabase.putAt(id, value);
    getAllStudents();
  }

// Future<void> searching() async {
//   final studentDatabase = await Hive.openBox<StudentModel>('student_db');
// }

}
