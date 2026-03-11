import 'package:flutter/material.dart';
import 'light_color.dart';

class AppTheme {
  const AppTheme();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // ===== COLOR SYSTEM =====
    colorScheme: ColorScheme.fromSeed(
      seedColor: LightColor.navyBlue1,
      brightness: Brightness.light,
    ).copyWith(
      background: LightColor.background,
      surface: LightColor.navyBlue2,
    ),

    scaffoldBackgroundColor: LightColor.background,
    primaryColor: LightColor.navyBlue1,

    // ===== CARD THEME =====
    cardTheme: CardThemeData(
      color: LightColor.navyBlue2,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // ===== TEXT THEME =====
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: LightColor.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: LightColor.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: LightColor.titleTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: LightColor.titleTextColor,
      ),
    ),

    // ===== ICON THEME =====
    iconTheme: const IconThemeData(
      color: LightColor.bcaBlue,
    ),

    // ===== BOTTOM APP BAR =====
    bottomAppBarTheme: const BottomAppBarThemeData(
      elevation: 0,
    ),

    dividerColor: LightColor.lightGrey,
  );

  // ===== CUSTOM STYLES (for old usage compatibility) =====

  static const TextStyle titleStyle =
      TextStyle(color: LightColor.titleTextColor, fontSize: 16);

  static const TextStyle subTitleStyle =
      TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static const TextStyle h1Style =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle h2Style =
      TextStyle(fontSize: 22);

  static const TextStyle h3Style =
      TextStyle(fontSize: 20);

  static const TextStyle h4Style =
      TextStyle(fontSize: 18);

  static const TextStyle h5Style =
      TextStyle(fontSize: 16);

  static const TextStyle h6Style =
      TextStyle(fontSize: 14);
}
