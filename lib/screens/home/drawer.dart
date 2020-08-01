import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/home.dart';
import 'package:a_im/shared/constants.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final Function signOut;
  final User user;

  HomeDrawer({this.signOut, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text('UserPhoto'),
                radius: 30,
              ),
            ),
            decoration: BoxDecoration(
              color: APPBAR_COLOR,
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Text('${user.displayName}',style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Text('${user.email}',style: TextStyle(fontSize: 12),),
              ],
            ),
          ),
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account Settings'),
            onTap: () {
              // Update the state of the app.
              signOut();
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Update the state of the app.
              signOut();
              // ...
            },
          ),
        ],
      ),
    );
  }
}
