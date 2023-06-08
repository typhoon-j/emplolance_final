import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/core/models/product_model.dart';

class SearchRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUserSearched(String searchTerm) {
    log('Esta funcionando');
    return _firebaseFirestore
        .collection('users')
        .where('fullname', isGreaterThanOrEqualTo: searchTerm)
        .where('fullname', isLessThan: '${searchTerm}z')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.formSnapShot(doc)).toList();
    });
  }

  Stream<List<ProductModel>> getProductSearched(
      String searchTerm, String category) {
    log('Esta funcionando Producto: $category y $searchTerm');
    return _firebaseFirestore
        .collection('products')
        .where('category', isEqualTo: category)
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThan: '${searchTerm}z')
        .where('active', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    });
  }
}
