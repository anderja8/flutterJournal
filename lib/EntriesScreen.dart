import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/JournalEntry.dart';

class EntriesScreen extends StatefulWidget {
  static String routeName = 'entries';

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  @override
  Widget build(BuildContext context) {
    tempFakeEntries = initFakeEntries();

    return Scaffold(
        appBar: AppBar(
          title: Text('Journal'),
        ),
        body: Text('Journal entries will go here.'));
  }

  //TODO get rid of this after db ops added
  List<JournalEntry> tempFakeEntries;
  List<JournalEntry> initFakeEntries() {
    List<JournalEntry> myEntries = [];
    for (int i = 1; i <= 4; i++) {
      myEntries.add(JournalEntry(i, 'Title ' + i.toString(),
          'Body ' + i.toString(), i, DateTime.now()));
    }
    return myEntries;
  }
}
