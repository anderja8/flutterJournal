import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../JournalFormFAB.dart';
import '../JournalListWidgets.dart';
import '../models/JournalEntry.dart';
import '../services/DatabaseManager.dart';
import '../ThemeSelectorDrawer.dart';

class EntriesScreen extends StatefulWidget {
  static String routeName = 'entries';

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  List<JournalEntry> entries;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: 0,
        future: loadJournalEntries(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: snapshot.data == 0
                  ? const Text('Welcome')
                  : const Text('Journal Entries'),
              centerTitle: true,
            ),
            endDrawer: ThemeSelectorDrawer(),
            body: snapshot.data == 0
                ? Center(child: journalIcon(context))
                : LayoutBuilder(builder: (context, constraints) {
                    return constraints.maxWidth >= 600
                        ? JournalListWithDetails(entries)
                        : JournalList(entries: entries, isHorizontal: false);
                  }),
            floatingActionButton: JournalFormFAB(),
          );
        });
  }

  Future<int> loadJournalEntries() async {
    final DatabaseManager dbManager = DatabaseManager.getInstance();
    entries = await dbManager.getJournalEntries();
    return entries.length;
  }
}
