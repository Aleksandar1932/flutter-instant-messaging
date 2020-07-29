import 'package:a_im/models/user.dart';
import 'package:a_im/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // TODO: Instead of try-catch blocks throw desired exceptions and catch them in the frontend (screens)
  final FirebaseAuth _auth = FirebaseAuth.instance; // get FirebaseAuth instance

  // convert FirebaseUser to User (custom user class)
  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, displayName: user.displayName, email: user.email) : null;
  }

  // user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser); // simpler way to accomplish the mapping
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print("[signInAnon]: $e");
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("[signOut]: $e");
      return null;
    }
  }

  // sign up a user with email, password and display name
  Future signUpWithEmailPasswordAndDisplayName(String email, String password, String displayName) async {
    try {
      // register the user on firebase
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // add the display info
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = displayName;
      await user.updateProfile(updateInfo);
      await user.reload();
      user = await _auth.currentUser();

      DatabaseService().addUserToCollection(user);
      return _userFromFireBaseUser(user);
    } catch (e) {
      print("[signUpWithEmailPasswordAndDisplayName]: $e");
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFireBaseUser(user);
    } catch (e) {
      print("[signInWithEmailAndPassword]: $e");
      return null;
    }
  }
}
