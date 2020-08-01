import 'package:a_im/models/user.dart';
import 'package:flutter/material.dart';


// authenticate
const int MIN_PASSWORD_LENGTH = 8;
User CURRENT_USER = null;

const TEXT_INPUT_DECORATION = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2)),
);

final BACKGROUND_CONTAINER_COLOR = Colors.grey[200];
final APPBAR_COLOR = Colors.grey[900];