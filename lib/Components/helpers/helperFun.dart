import 'package:flutter/material.dart';

class THelper {
  THelper._();
  static bool isDrkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
