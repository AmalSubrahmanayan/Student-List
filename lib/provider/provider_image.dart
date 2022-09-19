import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProviderImage with ChangeNotifier {
  File? img;
  Future getPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (Image == null) {
      return;
    } else {
      final imageTemporary = File(image!.path);
      img = imageTemporary;
    }
    notifyListeners();
  }
}
