import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'App.dart';

class ThemeSelectorDrawer extends StatefulWidget {
  @override
  _ThemeSelectorDrawerState createState() => _ThemeSelectorDrawerState();
}

class _ThemeSelectorDrawerState extends State<ThemeSelectorDrawer> {
  bool isDarkTheme;
  SharedPreferences prefs;

  void initState() async {
    super.initState();
    prefs = await SharedPreferences.getInstance();
    isDarkTheme = getIsDarkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Switch(
      value: isDarkTheme,
      onChanged: setIsDarkTheme,
    ));
  }

  bool getIsDarkTheme() {
    if (prefs.containsKey(App.THEME_KEY)) {
      return prefs.getBool(App.THEME_KEY);
    } else {
      return false;
    }
  }

  void setIsDarkTheme(bool isDarkTheme) async {
    prefs.setBool(App.THEME_KEY, isDarkTheme);
  }
}
