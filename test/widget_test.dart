import 'package:flutter_test/flutter_test.dart';

// Smoke tests — ตรวจสอบ entities และ logic พื้นฐาน
import 'package:ai_techstack_explorer/features/news_analysis/domain/entities/news_analysis_entity.dart';
import 'package:ai_techstack_explorer/features/journal/domain/entities/journal_entity.dart';

void main() {
  group('NewsAnalysisEntity', () {
    test('creates entity with correct values', () {
      final entity = NewsAnalysisEntity(
        id: 1,
        title: 'Test',
        extractedText: 'Some text',
        aiSummary: 'Summary',
        analysisType: 'stock_news',
        createdAt: DateTime(2024, 1, 1),
        isFavorite: false,
        tags: ['tag1', 'tag2'],
      );

      expect(entity.id, 1);
      expect(entity.title, 'Test');
      expect(entity.analysisType, 'stock_news');
      expect(entity.isFavorite, false);
      expect(entity.tags.length, 2);
    });

    test('entity without id (new entry)', () {
      final entity = NewsAnalysisEntity(
        title: 'New',
        extractedText: 'Text',
        aiSummary: 'Summary',
        analysisType: 'code',
        createdAt: DateTime.now(),
        isFavorite: false,
        tags: [],
      );

      expect(entity.id, isNull);
      expect(entity.analysisType, 'code');
    });
  });

  group('JournalEntity', () {
    test('creates entity with correct values', () {
      final entry = JournalEntity(
        id: 1,
        title: 'My Journal',
        content: 'Today was great',
        mood: 'bullish',
        createdAt: DateTime(2024, 6, 1),
      );

      expect(entry.id, 1);
      expect(entry.title, 'My Journal');
      expect(entry.mood, 'bullish');
    });

    test('entity without id (new entry)', () {
      final entry = JournalEntity(
        title: 'New Entry',
        content: 'Some content here',
        mood: 'neutral',
        createdAt: DateTime.now(),
      );

      expect(entry.id, isNull);
      expect(entry.mood, 'neutral');
    });

    test('supports all mood values', () {
      final moods = ['bullish', 'neutral', 'bearish'];
      for (final mood in moods) {
        final entry = JournalEntity(
          title: 'Test',
          content: 'Content',
          mood: mood,
          createdAt: DateTime.now(),
        );
        expect(entry.mood, mood);
      }
    });
  });
}