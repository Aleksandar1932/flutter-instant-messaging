import 'package:a_im/models/message.dart';
import 'package:a_im/screens/home/chat/message_tile.dart';
import 'package:a_im/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  Widget  for building the messages
 */

class ChatMessages extends StatefulWidget {
  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    _scrollController.animateTo(
      1000000 ?? 0.00,
      duration: new Duration(milliseconds: 10),
      curve: Curves.bounceIn,
    );
  }


  @override
  Widget build(BuildContext context) {
    final List<Message> messages = Provider.of<List<Message>>(context);

    return messages != null
        ? Container(
            child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (_scrollController.hasClients) {
                scrollToBottom();
              }
              return MessageTile(
                message: messages.elementAt(index),
              );
            },
            itemCount: messages.length,
          ))
        : Loading();
  }
}
