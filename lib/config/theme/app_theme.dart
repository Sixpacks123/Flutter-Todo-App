import 'package:flutter/material.dart';

class AppTheme {
  final _appTheme = ThemeData(
    useMaterial3: true,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 154, 185, 155),
      foregroundColor: Colors.black,
      hoverColor: Colors.black,
      splashColor: Colors.black,
    ),
  );

  ThemeData getAppTheme() {
    return _appTheme;
  }
}