// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String userId1;
  final String userId2;
  final String chatId;
  const ChatModel({
    required this.userId1,
    required this.userId2,
    required this.chatId,
  });

  ChatModel copyWith({
    String? userId1,
    String? userId2,
    String? chatId,
  }) {
    return ChatModel(
      userId1: userId1 ?? this.userId1,
      userId2: userId2 ?? this.userId2,
      chatId: chatId ?? this.chatId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId1': userId1,
      'userId2': userId2,
      'chatId': chatId,
    };
  }

  factory ChatModel.fromSnapshot(DocumentSnapshot snap) {
    return ChatModel(
      userId1: snap['userId1'] as String,
      userId2: snap['userId2'] as String,
      chatId: snap['chatId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [userId1, userId2, chatId];
}
