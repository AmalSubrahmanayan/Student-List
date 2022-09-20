import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_db/provider/provider_Delete.dart';
import 'package:student_db/provider/provider_search.dart';
import 'package:student_db/screens/home/widgets/student_full_details.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    // Provider.of<DbFunctionProvider>(context, listen: false).getAllStudents();

    return Consumer<ProviderSearch>(
      builder: (BuildContext ctx, studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: ((ctx, index) {
            final data = studentList.foundStudent[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(
                  File(data.photo),
                ),
              ),
              title: Text(data.name),
              trailing: IconButton(
                onPressed: () {
                  ProviderDelete.deleteItem(context, data.id.toString());
                  Provider.of<ProviderSearch>(context,listen: false).runFilter(controller.text);
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red[900],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => FullDetails(
                          name: data.name,
                          age: data.age,
                          phone: data.phone,
                          domain: data.domain,
                          photo: data.photo,
                          index: index,
                          id: data.id,
                        )),
                  ),
                );
              },
            );
          }),
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.foundStudent.length,
        );
      },
    );
  }
}
