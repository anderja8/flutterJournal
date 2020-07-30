import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../JournalFormFAB.dart';
import '../models/JournalEntry.dart';
import '../screens/DetailsScreen.dart';
import '../ThemeSelectorDrawer.dart';

class EntriesScreen extends StatefulWidget {
  static String routeName = 'entries';

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  @override
  Widget build(BuildContext context) {
    List<JournalEntry> tempFakeEntries = initFakeEntries();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entries'),
        centerTitle: true,
      ),
      endDrawer: ThemeSelectorDrawer(),
      body: ListView.builder(
          itemCount: tempFakeEntries.length,
          itemBuilder: (context, idx) => JournalListTile(tempFakeEntries[idx])),
      floatingActionButton: JournalFormFAB(),
    );
  }

  //TODO get rid of this after db ops added
  List<JournalEntry> initFakeEntries() {
    List<JournalEntry> myEntries = [];
    for (int i = 1; i <= 4; i++) {
      myEntries.add(JournalEntry(i, 'Title ' + i.toString(),
          'Body ' + i.toString(), i, DateTime.now()));
    }
    return myEntries;
  }
}

class JournalListTile extends StatelessWidget {
  final JournalEntry entry;
  final DateFormat formatter = DateFormat('EEEE, MMMM dd, yyyy');

  JournalListTile(this.entry);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.getTitle),
      subtitle: (Text(formatter.format(entry.getDate))),
      onTap: () {
        pushDetailsScreen(context);
      },
    );
  }

  void pushDetailsScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailsScreen(entry)));
  }
}
