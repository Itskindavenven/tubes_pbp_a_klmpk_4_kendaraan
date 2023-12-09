import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbp_widget_a_klmpk4/view/login/login.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  testWidgets("Profile Test", (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text("Forgot Password"));
    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(
        find.byType(TextFormField).first, "marvel@gmail.com");
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pumpAndSettle(const Duration(seconds: 2));
    await widgetTester.enterText(find.byType(TextFormField).first, "12345");
    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(find.byType(TextFormField).last, "12345");
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text("Confirm").last);
    await widgetTester.pumpAndSettle();
    await widgetTester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(LoginPage), findsOneWidget);
    await widgetTester.pumpAndSettle();
  });
}
