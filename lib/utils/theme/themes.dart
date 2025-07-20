import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFE8FFD7),
    primary: Color(0xFF005B41),
    secondary: Color(0xFF008170),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF212121),
    primary: Color(0xFF005B41),
    secondary: Color(0xFF008170),
  ),
);
