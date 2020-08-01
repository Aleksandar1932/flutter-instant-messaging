import 'package:a_im/models/chat.dart';
import 'package:a_im/models/message.dart';
import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/chat_messages_list.dart';
import 'package:a_im/services/auth.dart';
import 'package:a_im/services/chat.dart';
import 'package:a_im/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _newMessageController = TextEditingController();

  void _sendMessage(String message) async {
    await ChatService().sendMessageFromOneUserToAnother(message, widget.currentUser, widget.otherUser, widget.chat.id);
  }

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
            SingleChildScrollView(child: ChatMessages()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _newMessageController,
                      onSubmitted: _sendMessage,
                      decoration: InputDecoration.collapsed(hintText: 'Send a message'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        _sendMessage(_newMessageController.text);
                      },
//                    onPressed: () => _handleSubmitted(_textController.text)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
