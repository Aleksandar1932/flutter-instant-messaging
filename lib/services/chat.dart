import 'dart:convert';

import 'package:a_im/models/message.dart';
import 'package:a_im/models/user.dart';
import 'package:a_im/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatService {
  final CollectionReference chatsCollection = Firestore.instance.collection("chats");

  // get chat messages stream
  Stream<List<Message>> getChatMessages(String chatId) {
    return chatsCollection.document(chatId).snapshots().map((document) {
      List<Message> retList = [];
      for (var a in document.data['messages']) {
        retList.add(Message().fromJSON(a));
      }
      return retList;
    });
  }

  // Send message
  Future sendMessageFromOneUserToAnother(String messageBody, User sender, User receiver, String chatId) async {
    Message newMessage = Message(
      chatId: chatId,
      sender: sender,
      receiver: receiver,
      body: messageBody,
      timestamp: DateTime.now(),
    );

    return await chatsCollection.document(chatId).updateData({
      'messages': FieldValue.arrayUnion([newMessage.toJSON()])
    });
  }

  // Implement deleteChat method
  Future deleteChat(String chatId) async {
    try {
      return await chatsCollection.document(chatId).delete();
    } catch (e) {
      print("[deleteChat] - $e");
    }
  }

  // Get latest message from given chat
  Future getLatestChatMessage(String chatId) async {
    return "Latest message";
  }
}
