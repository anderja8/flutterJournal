import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'App.dart';
import 'services/SharedPreferencesManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);

  await SharedPreferencesManager.initialize();

  runApp(App());
}
