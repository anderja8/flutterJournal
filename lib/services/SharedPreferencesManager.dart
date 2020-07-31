//This class will handle all calls to shared preferences. Inspired by this
//Medium article: https://medium.com/flutter-community/shared-preferences-service-in-flutter-for-code-maintainability-1dbd015b5bbd
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager _instance;
  final SharedPreferences preferences;

  SharedPreferencesManager._(this.preferences);

  factory SharedPreferencesManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    final preferences = await SharedPreferences.getInstance();
    _instance = SharedPreferencesManager._(preferences);
  }
}
