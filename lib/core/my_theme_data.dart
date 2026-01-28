import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Color(0xFF7B7B7B),
      secondary: Colors.black,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFFF2FEFF),
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      displayLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.blue,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    appBarTheme: AppBarTheme(centerTitle: true),
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Color(0xFF7B7B7B),
      secondary: Colors.black,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFF101127),
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      displayLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.blue,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    appBarTheme: AppBarTheme(centerTitle: true),
  );
}