import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/core/models/request_model.dart';

class RequestRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addRequest(RequestModel request) {
    return _firebaseFirestore.collection('requests').add(request.toMap());
  }
}
