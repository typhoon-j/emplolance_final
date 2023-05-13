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

  //----------------REGISTRO DE USUARIO----------------

  void registerUser(String email, String password, UserModel user) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password, user);
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}
