import 'package:a_im/models/chat.dart';
import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/search/chat_screen.dart';
import 'package:a_im/shared/constants.dart';
import 'package:a_im/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_im/models/chat.dart';

class ChatsList extends StatefulWidget {
  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    print("Current user ${CURRENT_USER.displayName}");
    final List<Chat> chats = Provider.of<List<Chat>>(context);
    return chats != null ? Container(
      child: Column(
        children: <Widget>[
//          Text()
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
    ) : Loading();
  }
}
