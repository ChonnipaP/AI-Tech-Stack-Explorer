class JournalEntity {
  final int? id;
  final String title;
  final String content;
  final String mood;
  final DateTime createdAt;

  const JournalEntity({
    this.id,
    required this.title,
    required this.content,
    required this.mood,
    required this.createdAt,
  });
}