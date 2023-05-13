import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  static ImagePickerController instanceImg = Get.find();

  Rx<File>? _pickedFile;

  File? get profileImage => _pickedFile?.value;

  void chooseImageFromGalery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      Get.snackbar(
        'Imagen',
        'Escogida con exito',
      );
    }

    _pickedFile = Rx<File>(File(pickedImageFile!.path));
  }

  void captureImageWithCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImageFile != null) {
      Get.snackbar(
        'Imagen',
        'Capturada con exito',
      );
    }

    _pickedFile = Rx<File>(File(pickedImageFile!.path));
  }
}
