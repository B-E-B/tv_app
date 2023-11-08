import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData defaults() {
    const mainFontFamily = 'TTNormsPro';

    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 25,
        ),
        titleMedium: const TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.white,
          height: 1.5,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 20,
        ),
        titleSmall: const TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 14,
        ),
        labelMedium: TextStyle(
          fontFamily: mainFontFamily,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontSize: 26,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.white,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Archivo',
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontSize: 180,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.white,
        ),
      ),
    );
  }
}
