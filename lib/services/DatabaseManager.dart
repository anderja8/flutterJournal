import 'dart:core';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../models/JournalEntry.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'journal.db';
  static const String SCHEMA_PATH = 'assets/journalSchema.txt';
  static const String INSERT_JOURNAL_PATH =
      'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?);';
  static const String SELECT_JOURNALS_PATH = 'SELECT * FROM journal_entries;';

  static DatabaseManager _instance;
  final Database db;

  DatabaseManager._(this.db);

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    String schemaCreationCommand = await rootBundle.loadString(SCHEMA_PATH);

    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(schemaCreationCommand);
    });
    _instance = DatabaseManager._(db);
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    List<JournalEntry> entries = [];

    List<Map> journalRecords = await db.rawQuery(SELECT_JOURNALS_PATH);

    for (var journal in journalRecords) {
      entries.add(JournalEntry(
        title: journal['title'],
        body: journal['body'],
        rating: journal['rating'],
        date: DateTime.parse(journal['date']),
        id: journal['id'],
      ));
    }

    return entries;
  }

  Future<bool> saveJournalEntry(JournalEntry entry) async {
    await db.transaction((txn) async {
      await txn.rawInsert(INSERT_JOURNAL_PATH, [
        entry.getTitle,
        entry.getBody,
        entry.getRating,
        entry.getDate.toString(),
      ]);
    });
    return true;
  }
}
