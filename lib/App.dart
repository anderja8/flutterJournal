import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EntriesScreen.dart';
import 'WelcomeScreen.dart';

class App extends StatefulWidget {
  static const THEME_KEY = 'isDarkTheme';
  static final routes = {
    EntriesScreen.routeName: (context) => EntriesScreen(),
    WelcomeScreen.routeName: (context) => WelcomeScreen(),
  };
  final SharedPreferences preferences;

  App({Key key, @required this.preferences}) : super(key: key);

  bool get isDarkMode => preferences.getBool(THEME_KEY) ?? false;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData appTheme;

  void initState() {
    super.initState();
    widget.preferences.getBool(App.THEME_KEY)
        ? appTheme = ThemeData.dark()
        : appTheme = ThemeData.light();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Journal',
        theme: appTheme,
        routes: App.routes,
        home: WelcomeScreen());
  }
}
