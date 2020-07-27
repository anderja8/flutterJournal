import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'App.dart';

void main() async {
  runApp(App(preferences: await SharedPreferences.getInstance()));
}
