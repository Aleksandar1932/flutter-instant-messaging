import 'package:a_im/models/message.dart';
import 'package:a_im/shared/constants.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  Message message;

  MessageTile({this.message}) {}

  @override
  Widget build(BuildContext context) {
    bool isFromCurrentUser;
    if (message.sender.uid == CURRENT_USER.uid) {
      isFromCurrentUser = true;
    } else {
      isFromCurrentUser = false;
    }

    return Container(
      margin: isFromCurrentUser ? EdgeInsets.fromLTRB(100, 5, 10, 5) : EdgeInsets.fromLTRB(10, 5, 100, 5) ,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isFromCurrentUser ? Colors.white : Colors.pink[100],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isFromCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(message.body, style: TextStyle(fontSize: 16),),
          SizedBox(height: 5,),
          Text(message.getLocalTimeFromTimestamp(), style: TextStyle(fontSize: 12),)
        ],
      ),
    );
  }
}
