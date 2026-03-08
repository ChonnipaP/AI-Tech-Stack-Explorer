import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/journal_entity.dart';
import '../../domain/usecases/get_journal_entries_usecase.dart';
import '../../domain/usecases/save_journal_entry_usecase.dart';

abstract class JournalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadJournalEvent extends JournalEvent {}

class SaveJournalEvent extends JournalEvent {
  final JournalEntity entry;
  SaveJournalEvent(this.entry);
  @override
  List<Object?> get props => [entry];
}

abstract class JournalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class JournalInitial extends JournalState {}
class JournalLoading extends JournalState {}
class JournalSaved extends JournalState {}

class JournalLoaded extends JournalState {
  final List<JournalEntity> entries;
  JournalLoaded(this.entries);
  @override
  List<Object?> get props => [entries];
}

class JournalError extends JournalState {
  final String message;
  JournalError(this.message);
  @override
  List<Object?> get props => [message];
}

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final GetJournalEntriesUseCase _getEntries;
  final SaveJournalEntryUseCase  _saveEntry;

  JournalBloc({
    required GetJournalEntriesUseCase getEntries,
    required SaveJournalEntryUseCase  saveEntry,
  })  : _getEntries = getEntries,
        _saveEntry  = saveEntry,
        super(JournalInitial()) {
    on<LoadJournalEvent>(_onLoad);
    on<SaveJournalEvent>(_onSave);
  }

  Future<void> _onLoad(LoadJournalEvent event, Emitter<JournalState> emit) async {
    emit(JournalLoading());
    final result = await _getEntries();
    result.fold(
      (f) => emit(JournalError(f.message)),
      (list) => emit(JournalLoaded(list)),
    );
  }

  Future<void> _onSave(SaveJournalEvent event, Emitter<JournalState> emit) async {
    final result = await _saveEntry(event.entry);
    result.fold(
      (f) => emit(JournalError(f.message)),
      (_) => emit(JournalSaved()),
    );
  }
}