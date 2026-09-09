import 'package:flutter/material.dart';

class AppColors {
  static const paper = Color(0xFFF3EFE4);
  static const paperDeep = Color(0xFFE9E2D2);
  static const displayBox = Color(0xFFFCFAF3);
  static const ink = Color(0xFF33302A);
  static const inkFaded = Color(0xFF6B6358);
  static const moss = Color(0xFF5B6B4F);
  static const mossLight = Color(0xFFDCE3D3);
  static const clay = Color(0xFFB2542C);
}

const String kAppFont = 'OpenDyslexic3';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: kAppFont,
  scaffoldBackgroundColor: AppColors.paper,

  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.moss),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.paper,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: kAppFont,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.moss,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      textStyle: const TextStyle(
        fontFamily: kAppFont,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.displayBox,
    hintStyle: const TextStyle(fontFamily: kAppFont, color: AppColors.inkFaded),
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.paperDeep, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.paperDeep, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.moss, width: 1.5),
    ),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.moss,
    inactiveTrackColor: AppColors.paperDeep,
    thumbColor: AppColors.moss,
    overlayColor: AppColors.mossLight,
  ),

  cardTheme: CardThemeData(
    color: AppColors.paperDeep,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),

  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontFamily: kAppFont,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
      height: 1.3,
    ),
    titleLarge: TextStyle(
      fontFamily: kAppFont,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    bodyLarge: TextStyle(
      fontFamily: kAppFont,
      fontSize: 17,
      height: 1.5,
      color: AppColors.inkFaded,
    ),
    bodyMedium: TextStyle(
      fontFamily: kAppFont,
      fontSize: 15,
      height: 1.4,
      color: AppColors.inkFaded,
    ),
  ),
);