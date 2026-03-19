import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:thai_yu/features/home/presentation/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.text('Thai Yu'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });
}
