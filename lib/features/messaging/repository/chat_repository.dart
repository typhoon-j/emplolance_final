import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/messaging/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
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

  createChat(ChatModel chat) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .set(chat.toMap())
        .whenComplete(
          () => Get.snackbar('Solicitud Aceptada',
              'Se ha creado un chat para que te comuniques con el solicitante, hazlo lo más pronto posible',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: tPrimaryColor.withOpacity(0.4),
              colorText: tSecondaryColor,
              duration: const Duration(seconds: 7)),
        )
        .catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
      log(error.toString());
    });
  }

  onSendMessages(Map<String, dynamic> messages, String chatRoomId) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(messages);
  }

  onSendImage(String chatRoomId, String fullName, String fileName) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(fileName)
        .set({
      "sendby": fullName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });
  }

  onSendImageError(String chatRoomId, String fileName) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(fileName)
        .delete();
  }

  onSendImageSuccess(
      String chatRoomId, String fileName, String imageUrl) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(fileName)
        .update({"message": imageUrl});
  }
}
