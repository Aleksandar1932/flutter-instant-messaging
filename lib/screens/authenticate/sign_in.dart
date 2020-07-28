import 'package:a_im/services/auth.dart';
import 'package:a_im/shared/constants.dart';
import 'package:a_im/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: APPBAR_COLOR,
              title: Text('Sign In'),
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Container(
              color: BACKGROUND_CONTAINER_COLOR,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextFormField(
                              validator: (value) => value.isEmpty ? "Enter an e-mail" : null,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              decoration: TEXT_INPUT_DECORATION.copyWith(hintText: "e-mail"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextFormField(
                              validator: (value) => value.length < MIN_PASSWORD_LENGTH
                                  ? "Password must be at least $MIN_PASSWORD_LENGTH characters"
                                  : null,
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              decoration: TEXT_INPUT_DECORATION.copyWith(hintText: "Password"),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                // true -> form is valid
                                dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                                if (result == null) {
                                  setState(() {
                                    error = "Please supply valid credentials!";
                                    loading = false;
                                  });
                                }
                              } else {
                                // false -> form is invalid
                              }
                            },
                            color: Colors.pink[400],
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
