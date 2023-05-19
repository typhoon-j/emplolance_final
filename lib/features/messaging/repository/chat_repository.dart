import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/messaging/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../authentication/models/user_model.dart';

class ChatRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<List<ChatModel>> getChatsUser1(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('chats')
        .where('userId1', isEqualTo: userId)
        .get();
    final chatData =
        snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList();
    return chatData;
  }

  Future<List<ChatModel>> getChatsUser2(String userId) async {
    final snapshot = await _firebaseFirestore
        .collection('chats')
        .where('userId2', isEqualTo: userId)
        .get();
    final chatData =
        snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList();
    return chatData;
  }

  Future<UserModel> getUserSelectedDetails(String userId) async {
    log('UserData in repository: $userId');
    final snapshot = await _firebaseFirestore
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.formSnapShot(e)).single;
    return userData;
  }
}
