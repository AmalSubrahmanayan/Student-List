import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_db/screens/home/widgets/edit_student.dart';

class FullDetails extends StatelessWidget {
  const FullDetails({
    Key? key,
    required this.name,
    required this.age,
    required this.phone,
    required this.domain,
    required this.photo,
    required this.index,
  }) : super(
          key: key,
        );
  final String name;
  final String age;
  final String phone;
  final String domain;
  final String photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Full Details Of Student',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EditStudent(
                        age: age,
                        domain: domain,
                        index: index,
                        name: name,
                        phone: phone,
                        image: photo,
                      )),
            );
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(File(photo)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Container(
                  height: 35,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(right: 50),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Text(
                    "Full Name: $name",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(right: 50),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Text(
                    "Age: $age",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(right: 50),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Text(
                    "Phone Number: $phone",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(right: 50),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Text(
                    "Domain: $domain",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
