import 'package:flutter/material.dart';
import 'screens/EntriesScreen.dart';
import 'screens/FormScreen.dart';
import 'screens/WelcomeScreen.dart';
import 'services/SharedPreferencesManager.dart';

class App extends StatefulWidget {
  static const THEME_KEY = 'isDarkTheme';
  static final routes = {
    EntriesScreen.routeName: (context) => EntriesScreen(),
    WelcomeScreen.routeName: (context) => WelcomeScreen(),
    FormScreen.routeName: (context) => FormScreen(),
  };
  final SharedPreferencesManager appSPInstance =
      SharedPreferencesManager.getInstance();

  bool get isDarkMode => appSPInstance.preferences.getBool(THEME_KEY) ?? false;

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  bool isDarkTheme;
  final SharedPreferencesManager appSPInstance =
      SharedPreferencesManager.getInstance();

  void initState() {
    super.initState();
    if (!appSPInstance.preferences.containsKey(App.THEME_KEY)) {
      appSPInstance.preferences.setBool(App.THEME_KEY, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = appSPInstance.preferences.getBool(App.THEME_KEY);
    return MaterialApp(
        title: 'Journal',
        theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        routes: App.routes,
        home:
            EntriesScreen()); //WelcomeScreen()); //TODO: Dynamically decide whether to run the welcome screen or not
  }
}
