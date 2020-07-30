import 'dart:convert';

class User {
  final String uid;
  final String displayName;
  final String email;

  User({this.uid, this.displayName, this.email});

  Map toJSON() {
    return {'uid': this.uid, 'displayName': this.displayName, 'email': this.email};
  }
}
