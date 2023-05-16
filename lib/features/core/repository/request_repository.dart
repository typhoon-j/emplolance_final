import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/core/models/request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../authentication/models/user_model.dart';

class RequestRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Stream<List<RequestModel>> getUserRequests() {
    log('User uid: ${user?.uid}');
    return _firebaseFirestore
        .collection('requests')
        .where('publisherId', isEqualTo: user?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RequestModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> addRequest(RequestModel request) {
    return _firebaseFirestore.collection('requests').add(request.toMap());
  }

  Future<UserModel> getUserDetailsId(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.formSnapShot(e)).single;
    return userData;
  }

  Future<RequestModel> getRequestDetails(String requestId) async {
    final snapshot = await _firebaseFirestore
        .collection('requests')
        .where('requestId', isEqualTo: requestId)
        .get();
    final requestData =
        snapshot.docs.map((e) => RequestModel.fromSnapshot(e)).single;
    return requestData;
  }

  Future<void> updateRequestStatus(RequestModel request) async {
    log(request.isAccepted.toString());
    await _firebaseFirestore
        .collection('requests')
        .doc(request.id)
        .update(request.toMap());
  }
}
