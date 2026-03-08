import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' show Value;
import '../../domain/entities/news_analysis_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';
import '../datasources/news_local_datasource.dart';
import '../models/app_database.dart';
import '../../../../core/error/failures.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remote;
  final NewsLocalDataSource  _local;

  NewsRepositoryImpl(this._remote, this._local);

  @override
  Future<Either<Failure, String>> analyzeText({
    required String text,
    required String analysisType,
  }) async {
    try {
      final hash   = md5.convert(utf8.encode(text)).toString();
      final cached = await _local.getCachedSummary(hash);
      if (cached != null) return Right(cached);

      final summary = await _remote.analyzeText(
        text: text,
        analysisType: analysisType,
      );
      await _local.cacheSummary(hash, summary);
      return Right(summary);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NewsAnalysisEntity>>> getAllAnalyses() async {
    try {
      final rows = await _local.getAllAnalyses();
      return Right(rows.map(_toEntity).toList());
    } catch (e) {
      return Left(LocalDbFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAnalysis(
      NewsAnalysisEntity entity) async {
    try {
      await _local.saveAnalysis(NewsAnalysesCompanion(
        title:         Value(entity.title),
        extractedText: Value(entity.extractedText),
        aiSummary:     Value(entity.aiSummary),
        analysisType:  Value(entity.analysisType),
        createdAt:     Value(entity.createdAt),
        isFavorite:    Value(entity.isFavorite),
        tags:          Value(entity.tags.join(',')),
      ));
      return const Right(unit);
    } catch (e) {
      return Left(LocalDbFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAnalysis(int id) async {
    try {
      await _local.deleteAnalysis(id);
      return const Right(unit);
    } catch (e) {
      return Left(LocalDbFailure(e.toString()));
    }
  }

  // แปลง Drift row → Entity
  NewsAnalysisEntity _toEntity(NewsAnalyse row) =>   // ← NewsAnalyse
      NewsAnalysisEntity(
        id:            row.id,
        title:         row.title,
        extractedText: row.extractedText,
        aiSummary:     row.aiSummary,
        analysisType:  row.analysisType,
        createdAt:     row.createdAt,
        isFavorite:    row.isFavorite,
        tags: row.tags.isEmpty ? [] : row.tags.split(','),
      );
}