import 'package:a_im/models/chat.dart';
import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/chats_list.dart';
import 'package:a_im/screens/home/drawer.dart';
import 'package:a_im/screens/home/search_user.dart';
import 'package:a_im/services/auth.dart';
import 'package:a_im/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_im/shared/constants.dart';

class Home extends StatelessWidget {
  final User user;

  Home({this.user}) {
    CURRENT_USER = user;
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    void signOut() {
      _auth.signOut();
    }

    return StreamProvider<List<Chat>>.value(
      value: DatabaseService().getUserChats(user),
      child: Scaffold(
        appBar: AppBar(
          title: Text('aIM'),
          elevation: 0.0,
        ),
        drawer: HomeDrawer(signOut: signOut, user: user),
        body: Container(
          child: Column(
            children: <Widget>[ChatsList()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchUser()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
