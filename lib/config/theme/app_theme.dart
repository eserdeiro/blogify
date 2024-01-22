import 'package:flutter/material.dart';

class AppTheme{
    ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    // appBarTheme: const AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarColor: Color(0xff1f1d2b),
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // ),
    fontFamily: 'Montserrat',

    colorScheme: const ColorScheme(
      brightness: Brightness.dark, 
      primary: Colors.white,
      onPrimary: Colors.white, 
      secondary: Colors.white, 
      onSecondary: Colors.white,
      error: Color(0xffff5733), 
      onError: Color(0xffff5733), 
      background: Color(0xff1f1d2b),
      onBackground: Colors.white,
      surface: Color(0xff1f1d2b),
      onSurface: Colors.white,),
      primaryColorDark: const Color(0xff1f1d2b),
  );
}
