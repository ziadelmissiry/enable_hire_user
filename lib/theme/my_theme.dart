import 'package:enable_hire_user/theme/styles.dart';
import 'package:flutter/material.dart';


class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
    primaryColor: Styles.primary,
    useMaterial3: true,
    canvasColor: Colors.white,
    secondaryHeaderColor: const Color(0xFF163043),
    cardColor: const Color(0xFF1F3C51),
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.white,
        onSurface: const Color(0xFF1F3C51),
        onBackground: const Color(0xFF1F3C51),
        background: const Color(0xFF081C2C)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF081C2C),
    ),
  );

  static final lightThemes = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Styles.primary,
      useMaterial3: true,
      // hoverColor: Styles.primary,
      cardColor: const Color.fromARGB(255, 234, 233, 233),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.white,
        background: Styles.primary,
        onBackground: Styles.primary,
        onSurface: const Color(0xFFFFE7E7),
      ),
      canvasColor: const Color(0xFF081C2C),
      secondaryHeaderColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ));
}
