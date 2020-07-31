import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../JournalFormFAB.dart';
import '../models/JournalEntry.dart';
import '../services/DatabaseManager.dart';
import '../screens/DetailsScreen.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entries'),
        centerTitle: true,
      ),
      endDrawer: ThemeSelectorDrawer(),
      body: FutureBuilder(
          initialData: false,
          future: loadJournalEntries(),
          builder: (context, snapshot) {
            if (snapshot.data) {
              return LayoutBuilder(builder: (context, constraints) {
                return constraints.maxWidth >= 600
                    ? JournalListWithDetails(entries)
                    : JournalList(entries: entries, isHorizontal: false);
              });
            } else {
              return CircularProgressIndicator();
            }
          }),
      floatingActionButton: JournalFormFAB(),
    );
  }

  Future<bool> loadJournalEntries() async {
    final DatabaseManager dbManager = DatabaseManager.getInstance();
    entries = await dbManager.getJournalEntries();
    return true;
  }
}

class JournalList extends StatelessWidget {
  final List<JournalEntry> entries;
  final bool isHorizontal;
  final _JournalListWithDetailsState screenState;

  JournalList(
      {@required this.entries, @required this.isHorizontal, this.screenState});

  @override
  build(BuildContext context) {
    return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, idx) => isHorizontal
            ? JournalListTile(
                entry: entries[idx],
                isHorizontal: isHorizontal,
                screenState: screenState)
            : JournalListTile(entry: entries[idx], isHorizontal: isHorizontal));
  }
}

class JournalListWithDetails extends StatefulWidget {
  final List<JournalEntry> entries;

  JournalListWithDetails(this.entries);

  @override
  _JournalListWithDetailsState createState() => _JournalListWithDetailsState();
}

class _JournalListWithDetailsState extends State<JournalListWithDetails> {
  JournalEntry selectedEntry;

  @override
  build(BuildContext context) {
    selectedEntry ??= widget.entries[0];

    return Row(children: [
      Expanded(
          child: JournalList(
              entries: widget.entries, isHorizontal: true, screenState: this)),
      Expanded(child: detailsBody(context, selectedEntry))
    ]);
  }

  void refreshState(JournalEntry newSelection) {
    selectedEntry = newSelection;
    setState(() {});
  }
}

class JournalListTile extends StatelessWidget {
  final JournalEntry entry;
  final bool isHorizontal;
  final DateFormat formatter = DateFormat('EEEE, MMMM dd, yyyy');
  final _JournalListWithDetailsState screenState;

  JournalListTile(
      {@required this.entry, @required this.isHorizontal, this.screenState});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.getTitle),
      subtitle: (Text(formatter.format(entry.getDate))),
      onTap: isHorizontal
          ? () {
              screenState.refreshState(entry);
            }
          : () {
              pushDetailsScreen(context);
            },
    );
  }

  void pushDetailsScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailsScreen(entry)));
  }
}
