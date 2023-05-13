import 'dart:developer';
import 'dart:io';

import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/authentication/repository/authentication_repository.dart';
import 'package:emplolance/features/authentication/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  String? imageDownloadURL;

  //TextField Controllers to get data
  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final photo = TextEditingController();
  final description = TextEditingController();

  final userRepo = Get.put(UserRepository());

  //----------------IMAGE PICKER----------------

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

  //----------------REGISTRO DE USUARIO----------------

  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user, File imageFile) async {
    await userRepo.createUser(user);
    imageDownloadURL = await uploadImageToStorage(imageFile);
  }

  //----------------UPLOAD IMAGE TO STORAGE----------------

  Future<String?> uploadImageToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String? downloadUrlOfUploadedImage =
        await taskSnapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedImage;
  }
}
