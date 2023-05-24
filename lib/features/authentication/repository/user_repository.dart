import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection('users')
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar(
              'Cuenta Creada', 'Tu cuenta ha sido creada con exito!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: tPrimaryColor.withOpacity(0.4),
              colorText: tSecondaryColor),
        )
        .catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
      log(error.toString());
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.formSnapShot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection('users').get();
    final userData =
        snapshot.docs.map((e) => UserModel.formSnapShot(e)).toList();
    return userData;
  }

  Future<UserModel> getUserSelectedDetails(String userId) async {
    final snapshot =
        await _db.collection('users').where('userId', isEqualTo: userId).get();
    final userData = snapshot.docs.map((e) => UserModel.formSnapShot(e)).single;
    return userData;
  }

  Future<void> updateUserData(UserModel user) async {
    log(user.id.toString());
    await _db
        .collection('users')
        .doc(user.id)
        .update(user.toJson())
        .whenComplete(
          () => Get.snackbar(
            'Datos Actualizados',
            'Tus datos fueron actualizados con exito.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: tPrimaryColor.withOpacity(0.4),
            colorText: tSecondaryColor,
          ),
        )
        .catchError((error, stackTrace) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );

      log(error.toString());
    });
  }
}
