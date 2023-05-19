import 'dart:developer';

import 'package:emplolance/features/messaging/models/chat_model.dart';
import 'package:emplolance/features/messaging/repository/chat_repository.dart';
import 'package:get/get.dart';

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
}
