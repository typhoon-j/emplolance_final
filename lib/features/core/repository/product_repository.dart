import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../authentication/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Stream<List<ProductModel>> getUserProducts() {
    log('User uid: ${user?.uid}');
    return _firebaseFirestore
        .collection('products')
        .where('userId', isEqualTo: user?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<ProductModel>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<List<ProductModel>> getUserSelectedProducts(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('products')
        .where('userId', isEqualTo: userId)
        .get();
    final productData =
        snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    return productData;
  }

  Future<ProductModel> getProductDetails(String productId) async {
    final snapshot = await _firebaseFirestore
        .collection('products')
        .where('productId', isEqualTo: productId)
        .get();
    final productData =
        snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).single;
    return productData;
  }

  Future<void> addProduct(ProductModel product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<UserModel> getUserDetailsId(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.formSnapShot(e)).single;
    return userData;
  }
}
