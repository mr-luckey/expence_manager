import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
  elevation: 5,
  foregroundColor: Colors.white,
  backgroundColor: Colors.blue[900],
  disabledBackgroundColor: Colors.grey,
  disabledForegroundColor: Colors.white,
  side: BorderSide(color: Colors.blue.shade900, width: 1),
  padding: EdgeInsets.symmetric(vertical: 18),
  textStyle: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 16,
      color: Colors.red,
      fontWeight: FontWeight.w600),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
));
final darkElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
  elevation: 5,
  foregroundColor: Colors.white,
  backgroundColor: Colors.white,
  disabledBackgroundColor: Colors.white,
  disabledForegroundColor: Colors.white,
  side: BorderSide(color: Colors.white, width: 1),
  padding: EdgeInsets.symmetric(vertical: 18),
  textStyle: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 16,
      color: Colors.blue[900],
      fontWeight: FontWeight.w600),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
));
