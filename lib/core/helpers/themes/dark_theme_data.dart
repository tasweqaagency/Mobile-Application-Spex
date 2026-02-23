import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';

ThemeData darkThemeData() => ThemeData(
  primaryColor: AppColorsDark.mainColor,
  scaffoldBackgroundColor: AppColorsDark.appBgColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsDark.appBgColor,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColorsDark.appBgColor,
    selectedItemColor: AppColorsDark.mainColor,
    unselectedItemColor: Colors.white70,
    selectedLabelStyle: TextStyle(
      color: AppColorsDark.mainColor,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.normal,
    ),
  ),
);
