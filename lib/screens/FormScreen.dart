import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  final List<DropdownMenuItem> ratings = [dmi(1), dmi(2), dmi(3), dmi(4)];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          paddedWidget(
              5.0,
              TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Title', border: OutlineInputBorder()))),
          paddedWidget(
              5.0,
              TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()))),
          paddedWidget(
              5.0,
              DropdownButtonFormField(
                  items: ratings,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      labelText: 'Rating', border: OutlineInputBorder()))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              RaisedButton(onPressed: () {}, child: Text('Save')),
            ],
          )
        ]));
  }
}

DropdownMenuItem dmi(int rating) {
  return DropdownMenuItem(child: Text('$rating'), value: rating);
}
