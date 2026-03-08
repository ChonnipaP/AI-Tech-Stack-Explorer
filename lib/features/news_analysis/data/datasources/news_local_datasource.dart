import 'package:drift/drift.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/app_database.dart';

abstract class NewsLocalDataSource {
  Future<List<NewsAnalyse>> getAllAnalyses();        // ← NewsAnalyse
  Future<void> saveAnalysis(NewsAnalysesCompanion data);
  Future<void> deleteAnalysis(int id);
  Future<String?> getCachedSummary(String textHash);
  Future<void> cacheSummary(String textHash, String summary);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final AppDatabase _db;
  final Box _cacheBox;

  NewsLocalDataSourceImpl(this._db, this._cacheBox);

  @override
  Future<List<NewsAnalyse>> getAllAnalyses() {        // ← NewsAnalyse
    return (_db.select(_db.newsAnalyses)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
  }

  @override
  Future<void> saveAnalysis(NewsAnalysesCompanion data) {
    return _db.into(_db.newsAnalyses).insert(data);
  }

  @override
  Future<void> deleteAnalysis(int id) {
    return (_db.delete(_db.newsAnalyses)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  @override
  Future<String?> getCachedSummary(String textHash) async {
    return _cacheBox.get('summary_$textHash') as String?;
  }

  @override
  Future<void> cacheSummary(String textHash, String summary) {
    return _cacheBox.put('summary_$textHash', summary);
  }
}