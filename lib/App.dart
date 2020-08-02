import 'package:flutter/material.dart';
import 'package:journal/services/DatabaseManager.dart';
import 'models/JournalEntry.dart';
import 'screens/EntriesScreen.dart';
import 'screens/FormScreen.dart';
import 'services/SharedPreferencesManager.dart';

class App extends StatefulWidget {
  static const THEME_KEY = 'isDarkTheme';
  static final routes = {
    EntriesScreen.routeName: (context) => EntriesScreen(),
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
  bool entriesExist;
  final SharedPreferencesManager appSPInstance =
      SharedPreferencesManager.getInstance();
  final DatabaseManager dbManager = DatabaseManager.getInstance();

  void initState() {
    super.initState();
    if (!appSPInstance.preferences.containsKey(App.THEME_KEY)) {
      appSPInstance.preferences.setBool(App.THEME_KEY, false);
    }
  }

  Future<bool> setEntriesExist() async {
    List<JournalEntry> entries = await dbManager.getJournalEntries();
    return entries.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = appSPInstance.preferences.getBool(App.THEME_KEY);
    return MaterialApp(
        title: 'Journal',
        theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        routes: App.routes,
        home: EntriesScreen());
  }
}
