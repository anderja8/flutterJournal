import 'package:flutter/material.dart';
import 'JournalFormFAB.dart';
import 'ThemeSelectorDrawer.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      endDrawer: ThemeSelectorDrawer(),
      body: Center(child: journalIcon(context)),
      floatingActionButton: JournalFormFAB(),
    );
  }
}

Widget journalIcon(BuildContext context) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Icon(Icons.book, size: fractionalSize(context, 0.4)),
    Text('Journal')
  ]);
}

double fractionalSize(BuildContext context, double screenFactor) {
  if (screenFactor > 1) {
    return 1;
  }

  return MediaQuery.of(context).size.shortestSide * screenFactor;
}
