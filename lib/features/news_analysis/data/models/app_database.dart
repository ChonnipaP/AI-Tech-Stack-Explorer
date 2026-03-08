import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class NewsAnalyses extends Table {
  IntColumn    get id            => integer().autoIncrement()();
  TextColumn   get title         => text()();
  TextColumn   get extractedText => text()();
  TextColumn   get aiSummary     => text()();
  TextColumn   get analysisType  => text()();
  DateTimeColumn get createdAt   => dateTime()();
  BoolColumn   get isFavorite    =>
      boolean().withDefault(const Constant(false))();
  TextColumn   get tags          =>
      text().withDefault(const Constant(''))();
}

class JournalEntries extends Table {
  IntColumn    get id        => integer().autoIncrement()();
  TextColumn   get title     => text()();
  TextColumn   get content   => text()();
  TextColumn   get mood      => text().nullable()();
  DateTimeColumn get date    => dateTime()();
  IntColumn    get relatedId => integer().nullable()();
}

@DriftDatabase(tables: [NewsAnalyses, JournalEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir  = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'techstack.db'));
    return NativeDatabase.createInBackground(file);
  });
}