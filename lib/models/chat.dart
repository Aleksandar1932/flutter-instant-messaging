import 'package:a_im/models/message.dart';

class Chat {
  String participant1;
  String participant2;
  List<Message> messages;

  Chat({this.participant1, this.participant2}) {
    messages = List<Message>(); // no messages initially
  }
}
