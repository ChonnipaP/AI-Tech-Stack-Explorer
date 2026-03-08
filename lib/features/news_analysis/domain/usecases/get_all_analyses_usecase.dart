import 'package:dartz/dartz.dart';
import '../entities/news_analysis_entity.dart';
import '../repositories/news_repository.dart';
import '../../../../core/error/failures.dart';

class GetAllAnalysesUseCase {
  final NewsRepository repo;
  GetAllAnalysesUseCase(this.repo);

  Future<Either<Failure, List<NewsAnalysisEntity>>> call() =>
      repo.getAllAnalyses();
}