import 'dart:developer';

import 'package:emplolance/features/core/models/rating_model.dart';
import 'package:emplolance/features/core/repository/rating_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:uuid/uuid.dart';

class RatingController extends GetxController {
  final RatingRepository database = RatingRepository();

  var ratings = <RatingModel>[].obs;
  var uuid = Uuid();

  @override
  void onInit() {
    ratings.bindStream(database.getUserRatings());
    super.onInit();
  }

  Future<List<RatingModel>> getRatingSelectedUser(String userId) async {
    return await database.getUserSelectedRatings(userId);
  }

  Future<List<RatingModel>> getRatingSelectedProduct(String productId) async {
    return await database.getProductSelectedRatings(productId);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  showRatingDialog(String userId, String consumerId) {
    log('UserId Rating: $userId');
    log('ConsumerId Rating: $consumerId');
    Get.dialog(RatingDialog(
        starColor: Colors.amber,
        title: const Text('Califica al usuario'),
        message: const Text(
            'Selecciona la cantidad de estrellas que deseas y deja un comentario'),
        image: Image.asset(
          'assets/images/welcome/Logo(beta).png',
          height: 100,
        ),
        submitButtonText: 'Calificar',
        onCancelled: () => log('canceled'),
        onSubmitted: (response) {
          final RatingModel rating = RatingModel(
              ratedId: consumerId,
              raterId: userId,
              rating: response.rating,
              ratingId: (uuid.v1()).toString(),
              comment: response.comment);
          database.addRating(rating);
        }));
  }
}
