import 'package:a_im/models/message.dart';
import 'package:a_im/models/user.dart';

class Chat {
//  User participant1;
//  User participant2;
  String id;
  List<User> participants;
  List<Message> messages;

//  Chat({this.participant1, this.participant2}) {
//    messages = List<Message>(); // no messages initially
//  }
  Chat({this.id, this.participants, this.messages}) {}


}
