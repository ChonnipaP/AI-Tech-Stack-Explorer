import 'package:dartz/dartz.dart';
import '../entities/news_analysis_entity.dart';
import '../repositories/news_repository.dart';
import '../../../../core/error/failures.dart';

class SaveAnalysisUseCase {
  final NewsRepository repo;
  SaveAnalysisUseCase(this.repo);

  Future<Either<Failure, Unit>> call(NewsAnalysisEntity entity) =>
      repo.saveAnalysis(entity);
}