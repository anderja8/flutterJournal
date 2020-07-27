import 'package:flutter/material.dart';
import 'ThemeSelectorDrawer.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Journal')),
        endDrawer: ThemeSelectorDrawer(),
        body: Column(children: [Icon(Icons.book), Text('Journal')]));
  }
}
