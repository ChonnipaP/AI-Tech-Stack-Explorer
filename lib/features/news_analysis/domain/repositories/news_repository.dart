// lib/features/news_analysis/domain/repositories/news_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/news_analysis_entity.dart';
import '../../../../core/error/failures.dart';

abstract class NewsRepository {
  Future<Either<Failure, String>> analyzeText({
    required String text,
    required String analysisType,
  });
  Future<Either<Failure, List<NewsAnalysisEntity>>> getAllAnalyses();
  Future<Either<Failure, Unit>> saveAnalysis(NewsAnalysisEntity entity);
  Future<Either<Failure, Unit>> deleteAnalysis(int id);
}