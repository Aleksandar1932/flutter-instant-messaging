import 'dart:convert';

import 'package:a_im/models/user.dart';

class Message {
  String chatId;
  User sender;
  User receiver;
  String body;
  DateTime timestamp;

  Message({this.chatId, this.sender, this.receiver, this.body, this.timestamp});

  Map toJSON() {
    return {
      'chatId': this.chatId,
      'sender': this.sender.toJSON(),
      'receiver': this.receiver.toJSON(),
      'body': this.body,
      'timestamp': this.timestamp.toIso8601String()
    };
  }

  Message fromJSON(Map jsonString) {
    return Message(
      chatId: jsonString['chatId'],
      sender: User().fromJSON(jsonString['sender']),
      receiver: User().fromJSON(jsonString['receiver']),
      body: jsonString['body'],
      timestamp: DateTime.parse(jsonString['timestamp']),
    );
  }

  String getLocalTimeFromTimestamp() {
    return "${this.timestamp.hour.toString()}"
        ":${this.timestamp.minute.toString()}"
        ":${this.timestamp.second.toString()}";
  }
}
