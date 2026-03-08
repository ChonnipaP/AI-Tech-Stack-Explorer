import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ai_techstack_explorer/core/error/failures.dart';
import 'package:ai_techstack_explorer/features/news_analysis/domain/entities/news_analysis_entity.dart';
import 'package:ai_techstack_explorer/features/news_analysis/domain/usecases/analyze_news_usecase.dart';
import 'package:ai_techstack_explorer/features/news_analysis/domain/usecases/save_analysis_usecase.dart';
import 'package:ai_techstack_explorer/features/news_analysis/domain/usecases/get_all_analyses_usecase.dart';
import 'package:ai_techstack_explorer/features/news_analysis/presentation/bloc/news_bloc.dart';

// ── Mocks ─────────────────────────────────────────────
class MockAnalyzeNewsUseCase extends Mock implements AnalyzeNewsUseCase {}
class MockSaveAnalysisUseCase extends Mock implements SaveAnalysisUseCase {}
class MockGetAllAnalysesUseCase extends Mock implements GetAllAnalysesUseCase {}

// ── Fake Data ─────────────────────────────────────────
final tEntity = NewsAnalysisEntity(
  id: 1,
  title: 'Test Analysis',
  extractedText: 'Some text about stocks',
  aiSummary: 'AI summary here',
  analysisType: 'stock_news',
  createdAt: DateTime(2024, 1, 1),
  isFavorite: false,
  tags: [],
);

void main() {
  late MockAnalyzeNewsUseCase mockAnalyze;
  late MockSaveAnalysisUseCase mockSave;
  late MockGetAllAnalysesUseCase mockGetAll;

  setUp(() {
    mockAnalyze = MockAnalyzeNewsUseCase();
    mockSave    = MockSaveAnalysisUseCase();
    mockGetAll  = MockGetAllAnalysesUseCase();

    // Register fallback values สำหรับ mocktail
    registerFallbackValue(
      AnalyzeNewsParams(text: '', analysisType: ''),
    );
    registerFallbackValue(tEntity);
  });

  NewsBloc buildBloc() => NewsBloc(
        analyzeNews:    mockAnalyze,
        saveAnalysis:   mockSave,
        getAllAnalyses:  mockGetAll,
      );

  group('NewsBloc', () {
    // ── LoadAnalysesEvent ──────────────────────────────
    group('LoadAnalysesEvent', () {
      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsLoaded] when load succeeds',
        build: buildBloc,
        setUp: () {
          when(() => mockGetAll())
              .thenAnswer((_) async => Right([tEntity]));
        },
        act: (bloc) => bloc.add(LoadAnalysesEvent()),
        expect: () => [
          isA<NewsLoading>(),
          isA<NewsLoaded>().having(
            (s) => s.analyses.length,
            'analyses length',
            1,
          ),
        ],
      );

      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsError] when load fails',
        build: buildBloc,
        setUp: () {
          when(() => mockGetAll())
              .thenAnswer((_) async => Left(LocalDbFailure('DB error')));
        },
        act: (bloc) => bloc.add(LoadAnalysesEvent()),
        expect: () => [
          isA<NewsLoading>(),
          isA<NewsError>().having((s) => s.message, 'message', 'DB error'),
        ],
      );

      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsLoaded] with empty list',
        build: buildBloc,
        setUp: () {
          when(() => mockGetAll())
              .thenAnswer((_) async => const Right([]));
        },
        act: (bloc) => bloc.add(LoadAnalysesEvent()),
        expect: () => [
          isA<NewsLoading>(),
          isA<NewsLoaded>().having(
            (s) => s.analyses,
            'analyses',
            isEmpty,
          ),
        ],
      );
    });

    // ── AnalyzeNewsEvent ───────────────────────────────
    group('AnalyzeNewsEvent', () {
      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsAnalyzed] when analyze succeeds',
        build: buildBloc,
        setUp: () {
          when(() => mockAnalyze(any()))
              .thenAnswer((_) async => const Right('AI summary result'));
        },
        act: (bloc) => bloc.add(AnalyzeNewsEvent(
          text: 'Some news text',
          analysisType: 'stock_news',
        )),
        expect: () => [
          isA<NewsLoading>(),
          isA<NewsAnalyzed>().having(
            (s) => s.summary,
            'summary',
            'AI summary result',
          ),
        ],
      );

      blocTest<NewsBloc, NewsState>(
        'emits [NewsLoading, NewsError] when analyze fails',
        build: buildBloc,
        setUp: () {
          when(() => mockAnalyze(any()))
              .thenAnswer((_) async => Left(NetworkFailure('Network error')));
        },
        act: (bloc) => bloc.add(AnalyzeNewsEvent(
          text: 'Some news text',
          analysisType: 'stock_news',
        )),
        expect: () => [
          isA<NewsLoading>(),
          isA<NewsError>().having(
            (s) => s.message,
            'message',
            'Network error',
          ),
        ],
      );
    });

    // ── SaveAnalysisEvent ──────────────────────────────
    group('SaveAnalysisEvent', () {
      blocTest<NewsBloc, NewsState>(
        'emits [NewsSaved] when save succeeds',
        build: buildBloc,
        setUp: () {
          when(() => mockSave(any()))
              .thenAnswer((_) async => const Right(unit));
        },
        act: (bloc) => bloc.add(SaveAnalysisEvent(tEntity)),
        expect: () => [isA<NewsSaved>()],
      );

      blocTest<NewsBloc, NewsState>(
        'emits [NewsError] when save fails',
        build: buildBloc,
        setUp: () {
          when(() => mockSave(any()))
              .thenAnswer((_) async => Left(LocalDbFailure('Save failed')));
        },
        act: (bloc) => bloc.add(SaveAnalysisEvent(tEntity)),
        expect: () => [
          isA<NewsError>().having(
            (s) => s.message,
            'message',
            'Save failed',
          ),
        ],
      );
    });
  });
}