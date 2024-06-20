import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme lightTextTheme = TextTheme(
  headlineLarge: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black),
  headlineMedium: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.black),
  headlineSmall: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Colors.black),
  labelMedium: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black.withOpacity(0.5)),
  labelSmall: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Colors.black.withOpacity(0.5)),
);

TextTheme darkTextTheme = TextTheme(
  headlineLarge: const TextStyle().copyWith(
    fontFamily: GoogleFonts.poppins().fontFamily,

    fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white,
    // fontFamily: GoogleFonts.poppins().fontFamily,
  ),
  headlineMedium: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.white),
  headlineSmall: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Colors.white),
  labelMedium: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white.withOpacity(0.5)),
  labelSmall: const TextStyle().copyWith(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: Colors.white.withOpacity(0.5)),
);
