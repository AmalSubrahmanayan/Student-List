import 'package:flutter/material.dart';
import 'package:student_db/screens/home/widgets/add_student.dart';
import 'package:student_db/screens/home/widgets/list_student.dart';
import 'package:student_db/screens/home/widgets/search_student.dart';

import '../../db/functions/db_functions.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Student Database',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          backgroundColor: Colors.green,
          label: const Text('Add new Student'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddStudent(),
              ),
            );
          },
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: ListStudent(),
        ),
      ),
    );
  }
}
