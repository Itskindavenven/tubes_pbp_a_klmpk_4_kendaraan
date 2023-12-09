import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbp_widget_a_klmpk4/view/login/login.dart';
import 'package:pbp_widget_a_klmpk4/view/login/register.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  testWidgets("Register Test", (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: RegisterPage(),
    ));
    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(find.byKey(const Key("Username")), "marvel");
    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(
        find.byKey(const Key("Email")), "marvel@gmail.com");
    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(find.byKey(const Key("Password")), "123123");
    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(
        find.byKey(const Key("PhoneNumber")), "081234567891011");
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byIcon(Icons.calendar_today));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text("OK").last);
    await widgetTester.pumpAndSettle();
    await widgetTester.dragUntilVisible(find.byIcon(Icons.calendar_today),
        find.byType(SingleChildScrollView), const Offset(0, 50));
    // await widgetTester.tap(find.byType(Checkbox).first);
    // await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text("Sudah").last);
    await widgetTester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byType(LoginPage), findsOneWidget);
    await widgetTester.pumpAndSettle();
  });
}