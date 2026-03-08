// lib/core/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';
import '../../features/news_analysis/data/datasources/news_remote_datasource.dart';
import '../../features/news_analysis/data/datasources/news_local_datasource.dart';
import '../../features/news_analysis/data/models/app_database.dart';
import '../../features/news_analysis/data/repositories/news_repository_impl.dart';
import '../../features/news_analysis/domain/repositories/news_repository.dart';
import '../../features/news_analysis/domain/usecases/analyze_news_usecase.dart';
import '../../features/news_analysis/domain/usecases/save_analysis_usecase.dart';
import '../../features/news_analysis/domain/usecases/get_all_analyses_usecase.dart';
import '../../features/news_analysis/presentation/bloc/news_bloc.dart';
import '../../features/journal/data/datasources/journal_local_datasource.dart';
import '../../features/journal/data/repositories/journal_repository_impl.dart';
import '../../features/journal/domain/repositories/journal_repository.dart';
import '../../features/journal/domain/usecases/get_journal_entries_usecase.dart';
import '../../features/journal/domain/usecases/save_journal_entry_usecase.dart';
import '../../features/journal/presentation/bloc/journal_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ถ้า register แล้ว ไม่ต้องทำซ้ำ
  if (sl.isRegistered<AppDatabase>()) return;

  // ── 1. Hive (Cache) ───────────────────────────────
  await Hive.initFlutter();
  final cacheBox = await Hive.openBox('ai_cache');
  sl.registerSingleton(cacheBox);

  // ── 2. SharedPreferences (Settings) ──────────────
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // ── 3. Database (Drift) ───────────────────────────
  final db = AppDatabase();
  sl.registerSingleton<AppDatabase>(db);

  // ── 4. Dio ────────────────────────────────────────
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ── 5. DataSources ────────────────────────────────
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(
      sl<AppDatabase>(),
      sl(),
    ),
  );

  // ── 6. Repository ─────────────────────────────────
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      sl<NewsRemoteDataSource>(),
      sl<NewsLocalDataSource>(),
    ),
  );

  // ── 7. Use Cases ──────────────────────────────────
  sl.registerFactory(() => AnalyzeNewsUseCase(sl()));
  sl.registerFactory(() => SaveAnalysisUseCase(sl()));
  sl.registerFactory(() => GetAllAnalysesUseCase(sl()));

  // ── 8. BLoC ───────────────────────────────────────
  sl.registerFactory(() => NewsBloc(
    analyzeNews:   sl(),
    saveAnalysis:  sl(),
    getAllAnalyses: sl(),
  ));

  // ── 9. Journal (ใช้ Drift แทน Hive) ──────────────
  sl.registerLazySingleton<JournalLocalDataSource>(
    () => JournalLocalDataSourceImpl(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetJournalEntriesUseCase(sl()));
  sl.registerLazySingleton(() => SaveJournalEntryUseCase(sl()));
  sl.registerFactory(() => JournalBloc(
        getEntries: sl(),
        saveEntry: sl(),
      ));
}