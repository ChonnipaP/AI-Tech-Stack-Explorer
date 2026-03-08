import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

import 'package:ai_techstack_explorer/core/theme/app_theme.dart';
import 'package:ai_techstack_explorer/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:ai_techstack_explorer/features/journal/presentation/pages/journal_form_page.dart';
import 'package:ai_techstack_explorer/features/journal/domain/entities/journal_entity.dart';
import 'package:ai_techstack_explorer/features/journal/domain/usecases/get_journal_entries_usecase.dart';
import 'package:ai_techstack_explorer/features/journal/domain/usecases/save_journal_entry_usecase.dart';

// ── Mocks ─────────────────────────────────────────────
class MockGetJournalEntriesUseCase extends Mock
    implements GetJournalEntriesUseCase {}

class MockSaveJournalEntryUseCase extends Mock
    implements SaveJournalEntryUseCase {}

class MockStackRouter extends Mock implements StackRouter {}

final sl = GetIt.instance;

void main() {
  late MockGetJournalEntriesUseCase mockGetEntries;
  late MockSaveJournalEntryUseCase mockSaveEntry;
  late MockStackRouter mockRouter;

  setUp(() async {
    // Reset GetIt ก่อนทุก test
    await sl.reset();

    mockGetEntries = MockGetJournalEntriesUseCase();
    mockSaveEntry  = MockSaveJournalEntryUseCase();
    mockRouter     = MockStackRouter();

    when(() => mockRouter.back()).thenAnswer((_) async {});

    // Register JournalBloc ใน GetIt
    sl.registerFactory<JournalBloc>(() => JournalBloc(
          getEntries: mockGetEntries,
          saveEntry: mockSaveEntry,
        ));

    registerFallbackValue(JournalEntity(
      title: '',
      content: '',
      mood: 'neutral',
      createdAt: DateTime.now(),
    ));
  });

  tearDown(() async {
    await sl.reset();
  });

  Widget buildWidget() {
    return MaterialApp(
      theme: AppTheme.dark,
      home: StackRouterScope(
        controller: mockRouter,
        stateHash: 0,
        child: const Scaffold(body: JournalFormPage()),
      ),
    );
  }

  group('JournalFormPage Widget Test', () {
    testWidgets('แสดง form fields ครบ', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.text('บันทึกใหม่'), findsOneWidget);
      expect(find.text('💾 บันทึก'), findsOneWidget);
    });

    testWidgets('แสดง error เมื่อกด บันทึก โดยไม่กรอกข้อมูล', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      await tester.tap(find.text('💾 บันทึก'));
      await tester.pump();

      expect(find.text('กรุณาใส่หัวข้อ'), findsOneWidget);
      expect(find.text('กรุณาใส่เนื้อหา'), findsOneWidget);
    });

    testWidgets('แสดง error เมื่อเนื้อหาสั้นเกินไป', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      final fields = find.byType(TextFormField);

      await tester.enterText(fields.first, 'Test Title');
      await tester.enterText(fields.last, 'short');

      await tester.tap(find.text('💾 บันทึก'));
      await tester.pump();

      expect(find.text('อย่างน้อย 10 ตัวอักษร'), findsOneWidget);
    });

    testWidgets('ไม่แสดง error เมื่อกรอกข้อมูลครบถ้วน', (tester) async {
      when(() => mockSaveEntry(any()))
          .thenAnswer((_) async => const Right(unit));

      await tester.pumpWidget(buildWidget());
      await tester.pump();

      final fields = find.byType(TextFormField);

      await tester.enterText(fields.first, 'Test Journal Title');
      await tester.enterText(
          fields.last, 'This is a valid content with enough characters');

      await tester.tap(find.text('💾 บันทึก'));
      await tester.pump();

      expect(find.text('กรุณาใส่หัวข้อ'), findsNothing);
      expect(find.text('กรุณาใส่เนื้อหา'), findsNothing);
      expect(find.text('อย่างน้อย 10 ตัวอักษร'), findsNothing);
    });

    testWidgets('เปลี่ยน mood segment ได้', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('🟢 Bullish'));
      await tester.pump();

      await tester.tap(find.text('🔴 Bearish'));
      await tester.pump();

      await tester.tap(find.text('⚪ Neutral'));
      await tester.pump();
    });
  });
}