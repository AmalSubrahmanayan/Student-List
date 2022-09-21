import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';
import 'package:student_db/provider/provider_image.dart';
import 'package:student_db/provider/provider_search.dart';
// import 'package:student_db/screens/home/screen_home.dart';

class AddStudent extends StatelessWidget {
  AddStudent({
    Key? key,
  }) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _domainNameController = TextEditingController();
  // bool imageAlert = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderImage>(context,listen: false).img==null;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Fill The Form'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ProviderImage>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: value.img == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.black38,
                                  radius: 60,
                                  child: Icon(Icons.image),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(value.img!.path),
                                  ),
                                  radius: 60,
                                ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Provider.of<ProviderImage>(context, listen: false)
                              .getPhoto();
                        },
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Add An Image'),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Age',
                    ),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Phone Number',
                    ),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Domain Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Domain Name ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          Provider.of<ProviderImage>(context, listen: false)
                                  .img !=
                              null) {
                        print('g');
                        await onAddStudentButtonClicked(context);
                        Provider.of<DbFunctionProvider>(context, listen: false)
                            .getAllStudents();
                      } else {
                        print('e');
                        // imageAlert = true;
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

  Future<void> onAddStudentButtonClicked(context) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final phone = _phoneNumberController.text.trim();
    final domain = _domainNameController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        phone.isEmpty ||
        domain.isEmpty ||
        Provider.of<ProviderImage>(context, listen: false).img!.path.isEmpty) {
      return;
    }

    final student = StudentModel(
      name: name,
      age: age,
      phone: phone,
      domain: domain,
      photo: Provider.of<ProviderImage>(context, listen: false).img!.path,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    Provider.of<DbFunctionProvider>(context, listen: false).addStudent(student);

    Navigator.of(context).pop();
    Provider.of<ProviderSearch>(context, listen: false).getAllStudents();
    log('ook');
  }

  // File? photo;
  // Future<void> getPhoto() async {
  //   final pic = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pic == null) {
  //     return;
  //   } else {
  //     final photoTemp = File(pic.path);

  //     photo = photoTemp;
  //   }
  // }
}
