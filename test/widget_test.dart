import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:thai_yu/data/models/consonant_class.dart';
import 'package:thai_yu/data/models/tone_rules.dart';
import 'package:thai_yu/data/models/tone_type.dart';
import 'package:thai_yu/features/analysis/presentation/widgets/tone_legend.dart';

void main() {
  testWidgets('ToneLegend displays all five tones', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: ToneLegend())),
        ),
      ),
    );

    expect(find.text('中平'), findsOneWidget);
    expect(find.text('低沉'), findsOneWidget);
    expect(find.text('急降'), findsOneWidget);
    expect(find.text('高揚'), findsOneWidget);
    expect(find.text('低升'), findsOneWidget);
  });

  group('Tone rule engine', () {
    test('ชอบ: low class, no mark, dead long → fall', () {
      final tone = determineTone(
        consonantClass: ConsonantClass.low,
        toneMark: ToneMark.none,
        syllableType: SyllableType.deadLong,
      );
      expect(tone, ToneType.fall);
    });

    test('กิน: mid class, no mark, live → mid', () {
      final tone = determineTone(
        consonantClass: ConsonantClass.mid,
        toneMark: ToneMark.none,
        syllableType: SyllableType.live,
      );
      expect(tone, ToneType.mid);
    });

    test('ข้าว: high class, mai tho → fall', () {
      final tone = determineTone(
        consonantClass: ConsonantClass.high,
        toneMark: ToneMark.maiTho,
        syllableType: SyllableType.live,
      );
      expect(tone, ToneType.fall);
    });

    test('ฉัน: high class, no mark, live → rise', () {
      final tone = determineTone(
        consonantClass: ConsonantClass.high,
        toneMark: ToneMark.none,
        syllableType: SyllableType.live,
      );
      expect(tone, ToneType.rise);
    });

    test('ผัด: high class, no mark, dead short → low', () {
      final tone = determineTone(
        consonantClass: ConsonantClass.high,
        toneMark: ToneMark.none,
        syllableType: SyllableType.deadShort,
      );
      expect(tone, ToneType.low);
    });

    test('Consonant class lookup', () {
      expect(lookupConsonantClass('ก'), ConsonantClass.mid);
      expect(lookupConsonantClass('ข'), ConsonantClass.high);
      expect(lookupConsonantClass('ช'), ConsonantClass.low);
      expect(lookupConsonantClass('ฉ'), ConsonantClass.high);
      expect(lookupConsonantClass('ผ'), ConsonantClass.high);
    });
  });
}
