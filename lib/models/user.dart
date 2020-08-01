import 'dart:convert';

import 'package:a_im/services/auth.dart';
import 'package:a_im/shared/constants.dart';

class User {
  final String uid;
  final String displayName;
  final String email;

  User({this.uid, this.displayName, this.email});

  Map toJSON() {
    return {'uid': this.uid, 'displayName': this.displayName, 'email': this.email};
  }

  User fromJSON(Map jsonString) {
    return User(uid: jsonString['uid'], displayName: jsonString['displayName'], email: jsonString['email']);
  }

  User getOtherUser(List<User> users) {
//    User otherUser = AuthService().getCurrentUserId().toString() != users[0].uid ? users[1] : users[0];
    User otherUser = CURRENT_USER.uid.toString() == users[0].uid ? users[1] : users[0];
    return otherUser;
//    return AuthService().getCurrentUserId().toString() == users[0].uid ? users[1] : users[0];
  }

  User getCurrentUser(List<User> users) {
    return AuthService().getCurrentUserId().toString() == users[0].uid ? users[0] : users[1];
  }
}
