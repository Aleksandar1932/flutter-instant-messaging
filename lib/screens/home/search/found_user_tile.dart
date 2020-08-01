import 'package:a_im/models/user.dart';
import 'package:a_im/services/auth.dart';
import 'package:a_im/services/database.dart';
import 'package:flutter/material.dart';

class FoundUserTile extends StatelessWidget {
  final User user;

  FoundUserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text(user.displayName),
      subtitle: Text(user.email),
      trailing: Icon(Icons.chat),
      onTap: () async {
        await DatabaseService().startNewChatWithUser(user);
        Navigator.pop(context);
      },
    );
  }
}
