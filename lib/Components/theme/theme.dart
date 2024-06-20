import 'package:expence_manager/Components/theme/appbar.dart';
import 'package:expence_manager/Components/theme/btnTheme.dart';
import 'package:expence_manager/Components/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.blue.shade900,
    secondary: Colors.blue.shade900,
    error: Colors.red.shade900,
    background: Colors.white,
  ),
  // primaryColor: Colors.blue[900],
  // scaffoldBackgroundColor: Colors.white,
  textTheme: lightTextTheme,
  elevatedButtonTheme: lightElevatedButton,
  appBarTheme: themeAppbar.lightAppBarTheme,
);
ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.dark(
        primary: Colors.blue.shade900,
        secondary: Colors.blue.shade900,
        error: Colors.red.shade900,
        background: Colors.blue.shade900),
    brightness: Brightness.dark,
    // primaryColor: Colors.blue[900],
    // scaffoldBackgroundColor: Colors.black,
    textTheme: darkTextTheme,
    elevatedButtonTheme: darkElevatedButton,
    appBarTheme: themeAppbar.darkAppbarTheme);
