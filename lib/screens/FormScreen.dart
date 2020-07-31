import 'package:flutter/material.dart';
import 'package:journal/models/JournalEntry.dart';
import 'DetailsScreen.dart';
import '../ThemeSelectorDrawer.dart';

class FormScreen extends StatelessWidget {
  static String routeName = 'form';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Journal Entry'),
        centerTitle: true,
      ),
      endDrawer: ThemeSelectorDrawer(),
      body: EntryForm(),
    );
  }
}

class EntryForm extends StatefulWidget {
  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  JournalEntry entry = JournalEntry();
  final _formKey = GlobalKey<FormState>();

  void cancelFunc() {
    Navigator.of(context).pop();
  }

  void saveFunc() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      entry.date = DateTime.now();
      print('Save to the DB at this point.\n');
      print('Title: ${entry.getTitle}\n');
      print('Body: ${entry.getBody}\n');
      print('Rating: ${entry.getRating}\n');
      print('Date: ${entry.getDate}\n');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(children: [
              titleField(entry),
              bodyField(entry),
              ratingField(entry),
              formButtons(context, entry, cancelFunc, saveFunc),
            ])));
  }
}

Widget titleField(JournalEntry entry) {
  return paddedWidget(
      5.0,
      TextFormField(
          autofocus: true,
          onSaved: (value) {
            entry.title = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Title', border: OutlineInputBorder())));
}

Widget bodyField(JournalEntry entry) {
  return paddedWidget(
      5.0,
      TextFormField(
          onSaved: (value) {
            entry.body = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a body';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Body', border: OutlineInputBorder())));
}

Widget ratingField(JournalEntry entry) {
  return paddedWidget(
      5.0,
      DropdownButtonFormField(
          items: ratingDropDownItems(),
          onChanged: (value) {
            entry.rating = value;
          },
          validator: (value) {
            if (value == null) {
              return 'Please enter a rating';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Rating', border: OutlineInputBorder())));
}

List<DropdownMenuItem> ratingDropDownItems() {
  return [dmi(1), dmi(2), dmi(3), dmi(4)];
}

DropdownMenuItem dmi(int rating) {
  return DropdownMenuItem(child: Text('$rating'), value: rating);
}

Widget formButtons(
    BuildContext context, JournalEntry entry, Function cancelFunc, saveFunc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      RaisedButton(
          onPressed: () {
            cancelFunc();
          },
          child: Text('Cancel')),
      RaisedButton(
          onPressed: () {
            saveFunc();
          },
          child: Text('Save')),
    ],
  );
}
