import 'package:a_im/models/user.dart';
import 'package:a_im/screens/authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // listener for auth state
    if (user == null) {
      return Authenticate();
    } else {
      return Home(user: user,);
    }
  }
}
