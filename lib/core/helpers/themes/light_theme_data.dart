import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
ThemeData lightThemeData() => ThemeData(
  primaryColor: AppColorsLight.mainColor,

  scaffoldBackgroundColor: AppColorsLight.appBgColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsLight.whiteColor,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColorsLight.appBgColor,
    selectedItemColor: AppColorsLight.mainColor,
    unselectedItemColor: Colors.black87,
    selectedLabelStyle: TextStyle(
      color: AppColorsLight.mainColor,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    ),
  ),
);
