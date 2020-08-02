import 'package:a_im/models/chat.dart';
import 'package:a_im/models/user.dart';
import 'package:flutter/material.dart';
import 'package:a_im/services/chat.dart';

class MessageInput extends StatefulWidget {
  final User currentUser;
  final User otherUser;
  final Chat chat;

  MessageInput({this.currentUser, this.otherUser, this.chat});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _newMessageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool typedText = false;

  void _sendMessage(String message) async {
    await ChatService().sendMessageFromOneUserToAnother(message, widget.currentUser, widget.otherUser, widget.chat.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  key: _formKey,
                  controller: _newMessageController,
                  onSubmitted: _sendMessage,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        typedText = true;
                      });
                    } else {
                      setState(() {
                        typedText = false;
                      });
                    }
                  },
                  decoration: InputDecoration.collapsed(hintText: 'Send a message from widgets'),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(Icons.send, color: typedText ? Colors.pink : Colors.grey),
                    onPressed: typedText
                        ? () async {
                            if (_newMessageController.text.isNotEmpty) {
                              _sendMessage(_newMessageController.text);
                            }

                            setState(() {
                              _newMessageController.clear();
                              typedText = false;
                            });
                          }
                        : null),
              )
            ],
          ),
        ),
      ],
    );
  }
}
