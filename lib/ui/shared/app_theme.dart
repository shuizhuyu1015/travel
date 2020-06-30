import 'package:flutter/material.dart';

class GLAppTheme {
  static const double bodyFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 20;
  static const double largeFontSize = 24;

  static final Color norTextColor = Color(0xff333333);
  
  static final ThemeData norTheme = ThemeData(
    primarySwatch: Colors.lightGreen,
    primaryColor: Color(0xff009dff),
    splashColor: Colors.transparent,
    canvasColor: Color(0xffeeeeee),
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: bodyFontSize, color: norTextColor),
      headline1: TextStyle(fontSize: largeFontSize, color: norTextColor),
      headline2: TextStyle(fontSize: normalFontSize, color: norTextColor),
      headline3: TextStyle(fontSize: smallFontSize, color: norTextColor),
    )
  );
}