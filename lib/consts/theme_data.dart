import 'package:flutter/material.dart';

class Styles{
  static ThemeData themeData(bool isDarkTheme,BuildContext context){
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme? Color(0xFF00001a):Color(0xFFFFFFFF),
      primaryColor: Colors.blue,
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: isDarkTheme? Color(0xFF1a1f3c):Color(0xFFE8FDFD),
        brightness: isDarkTheme? Brightness.dark:Brightness.light
      ),
      cardColor: isDarkTheme?Color(0xFF0a0d2c):Color(0xFFF2FDFD),
        canvasColor: isDarkTheme?Colors.black:Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDarkTheme?
            ColorScheme.dark()
            : ColorScheme.light()
      )

    );
  }
}