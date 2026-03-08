// lib/features/news_analysis/domain/entities/news_analysis_entity.dart
import 'package:equatable/equatable.dart';

class NewsAnalysisEntity extends Equatable {
  final int?         id;
  final String       title;
  final String       extractedText;
  final String       aiSummary;
  final String       analysisType; // stock_news | code_review
  final DateTime     createdAt;
  final bool         isFavorite;
  final List<String> tags;

  const NewsAnalysisEntity({
    this.id,
    required this.title,
    required this.extractedText,
    required this.aiSummary,
    required this.analysisType,
    required this.createdAt,
    this.isFavorite = false,
    this.tags = const [],
  });

  @override
  List<Object?> get props =>
      [id, title, extractedText, aiSummary, analysisType, createdAt];
}