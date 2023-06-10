import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/messaging/models/chat_model.dart';
import 'package:emplolance/features/messaging/repository/chat_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../authentication/repository/user_repository.dart';

class ChatController extends GetxController {
  final ChatRepository database = ChatRepository();
  final _userRepo = Get.put(UserRepository());

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
      String chatRoomId) async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": userData.fullName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      return database.onSendMessages(messages, chatRoomId);
    } else {
      print("Ingrese un mensaje");
    }
  }

  Future uploadImage(
      String chatRoomId, String fullName, File? imageFile) async {
    String fileName = Uuid().v1();
    int status = 1;

    await database.onSendImage(
      chatRoomId,
      fullName,
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

      print(imageUrl);
    }
  }
}
