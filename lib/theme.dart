import 'package:flutter/material.dart';

// Brand colours used everywhere in the app (consistency).
const Color kPrimary = Color(0xFF2E7D32); // green = food / fresh / SDG 2
const Color kAccent = Color(0xFFFF8F00); // orange = call to action

// ThemeData is defined ONCE here and applied in main.dart (MaterialApp theme:).
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimary,
    secondary: kAccent,
  ),
  scaffoldBackgroundColor: const Color(0xFFF6FBF4),
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimary,
    foregroundColor: Colors.white,
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1B5E20),
    ),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 15),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimary,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
