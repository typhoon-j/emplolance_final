import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/core/models/rating_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';

class RatingRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> addRating(RatingModel rating) {
    return _firebaseFirestore
        .collection('ratings')
        .add(rating.toMap())
        .whenComplete(
          () => Get.snackbar(
              'Calificacion Realizada', 'Tu calificacion se realizo con exito!',
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

  Stream<List<RatingModel>> getUserRatings() {
    log('Rated uid: ${user?.uid}');
    return _firebaseFirestore
        .collection('ratings')
        .where('ratedId', isEqualTo: user?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => RatingModel.fromSnapshot(doc)).toList();
    });
  }

  Future<List<RatingModel>> getUserSelectedRatings(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('ratings')
        .where('ratedId', isEqualTo: userId)
        .get();
    final ratingData =
        snapshot.docs.map((e) => RatingModel.fromSnapshot(e)).toList();
    return ratingData;
  }

  Future<List<RatingModel>> getProductSelectedRatings(String productId) async {
    final snapshot = await _firebaseFirestore
        .collection('ratings')
        .where('ratedId', isEqualTo: productId)
        .get();
    final ratingData =
        snapshot.docs.map((e) => RatingModel.fromSnapshot(e)).toList();
    return ratingData;
  }
}
