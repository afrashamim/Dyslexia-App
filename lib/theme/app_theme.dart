import 'package:flutter/material.dart';

class AppColors {
  static const skyMist = Color(0xFFEAF6FF);
  static const readingPaper = Color(0xFFFFF9EC);
  static const ink = Color(0xFF241F3D);       // darker now
  static const inkFaded = Color(0xFF524A72);  // darker now
  static const sunshine = Color(0xFFFFD166);
  static const coral = Color(0xFFFF6F59);
  static const grass = Color(0xFF06D6A0);
  static const grape = Color(0xFF7C77B9);
}

const String kAppFont = 'OpenDyslexic3';

final TextTheme _dyslexicTextTheme = const TextTheme(
  displayLarge: TextStyle(fontFamily: kAppFont),
  displayMedium: TextStyle(fontFamily: kAppFont),
  displaySmall: TextStyle(fontFamily: kAppFont),
  headlineLarge: TextStyle(fontFamily: kAppFont),
  headlineMedium: TextStyle(
    fontFamily: kAppFont,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    height: 1.3,
  ),
  headlineSmall: TextStyle(fontFamily: kAppFont),
  titleLarge: TextStyle(
    fontFamily: kAppFont,
    fontSize: 19,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
  ),
  titleMedium: TextStyle(fontFamily: kAppFont),
  titleSmall: TextStyle(fontFamily: kAppFont),
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
  bodySmall: TextStyle(fontFamily: kAppFont),
  labelLarge: TextStyle(fontFamily: kAppFont),
  labelMedium: TextStyle(fontFamily: kAppFont),
  labelSmall: TextStyle(fontFamily: kAppFont),
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: kAppFont,
  scaffoldBackgroundColor: AppColors.skyMist,

  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.grape),

  textTheme: _dyslexicTextTheme,
  primaryTextTheme: _dyslexicTextTheme,

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.skyMist,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: kAppFont,
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.sunshine,
      foregroundColor: AppColors.ink,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      textStyle: const TextStyle(
        fontFamily: kAppFont,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.readingPaper,
    hintStyle: const TextStyle(fontFamily: kAppFont, color: AppColors.inkFaded),
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: AppColors.grape, width: 2),
    ),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.sunshine,
    inactiveTrackColor: AppColors.readingPaper,
    thumbColor: AppColors.coral,
  ),
);