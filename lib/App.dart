import 'package:flutter/material.dart';
import 'EntriesScreen.dart';
import 'FormScreen.dart';
import 'services/SharedPreferencesInstance.dart';
import 'WelcomeScreen.dart';

class App extends StatefulWidget {
  static const THEME_KEY = 'isDarkTheme';
  static final routes = {
    EntriesScreen.routeName: (context) => EntriesScreen(),
    WelcomeScreen.routeName: (context) => WelcomeScreen(),
    FormScreen.routeName: (context) => FormScreen(),
  };

  bool get isDarkMode => appSPInstance.getBool(THEME_KEY) ?? false;

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  bool isDarkTheme;

  void initState() {
    super.initState();
    if (appSPInstance.containsKey(App.THEME_KEY)) {
      isDarkTheme = appSPInstance.getBool(App.THEME_KEY);
    } else {
      isDarkTheme = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = appSPInstance.getBool(App.THEME_KEY);
    return MaterialApp(
        title: 'Journal',
        theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        routes: App.routes,
        home: WelcomeScreen());
  }
}
