import 'package:a_im/models/chat.dart';
import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/chat/chat_screen.dart';
import 'package:a_im/shared/constants.dart';
import 'package:a_im/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:a_im/models/chat.dart';

/*
  List all chats of the given user
 */

class ChatsList extends StatefulWidget {
  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    final List<Chat> chats = Provider.of<List<Chat>>(context);

    if (chats == null) {
      return Loading();
    }

    if (chats.isEmpty) {
      return Center(child: Text("You don't have chats. You can start a new chat with any user."));
    }

    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ChatScreen(chat: chats.elementAt(index))));
                },
                title: Text(User().getOtherUser(chats.elementAt(index).participants).displayName.toString()),
                subtitle: Text(chats.elementAt(index).id),
                leading: CircleAvatar(),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            itemCount: chats.length,
          )
        ],
      ),
    );
  }
}
