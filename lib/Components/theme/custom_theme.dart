import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme._();
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black),
    labelMedium: TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.5)),
    labelSmall: TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        color: Colors.black.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.white),
    labelMedium: TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.5)),
    labelSmall: TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        color: Colors.white.withOpacity(0.5)),
  );
}
