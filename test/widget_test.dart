import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aqar_plus/main.dart';

void main() {
  testWidgets('Test main screen shows correct text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('الصفحة الرئيسية'), findsOneWidget);
  });
}
