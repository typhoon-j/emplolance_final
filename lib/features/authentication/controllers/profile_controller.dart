import 'dart:developer';

import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/authentication/repository/authentication_repository.dart';
import 'package:emplolance/features/authentication/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }

  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.allUser();
  }

  getUserSelectedData(String userId) {
    return _userRepo.getUserSelectedDetails(userId);
  }

  updateUserData(UserModel user) async {
    log(user.id.toString());
    await _userRepo.updateUserData(user);
  }
}
