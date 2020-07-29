import 'package:a_im/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // users collection reference
  final CollectionReference usersCollection = Firestore.instance.collection("users");

  Future addUserToCollection(FirebaseUser user) async {
    try {
      return await usersCollection.document(uid).setData({'email': user.email, 'displayName': user.displayName});
    } catch (e) {
      return null;
    }
  }
}
