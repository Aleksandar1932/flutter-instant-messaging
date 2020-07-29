import 'package:a_im/screens/wrapper.dart';
import 'package:a_im/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      //provide listener for auth change
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
//          primarySwatch: Colors.grey[900],
        primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Color(0xFFDCDCDC),
        ),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
