import 'package:flutter/material.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';

final ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: AllColors.primaryColor,
  scaffoldBackgroundColor: AllColors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AllColors.white,
    iconTheme: IconThemeData(color: AllColors.black),
    titleTextStyle: TextStyle(
      color: AllColors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AllColors.black),
    titleLarge: TextStyle(
      color: AllColors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AllColors.primaryColor,
    foregroundColor: AllColors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AllColors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AllColors.primaryColor,
  scaffoldBackgroundColor: AllColors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: AllColors.black,
    iconTheme: IconThemeData(color: AllColors.white),
    titleTextStyle: TextStyle(
      color: AllColors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AllColors.white),
    titleLarge: TextStyle(
      color: AllColors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AllColors.primaryColor,
    foregroundColor: AllColors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black87,
  ),
  cardTheme: CardTheme(
    color: const Color(0xff1E1E1E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
