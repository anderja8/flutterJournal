//This class will handle all calls to shared preferences. Inspired by this
//Medium article: https://medium.com/flutter-community/shared-preferences-service-in-flutter-for-code-maintainability-1dbd015b5bbd
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {
  final SharedPreferences _preferences;

  SharedPreferencesInstance(this._preferences);

  bool getBool(String key) => _preferences.getBool(key);

  void setBool(String key, bool val) {
    _preferences.setBool(key, val);
  }

  bool containsKey(String key) => _preferences.containsKey(key);
}

SharedPreferencesInstance appSPInstance;
