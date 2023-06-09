import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/categories_model.dart';

class CategoriesRepository extends GetxController {
  static CategoriesRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<DashboardCategoriesModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs
        .map((e) => DashboardCategoriesModel.formSnapShot(e))
        .single;
    return userData;
  }

  Future<List<DashboardCategoriesModel>> allCategories() async {
    final snapshot = await _db.collection('categories').get();
    final categoryData = snapshot.docs
        .map((e) => DashboardCategoriesModel.formSnapShot(e))
        .toList();
    return categoryData;
  }

  Future<List<ProductModel>> getProductsFromCategory(String category) async {
    final snapshot = await _db
        .collection('products')
        .where('category', isEqualTo: category)
        .where('active', isEqualTo: true)
        .get();
    final productData =
        snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    return productData;
  }
}
