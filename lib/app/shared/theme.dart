import 'package:flutter/material.dart';
import 'package:tech_task/app/shared/helpers/color_constants.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: whiteColor,
  fontFamily: 'Raleway',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFFF2F2F2),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: whiteColor,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: whiteColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: whiteColor,
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: whiteColor,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: whiteColor,
      fontSize: 20,
      // fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: whiteColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(color: whiteColor, fontSize: 16),
    bodyMedium: TextStyle(color: whiteColor, fontSize: 14),
    titleMedium: TextStyle(color: whiteColor, fontSize: 16),
    titleSmall: TextStyle(color: whiteColor, fontSize: 14),
  ),
);
