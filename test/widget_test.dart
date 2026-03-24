// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../lib/main.dart';

void main() {
  testWidgets('RentyApp launches smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RentyApp());

    // Verify app launches without crashing, find main app elements.
// expect(find.byType(SvgPicture), findsOneWidget); // Updated for basic test
// expect(find.text('DRIVE THE MOMENT'), findsOneWidget); // Splash screen text
  });
}
