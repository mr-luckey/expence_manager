import 'package:expence_manager/Components/theme/appbar.dart';
import 'package:expence_manager/Components/theme/btnTheme.dart';
import 'package:expence_manager/Components/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class Apptheme {
  Apptheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppnies',
    brightness: Brightness.light,
    primaryColor: Colors.blue[900],
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedBtnTheme.lightElevatedButton,
    appBarTheme: themeAppbar.lightAppBarTheme,
  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppnies',
      brightness: Brightness.dark,
      primaryColor: Colors.blue[900],
      scaffoldBackgroundColor: Colors.black,
      textTheme: CustomTheme.darkTextTheme,
      elevatedButtonTheme: ElevatedBtnTheme.darkElevatedButton,
      appBarTheme: themeAppbar.darkAppbarTheme);
}
