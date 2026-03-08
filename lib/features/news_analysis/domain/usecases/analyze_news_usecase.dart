import 'package:dartz/dartz.dart';
import '../entities/news_analysis_entity.dart';
import '../repositories/news_repository.dart';
import '../../../../core/error/failures.dart';

class AnalyzeNewsParams {
  final String text;
  final String analysisType;
  const AnalyzeNewsParams({
    required this.text,
    required this.analysisType,
  });
}

class AnalyzeNewsUseCase {
  final NewsRepository repo;
  AnalyzeNewsUseCase(this.repo);

  Future<Either<Failure, String>> call(AnalyzeNewsParams params) =>
      repo.analyzeText(
        text: params.text,
        analysisType: params.analysisType,
      );
}