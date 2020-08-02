import 'package:a_im/models/chat.dart';
import 'package:a_im/models/message.dart';
import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/chat/chat_messages_list.dart';
import 'package:a_im/screens/home/chat/message_input.dart';
import 'package:a_im/services/auth.dart';
import 'package:a_im/services/chat.dart';
import 'package:a_im/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  Open chat screen for given chat, as result from tapping on in in the chats_list.dart
 */

class ChatScreen extends StatefulWidget {
  final Chat chat;
  User otherUser;
  User currentUser;

  ChatScreen({this.chat}) {
    otherUser = User().getOtherUser(chat.participants);
    currentUser = CURRENT_USER;

    print("Current user: ${currentUser.displayName}");
    print("Other user: ${otherUser.displayName}");
  }

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
//  final _newMessageController = TextEditingController();
//
//  void _sendMessage(String message) async {
//    await ChatService().sendMessageFromOneUserToAnother(message, widget.currentUser, widget.otherUser, widget.chat.id);
//  }

  bool typedText = false;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Message>>.value(
      value: ChatService().getChatMessages(widget.chat.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.otherUser.displayName),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ChatMessages(),
              fit: FlexFit.tight,
            ),
            Divider(),
            MessageInput(
              currentUser: widget.currentUser,
              otherUser: widget.otherUser,
              chat: widget.chat,
            )
          ],
        ),
      ),
    );
  }
}
