import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        color: const Color.fromRGBO(0, 0, 0, 1).withAlpha(200),
      ),
    ),
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(7, 7, 7, 1),
      onPrimary: Color.fromRGBO(255, 255, 255, 1),
      secondary: Color.fromRGBO(84, 235, 255, 1),
      onSecondary: Color.fromRGBO(84, 235, 255, 1),
      error: Colors.red,
      onError: Colors.redAccent,
      surface: Color.fromRGBO(51, 246, 153, 1),
      onSurface: Color.fromRGBO(0, 0, 0, 1),
    ),
    fontFamily: 'Outfit',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(7, 7, 7, 1),
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(7, 7, 7, 1),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(7, 7, 7, 1),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      primary: Color.fromRGBO(51, 246, 153, 1),
      onPrimary: Color.fromRGBO(51, 246, 153, 1),
      secondary: Color.fromRGBO(84, 235, 255, 1),
      onSecondary: Color.fromRGBO(84, 235, 255, 1),
      error: Colors.red,
      onError: Colors.redAccent,
      surface: Color.fromRGBO(7, 7, 7, 1),
      onSurface: Color.fromRGBO(14, 14, 14, 1),
      brightness: Brightness.dark,
    ),
    fontFamily: 'Outfit',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        color: const Color.fromRGBO(255, 255, 255, 1).withAlpha(200),
      ),
    ),
  );
}
