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

  @override
  Widget build(BuildContext context) {
    final List<Message> messages = Provider.of<List<Message>>(context);
    return messages != null
        ? Container(
            child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => MessageTile(message: messages.elementAt(index)),
            itemCount: messages.length,
          ))
        : Loading();
  }
}
