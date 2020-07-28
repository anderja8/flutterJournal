import 'package:flutter/material.dart';
import 'App.dart';
import 'services/SharedPreferencesInstance.dart';

class ThemeSelectorDrawer extends StatefulWidget {
  @override
  _ThemeSelectorDrawerState createState() => _ThemeSelectorDrawerState();
}

class _ThemeSelectorDrawerState extends State<ThemeSelectorDrawer> {
  bool isDarkTheme;

  void initState() {
    super.initState();
    isDarkTheme = getIsDarkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      Container(child: DrawerHeader(child: Text('Settings')), height: 60.0),
      SwitchListTile(
        title: Text('Dark Theme'),
        value: isDarkTheme,
        onChanged: setIsDarkTheme,
      )
    ]));
  }

  bool getIsDarkTheme() {
    if (appSPInstance.containsKey(App.THEME_KEY)) {
      return appSPInstance.getBool(App.THEME_KEY);
    } else {
      return false;
    }
  }

  void setIsDarkTheme(bool switchVal) async {
    isDarkTheme = switchVal;
    appSPInstance.setBool(App.THEME_KEY, isDarkTheme);

    AppState appState = context.findAncestorStateOfType<AppState>();
    appState.setState(() {});
  }
}
