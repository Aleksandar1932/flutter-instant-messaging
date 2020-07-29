import 'package:a_im/models/user.dart';
import 'package:a_im/screens/home/search/found_users_list.dart';
import 'package:a_im/services/database.dart';
import 'package:a_im/shared/constants.dart';
import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {



  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String searchQuery = '';
  List<User> foundUsers = List<User>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search users'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) => value.isEmpty ? "Please enter a search query" : null,
                      onChanged: (value) {
                        searchQuery = value;
                      },
                      decoration: TEXT_INPUT_DECORATION.copyWith(labelText: 'Search by email or username'),
                    ),
                  ),
                  FlatButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // form is valid
                          List<User> result = await _databaseService.findUserByEmail(searchQuery);

                          if (result.isNotEmpty) {
                            setState(() {
                              foundUsers = result;
                            });
                          } else {
                            setState(() {
                              foundUsers = List<User>();
                            });
                          }
                        } else {
                          // form is invalid
                        }
                      },
                      icon: Icon(Icons.search),
                      label: Text('Search')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FoundUsersList(
                users: foundUsers,
              ),
            )
          ],
        ),
      ),
    );
  }
}
