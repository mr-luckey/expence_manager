import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class themeAppbar {
  themeAppbar._();
  static final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.blue.shade900, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.blue.shade900, size: 24),
    titleTextStyle: TextStyle(
      color: Colors.blue.shade900,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  );
  static final darkAppbarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w600,
    ),
  );
}
