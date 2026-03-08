// lib/features/news_analysis/presentation/bloc/news_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/news_analysis_entity.dart';
import '../../domain/usecases/analyze_news_usecase.dart';
import '../../domain/usecases/save_analysis_usecase.dart';
import '../../domain/usecases/get_all_analyses_usecase.dart';

// ════════════════════════════════════════
// EVENTS — สิ่งที่ผู้ใช้ทำ หรือแอปสั่ง
// ════════════════════════════════════════
abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ผู้ใช้กดปุ่ม "AI วิเคราะห์"
class AnalyzeNewsEvent extends NewsEvent {
  final String text;
  final String analysisType;

  AnalyzeNewsEvent({
    required this.text,
    required this.analysisType,
  });

  @override
  List<Object?> get props => [text, analysisType];
}

// ผู้ใช้กดปุ่ม "บันทึก"
class SaveAnalysisEvent extends NewsEvent {
  final NewsAnalysisEntity entity;
  SaveAnalysisEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}

// แอปโหลดรายการทั้งหมด (ตอนเปิดหน้า Home)
class LoadAnalysesEvent extends NewsEvent {}

// ผู้ใช้กดลบ
class DeleteAnalysisEvent extends NewsEvent {
  final int id;
  DeleteAnalysisEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// ════════════════════════════════════════
// STATES — สถานะของ UI
// ════════════════════════════════════════
abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ยังไม่ทำอะไร (เริ่มต้น)
class NewsInitial extends NewsState {}

// กำลังโหลด/ประมวลผล
class NewsLoading extends NewsState {}

// วิเคราะห์เสร็จ → มี summary ส่งกลับมา
class NewsAnalyzed extends NewsState {
  final String summary;
  NewsAnalyzed(this.summary);

  @override
  List<Object?> get props => [summary];
}

// โหลดรายการสำเร็จ
class NewsLoaded extends NewsState {
  final List<NewsAnalysisEntity> analyses;
  NewsLoaded(this.analyses);

  @override
  List<Object?> get props => [analyses];
}

// บันทึกสำเร็จ
class NewsSaved extends NewsState {}

// ลบสำเร็จ
class NewsDeleted extends NewsState {}

// เกิด error
class NewsError extends NewsState {
  final String message;
  NewsError(this.message);

  @override
  List<Object?> get props => [message];
}

// ════════════════════════════════════════
// BLOC — ตัวรับ Event แล้ว emit State
// ════════════════════════════════════════
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final AnalyzeNewsUseCase     _analyzeNews;
  final SaveAnalysisUseCase    _saveAnalysis;
  final GetAllAnalysesUseCase  _getAllAnalyses;

  NewsBloc({
    required AnalyzeNewsUseCase    analyzeNews,
    required SaveAnalysisUseCase   saveAnalysis,
    required GetAllAnalysesUseCase getAllAnalyses,
  })  : _analyzeNews    = analyzeNews,
        _saveAnalysis   = saveAnalysis,
        _getAllAnalyses  = getAllAnalyses,
        super(NewsInitial()) {
    // ลงทะเบียน handler แต่ละ event
    on<AnalyzeNewsEvent>  (_onAnalyze);
    on<SaveAnalysisEvent> (_onSave);
    on<LoadAnalysesEvent> (_onLoad);
    on<DeleteAnalysisEvent>(_onDelete);
  }

  // ── Handler: วิเคราะห์ข้อความ ────────────────────
  Future<void> _onAnalyze(
    AnalyzeNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading()); // แสดง loading ก่อน

    final result = await _analyzeNews(
      AnalyzeNewsParams(
        text: event.text,
        analysisType: event.analysisType,
      ),
    );

    // fold = ถ้า Left (error) → emit Error
    //        ถ้า Right (success) → emit Analyzed
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (summary) => emit(NewsAnalyzed(summary)),
    );
  }

  // ── Handler: บันทึก ───────────────────────────────
  Future<void> _onSave(
    SaveAnalysisEvent event,
    Emitter<NewsState> emit,
  ) async {
    final result = await _saveAnalysis(event.entity);

    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (_)       => emit(NewsSaved()),
    );
  }

  // ── Handler: โหลดรายการ ───────────────────────────
  Future<void> _onLoad(
    LoadAnalysesEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());

    final result = await _getAllAnalyses();

    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (list)    => emit(NewsLoaded(list)),
    );
  }

  // ── Handler: ลบ ───────────────────────────────────
  Future<void> _onDelete(
    DeleteAnalysisEvent event,
    Emitter<NewsState> emit,
  ) async {
    // TODO: เพิ่ม DeleteAnalysisUseCase ทีหลัง
    emit(NewsDeleted());
  }
}