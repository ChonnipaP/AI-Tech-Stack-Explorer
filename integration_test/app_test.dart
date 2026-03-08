import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import 'package:ai_techstack_explorer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test: Journal Flow', () {
    testWidgets('เปิดแอป → ไป Journal → กรอกข้อมูล → บันทึก → ข้อมูลแสดงในหน้ารวม',
        (tester) async {
      // 1. เปิดแอป
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // 2. ตรวจว่าแอปเปิดได้
      expect(find.text('AI Tech-Stack Explorer'), findsOneWidget);

      // 3. กดไปที่ tab Journal
      await tester.tap(find.text('Journal'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 4. กดปุ่ม + เพื่อเพิ่มบันทึก
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // 5. ตรวจว่าอยู่หน้า form
      expect(find.text('บันทึกใหม่'), findsOneWidget);

      // 6. กรอกหัวข้อ
      await tester.enterText(
        find.widgetWithText(TextFormField, 'หัวข้อ *'),
        'Integration Test Entry',
      );

      // 7. เลือก mood Bullish
      await tester.tap(find.text('🟢 Bullish'));
      await tester.pump();

      // 8. กรอกเนื้อหา
      await tester.enterText(
        find.widgetWithText(TextFormField, 'เนื้อหา *'),
        'This is an integration test journal entry with enough content.',
      );

      // 9. กดบันทึก
      await tester.tap(find.text('💾 บันทึก'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 10. ตรวจว่าข้อมูลขึ้นใน list
      expect(find.text('Integration Test Entry'), findsOneWidget);
    });
  });

  group('Integration Test: News Analysis Flow', () {
    testWidgets('เปิดแอป → กด สแกนใหม่ → กรอกข้อความ → วิเคราะห์ → บันทึก → ขึ้นหน้า News',
        (tester) async {
      // 1. เปิดแอป
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // 2. กดไปที่ tab News ก่อน (กรณีอยู่ tab อื่น)
      await tester.tap(find.text('News'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 3. ตรวจว่าอยู่หน้า News Feed
      expect(find.text('AI Tech-Stack Explorer'), findsOneWidget);

      // 4. กดปุ่ม สแกนใหม่
      await tester.tap(find.text('สแกนใหม่'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 5. ตรวจว่าอยู่หน้า Scan
      expect(find.text('สแกนและวิเคราะห์'), findsOneWidget);

      // 6. กรอกชื่อการวิเคราะห์
      await tester.enterText(
        find.widgetWithText(TextField, 'ชื่อการวิเคราะห์ *'),
        'Integration Test Analysis',
      );

      // 7. กรอกข้อความ
      await tester.enterText(
        find.widgetWithText(TextField, 'ข้อความที่ต้องการวิเคราะห์ *'),
        'Apple stock rose 5% today after strong earnings report exceeded analyst expectations.',
      );

      // 8. กด AI วิเคราะห์
      await tester.tap(find.text('AI วิเคราะห์ ✨'));
      await tester.pumpAndSettle(const Duration(seconds: 15));

      // 9. ตรวจว่ามีผลวิเคราะห์
      expect(find.text('ผลวิเคราะห์ AI'), findsOneWidget);

      // 10. กดบันทึก
      await tester.tap(find.text('บันทึก'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 11. ตรวจว่ากลับมาหน้า News Feed
      expect(find.text('AI Tech-Stack Explorer'), findsOneWidget);
    });
  });
}