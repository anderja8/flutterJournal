import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/JournalEntry.dart';
import 'screens/DetailsScreen.dart';

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
