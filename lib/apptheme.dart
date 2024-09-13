import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appcolor.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: appcolor.primarycolor,
    scaffoldBackgroundColor: appcolor.bglcolor,
    appBarTheme: const AppBarTheme(
      backgroundColor: appcolor.primarycolor,
      elevation: 0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appcolor.whitecolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: appcolor.primarycolor, width: 2),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: appcolor.whitecolor),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.bold, color: appcolor.bdcolor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: appcolor.primarycolor,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: appcolor.primarycolor,
      shape: StadiumBorder(
        side: BorderSide(color: appcolor.whitecolor, width: 6),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: appcolor.primarycolor,
    scaffoldBackgroundColor: appcolor.bgdcolor,
    appBarTheme: const AppBarTheme(
      backgroundColor: appcolor.primarycolor,
      elevation: 0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appcolor.bgdcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: appcolor.primarycolor, width: 2),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
          fontSize: 22, fontWeight: FontWeight.bold, color: appcolor.whitecolor),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: appcolor.bc),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: appcolor.primarycolor,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: appcolor.primarycolor,
      shape: StadiumBorder(
        side: BorderSide(color: appcolor.whitecolor, width: 6),
      ),
    ),
  );
}
