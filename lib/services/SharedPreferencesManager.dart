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
