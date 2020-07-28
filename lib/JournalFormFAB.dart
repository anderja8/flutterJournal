import 'package:flutter/material.dart';
import 'screens/FormScreen.dart';

class JournalFormFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        pushFormScreen(context);
      },
    );
  }

  void pushFormScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FormScreen()));
  }
}
