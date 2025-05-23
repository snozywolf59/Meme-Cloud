import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF6E44FF),
  primarySwatch: Colors.indigo,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF6E44FF),
    secondary: Colors.indigo,
    surface: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF6E44FF),
    foregroundColor: Colors.white,
    focusColor: Colors.white,
    hoverColor: Colors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 1,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: EdgeInsets.all(16),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
  iconTheme: IconThemeData(color: Colors.cyan[700]),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    contentPadding: EdgeInsets.all(25.0),
  ),
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF6E44FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(16),
    ),
  ),
);
