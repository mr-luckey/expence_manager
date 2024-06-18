import 'package:flutter/material.dart';

class ElevatedBtnTheme {
  ElevatedBtnTheme._();
  static final lightElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 5,
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue[900],
    disabledBackgroundColor: Colors.grey,
    disabledForegroundColor: Colors.white,
    side: BorderSide(color: Colors.blue.shade900, width: 1),
    padding: EdgeInsets.symmetric(vertical: 18),
    textStyle: TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
  static final darkElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 5,
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue[900],
    disabledBackgroundColor: Colors.grey,
    disabledForegroundColor: Colors.white,
    side: BorderSide(color: Colors.blue.shade900, width: 1),
    padding: EdgeInsets.symmetric(vertical: 18),
    textStyle: TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
}
