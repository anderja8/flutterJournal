class JournalEntry {
  int id, rating;
  String title, body;
  DateTime date;

  JournalEntry(this.id, this.title, this.body, this.rating, this.date);

  int get getId => id;
  int get getRating => rating;
  String get getTitle => title;
  String get getBody => body;
  DateTime get getDate => date;
}
