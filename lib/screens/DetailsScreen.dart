import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/JournalEntry.dart';
import '../ThemeSelectorDrawer.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = 'details';
  final JournalEntry entry;
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');

  DetailsScreen(this.entry);

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(formatter.format(entry.getDate)),
          centerTitle: true,
        ),
        endDrawer: ThemeSelectorDrawer(),
        body: detailsBody(context, entry));
  }
}

// Extracting the details body so I can use it on the EntriesScreen when in
// horizontal mode.
Widget detailsBody(BuildContext context, JournalEntry entry) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    paddedText(
        Text(entry.getTitle, style: Theme.of(context).textTheme.headline4)),
    paddedText(Text(entry.getBody)),
    paddedText(Text('Rating: ${entry.getRating}')),
    paddedText(Text('ID: ${entry.getId}')),
  ]);
}

Widget paddedText(Text txtWidget) {
  return Padding(padding: EdgeInsets.all(8.0), child: txtWidget);
}
