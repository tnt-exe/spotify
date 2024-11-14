import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: "Satoshi",
    indicatorColor: AppColors.grey,
    tabBarTheme: TabBarTheme(
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateColor.resolveWith(
        (_) => Colors.grey.shade300,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(30),
      hintStyle: const TextStyle(
        color: Color(0xff383838),
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 0.4,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 0.4,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        overlayColor: Colors.transparent,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: Colors.grey,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.darkGrey,
      behavior: SnackBarBehavior.floating,
      contentTextStyle: TextStyle(
        color: AppColors.lightBackground,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBackground,
      thickness: 0.5,
      space: 50,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.blue,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      surfaceTintColor: Colors.transparent,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: "Satoshi",
    indicatorColor: Colors.black12,
    tabBarTheme: TabBarTheme(
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateColor.resolveWith(
        (_) => Colors.grey.shade900,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(30),
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 0.4,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 0.4,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        overlayColor: Colors.transparent,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        overlayColor: Colors.grey,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.grey,
      behavior: SnackBarBehavior.floating,
      contentTextStyle: TextStyle(
        color: AppColors.darkBackground,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.lightBackground,
      thickness: 0.5,
      space: 50,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.blue,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      surfaceTintColor: Colors.transparent,
    ),
  );
}
