import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ai_techstack_explorer/core/error/failures.dart';
import 'package:ai_techstack_explorer/features/journal/domain/entities/journal_entity.dart';
import 'package:ai_techstack_explorer/features/journal/domain/usecases/get_journal_entries_usecase.dart';
import 'package:ai_techstack_explorer/features/journal/domain/usecases/save_journal_entry_usecase.dart';
import 'package:ai_techstack_explorer/features/journal/presentation/bloc/journal_bloc.dart';

// ── Mocks ─────────────────────────────────────────────
class MockGetJournalEntriesUseCase extends Mock implements GetJournalEntriesUseCase {}
class MockSaveJournalEntryUseCase extends Mock implements SaveJournalEntryUseCase {}

// ── Fake Data ─────────────────────────────────────────
final tEntry = JournalEntity(
  id: 1,
  title: 'Test Journal',
  content: 'Test content here',
  mood: 'bullish',
  createdAt: DateTime(2024, 1, 1),
);

void main() {
  late MockGetJournalEntriesUseCase mockGetEntries;
  late MockSaveJournalEntryUseCase mockSaveEntry;

  setUp(() {
    mockGetEntries = MockGetJournalEntriesUseCase();
    mockSaveEntry  = MockSaveJournalEntryUseCase();
    registerFallbackValue(tEntry);
  });

  JournalBloc buildBloc() => JournalBloc(
        getEntries: mockGetEntries,
        saveEntry:  mockSaveEntry,
      );

  group('JournalBloc', () {
    // ── LoadJournalEvent ───────────────────────────────
    group('LoadJournalEvent', () {
      blocTest<JournalBloc, JournalState>(
        'emits [JournalLoading, JournalLoaded] when load succeeds',
        build: buildBloc,
        setUp: () {
          when(() => mockGetEntries())
              .thenAnswer((_) async => Right([tEntry]));
        },
        act: (bloc) => bloc.add(LoadJournalEvent()),
        expect: () => [
          isA<JournalLoading>(),
          isA<JournalLoaded>().having(
            (s) => s.entries.length,
            'entries length',
            1,
          ),
        ],
      );

      blocTest<JournalBloc, JournalState>(
        'emits [JournalLoading, JournalError] when load fails',
        build: buildBloc,
        setUp: () {
          when(() => mockGetEntries())
              .thenAnswer((_) async => Left(LocalDbFailure('DB error')));
        },
        act: (bloc) => bloc.add(LoadJournalEvent()),
        expect: () => [
          isA<JournalLoading>(),
          isA<JournalError>().having(
            (s) => s.message,
            'message',
            'DB error',
          ),
        ],
      );

      blocTest<JournalBloc, JournalState>(
        'emits [JournalLoading, JournalLoaded] with empty list',
        build: buildBloc,
        setUp: () {
          when(() => mockGetEntries())
              .thenAnswer((_) async => const Right([]));
        },
        act: (bloc) => bloc.add(LoadJournalEvent()),
        expect: () => [
          isA<JournalLoading>(),
          isA<JournalLoaded>().having(
            (s) => s.entries,
            'entries',
            isEmpty,
          ),
        ],
      );
    });

    // ── SaveJournalEvent ───────────────────────────────
    group('SaveJournalEvent', () {
      blocTest<JournalBloc, JournalState>(
        'emits [JournalSaved] when save succeeds',
        build: buildBloc,
        setUp: () {
          when(() => mockSaveEntry(any()))
              .thenAnswer((_) async => const Right(unit));
        },
        act: (bloc) => bloc.add(SaveJournalEvent(tEntry)),
        expect: () => [isA<JournalSaved>()],
      );

      blocTest<JournalBloc, JournalState>(
        'emits [JournalError] when save fails',
        build: buildBloc,
        setUp: () {
          when(() => mockSaveEntry(any()))
              .thenAnswer((_) async => Left(LocalDbFailure('Save failed')));
        },
        act: (bloc) => bloc.add(SaveJournalEvent(tEntry)),
        expect: () => [
          isA<JournalError>().having(
            (s) => s.message,
            'message',
            'Save failed',
          ),
        ],
      );
    });
  });
}