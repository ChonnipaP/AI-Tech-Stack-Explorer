import 'package:hive_flutter/hive_flutter.dart';  // ← เปลี่ยนกลับ

part 'journal_entry_model.g.dart';

@HiveType(typeId: 1)
class JournalEntryModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String mood;

  @HiveField(3)
  final DateTime createdAt;

  JournalEntryModel({
    required this.title,
    required this.content,
    required this.mood,
    required this.createdAt,
  });
}