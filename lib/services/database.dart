import 'package:a_im/models/user.dart';
import 'package:a_im/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // users collection reference
  final CollectionReference usersCollection = Firestore.instance.collection("users");
  final CollectionReference chatsCollection = Firestore.instance.collection("chats");

  // Users collection methods
  Future addUserToCollection(FirebaseUser user) async {
    try {
      return await usersCollection.document(user.uid).setData({'email': user.email, 'displayName': user.displayName});
    } catch (e) {
      return null;
    }
  }

  Future findUserByEmail(String email) async {
    return await usersCollection.where('email', isEqualTo: email).getDocuments().then((value) => value.documents
        .map((e) => User(uid: e.documentID, email: e.data['email'], displayName: e.data['displayName']))
        .toList());
  }

  // Chats collection methods
  Future startNewChatBetweenTwoUsers(String participant1, String participant2) async {
    return await chatsCollection.add({
      "participant1": participant1,
      "participant2": await AuthService().getCurrentUserId().then((value) => value.toString()),
    });
  }

  Future startNewChatWithUser(String otherUserId) async{
    return await chatsCollection.add({
      "participant1": otherUserId,
      "participant2": await AuthService().getCurrentUserId().then((value) => value.toString()),
    });
  }
}
