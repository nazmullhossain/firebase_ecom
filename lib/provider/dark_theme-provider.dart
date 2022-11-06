
import 'package:firecom/service/dark_thme_prefs.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier{
  DarkThemePref darkThemePrefs=DarkThemePref();
bool _darkTheme=false;

bool get getDarkTheme=>_darkTheme;

set setDarkTheme(bool value){
  _darkTheme=value;
  darkThemePrefs.setDarkTheme(value);
  notifyListeners();

}

}