import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/messaging/controllers/chat_notification_controller.dart';
import 'package:emplolance/features/messaging/models/chat_model.dart';
import 'package:emplolance/features/messaging/repository/chat_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../authentication/repository/user_repository.dart';

class ChatController extends GetxController {
  final ChatRepository database = ChatRepository();
  final _userRepo = Get.put(UserRepository());
  final notification = Get.put(ChatNotificationController());

  Future<List<ChatModel>> getUserChats(String userId) async {
    var chatsUser1 = <ChatModel>[];
    var chatsUser2 = <ChatModel>[];
    var allChats = <ChatModel>[];
    chatsUser1 = await database.getChatsUser1(userId);
    chatsUser2 = await database.getChatsUser2(userId);
    log('ChatUser1: $chatsUser1');
    log('ChatUser2: $chatsUser2');
    allChats = chatsUser1 + chatsUser2;
    log('AllChats: $allChats');
    return allChats;
  }

  getUserSelectedData(String userId) {
    log('UserData in controller: $userId');
    return _userRepo.getUserSelectedDetails(userId);
  }

  Future<void> createChatroom(ChatModel chat) async {
    await database.createChat(chat);
  }

  onSendMessage(TextEditingController _message, UserModel userData,
      UserModel currentUserData, String chatRoomId) async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": currentUserData.fullName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      notification.sendPushNotification(
          userData.userId, currentUserData.fullName, _message.text);

      _message.clear();
      return database.onSendMessages(messages, chatRoomId);
    } else {
      print("Ingrese un mensaje");
    }
  }

  Future uploadImage(String chatRoomId, UserModel userData,
      UserModel currentUserData, File? imageFile) async {
    String fileName = Uuid().v1();
    int status = 1;

    await database.onSendImage(
      chatRoomId,
      currentUserData.fullName,
      fileName,
    );

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await database.onSendImageError(chatRoomId, fileName);

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await database.onSendImageSuccess(chatRoomId, fileName, imageUrl);

      notification.sendPushNotificationImage(
          userData.userId, currentUserData.fullName);

      log(imageUrl);
    }
  }
}
