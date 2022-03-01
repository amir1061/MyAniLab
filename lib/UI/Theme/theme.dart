import 'package:flutter/material.dart';

class MyAniLabTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6200EE),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: Colors.grey,
    ),
    cardColor: Colors.white,
    colorScheme: const ColorScheme(
      primary: Color(0xFF6200EE),
      primaryContainer: Color(0xFF3700B3),
      secondary: Color(0xFF03DAC6),
      secondaryContainer: Color(0xFF018786),
      surface: Colors.white,
      background: Colors.white,
      error: Color(0xFFB00020),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: Colors.grey,
    ),
    cardColor: const Color(0xFF1E1E1E),
    colorScheme: const ColorScheme(
      primary: Color(0xFFBB86FC),
      primaryContainer: Color(0xFF3700B3),
      secondary: Color(0xFF03DAC6),
      secondaryContainer: Color(0xFF03DAC6),
      surface: Color(0xFF121212),
      background: Color(0xFF121212),
      error: Color(0xFFCF6679),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark,
    ),
  );
}
