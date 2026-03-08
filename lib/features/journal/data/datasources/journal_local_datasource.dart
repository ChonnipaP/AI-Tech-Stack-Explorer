import '../../../../features/news_analysis/data/models/app_database.dart';
import '../../domain/entities/journal_entity.dart';
import 'package:drift/drift.dart';

abstract class JournalLocalDataSource {
  Future<List<JournalEntity>> getAllEntries();
  Future<void> saveEntry(JournalEntity entry);
}

class JournalLocalDataSourceImpl implements JournalLocalDataSource {
  final AppDatabase _db;
  JournalLocalDataSourceImpl(this._db);

  @override
  Future<List<JournalEntity>> getAllEntries() async {
    final rows = await _db.select(_db.journalEntries).get();
    return rows.map((r) => JournalEntity(
      id: r.id,
      title: r.title,
      content: r.content,
      mood: r.mood ?? '😊',
      createdAt: r.date,
    )).toList();
  }

  @override
  Future<void> saveEntry(JournalEntity entry) async {
    await _db.into(_db.journalEntries).insert(
      JournalEntriesCompanion.insert(
        title: entry.title,
        content: entry.content,
        mood: Value(entry.mood),
        date: entry.createdAt,
      ),
    );
  }
}