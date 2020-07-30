import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/search/found_user_tile.dart';
import 'package:flutter/material.dart';

class FoundUsersList extends StatelessWidget {
  List<User> users;

  FoundUsersList({this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        // Let the ListView know how many items it needs to build.
        itemCount: users.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final User item = users[index];

          return FoundUserTile(user: item);
        },
      );
    } else {
      return Text('No users found!');
    }
  }
}
