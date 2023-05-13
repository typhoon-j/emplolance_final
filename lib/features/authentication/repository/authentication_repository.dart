import 'dart:developer';

import 'package:emplolance/features/authentication/repository/exceptions/signup_email_password_failure.dart';
import 'package:emplolance/features/authentication/screens/welcome_screen.dart';
import 'package:emplolance/features/core/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../models/user_model.dart';
import 'exceptions/login_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const Dashboard());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, UserModel user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (firebaseUser.value != null) {
        final userModelNew = UserModel(
          fullName: user.fullName,
          email: user.email,
          photo: user.photo,
          password: user.password,
          description: user.description,
          userId: firebaseUser.value?.uid,
        );
        log((firebaseUser.value?.uid).toString());
        SignUpController.instance.createUser(userModelNew);
        Get.offAll(() => const Dashboard());
      } else {
        Get.to(() => const WelcomeScreen());
      }
      //firebaseUser.value != null          ?           :
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      log('FIREBASE AUTH EXCEPTION -${ex.message}');
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: ex.message.toString(),
        duration: const Duration(seconds: 3),
      ));
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      log('EXCEPTION - ${ex.message}');
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: ex.message.toString(),
        duration: const Duration(seconds: 3),
      ));
      throw ex;
    }
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value;
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.code(e.code);
      log(e.code);
      return ex.message;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
