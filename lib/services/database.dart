import 'package:a_im/models/chat.dart';
import 'package:a_im/models/message.dart';
import 'package:a_im/models/user.dart';
import 'package:a_im/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // users collection reference
  final CollectionReference usersCollection = Firestore.instance.collection("users");
  final CollectionReference chatsCollection = Firestore.instance.collection("chats");

  List<Chat> _chatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Chat(
            id: doc.documentID,
            participants: [User().fromJSON(doc.data['participants'][0]), User().fromJSON(doc.data['participants'][1])],
            messages: null))
        .toList();
  }

  // streams
  Stream<List<Chat>> getUserChats(User user) {
    return chatsCollection.where("participantsIDs", arrayContains: user.uid).snapshots().map(_chatListFromSnapshot);
  }

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

  Future startNewChatWithUser(User otherUser) async {
    User currentUser = await AuthService().getCurrentUser();

    DocumentReference chatsDocumentReference = await chatsCollection.add({
      "participants": [otherUser.toJSON(), await AuthService().getCurrentUser().then((value) => value.toJSON())],
      "participantsIDs": [otherUser.uid, await AuthService().getCurrentUser().then((value) => value.uid)],
      "messages": [],
    });

    await addChatToUser(chatsDocumentReference.documentID, otherUser.uid);
    await addChatToUser(chatsDocumentReference.documentID, currentUser.uid);
    return chatsDocumentReference;
  }

  Future addChatToUser(String chatID, String userID) async {
    return usersCollection.document(userID).updateData({
      'chats': FieldValue.arrayUnion(['$chatID'])
    });
  }
}
