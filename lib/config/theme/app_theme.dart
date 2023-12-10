import 'package:flutter/material.dart';

class AppTheme{
  ThemeData getTheme() => ThemeData(
    fontFamily: 'Montserrat',
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue
  );
}