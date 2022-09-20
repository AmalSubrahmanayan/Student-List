// import 'dart:ffi';

// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_db/db/functions/db_functions.dart';

class ProviderDelete {
  static deleteItem(BuildContext context, String index) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: const Text('Are you sure want to delete this ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Provider.of<DbFunctionProvider>(context, listen: false)
                        .deleteStudent(index);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Successfully deleted'),
                      duration: Duration(seconds: 2),
                    ));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
            ],
          );
        });
    return null;
  }
}
