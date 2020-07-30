import 'package:flutter/material.dart';
import 'screens/EntriesScreen.dart';
import 'screens/FormScreen.dart';
import 'screens/WelcomeScreen.dart';
import 'services/SharedPreferencesInstance.dart';

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
    if (!appSPInstance.containsKey(App.THEME_KEY)) {
      appSPInstance.setBool(App.THEME_KEY, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = appSPInstance.getBool(App.THEME_KEY);
    return MaterialApp(
        title: 'Journal',
        theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        routes: App.routes,
        home:
            EntriesScreen()); //WelcomeScreen()); //TODO: Dynamically decide whether to run the welcome screen or not
  }
}
