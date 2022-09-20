import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';
import 'package:student_db/provider/provider_search.dart';

class EditStudent extends StatelessWidget {
  EditStudent(
      {Key? key,
      required this.name,
      required this.age,
      required this.phone,
      required this.domain,
      required this.image,
      required this.index,
      required this.id})
      : super(key: key);

  final String name;
  final String age;
  final String phone;
  final String domain;
  String image;
  final int index;
  final String id;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _domainNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: name);
    _ageController = TextEditingController(text: age);
    _phoneNumberController = TextEditingController(text: phone);
    _domainNameController = TextEditingController(text: domain);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: CircleAvatar(
                        backgroundImage: FileImage(
                          File(image),
                        ),
                        radius: 60,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          getPhoto();
                        },
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Add An Image'),
                      ),
                    ],
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Full Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Age ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone Number';
                      } else if (value.length != 10) {
                        return 'Enter valid Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _domainNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Domain Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Domain Name ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onEditStudentButtonClicked(context);
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onEditStudentButtonClicked(ctx) async {
    final studentmodel = StudentModel(
      name: _nameController.text,
      age: _ageController.text,
      phone: _phoneNumberController.text,
      domain: _domainNameController.text,
      photo: image,
      id: id.toString(),
    );
    Provider.of<DbFunctionProvider>(ctx, listen: false)
        .editList(index, studentmodel);
    Provider.of<ProviderSearch>(ctx, listen: false).getAllStudents();

    Navigator.of(ctx).pop();
  }

  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);

      image = photoTemp.path;
    }
  }
}
