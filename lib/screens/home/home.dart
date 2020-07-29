import 'package:a_im/screens/home/drawer.dart';
import 'package:a_im/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final user;
  Home({this.user});

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    void signOut() {
      _auth.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('aIM'),
        elevation: 0.0,
      ),
      drawer: HomeDrawer(signOut: signOut),
      body: Container(
        child: Column(
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
