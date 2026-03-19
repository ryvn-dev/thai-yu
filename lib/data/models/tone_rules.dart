import 'consonant_class.dart';
import 'tone_type.dart';

/// Thai tone marks
enum ToneMark {
  none, // no mark
  maiEk, // ่
  maiTho, // ้
  maiTri, // ๊
  maiChattawa; // ๋

  static ToneMark fromSymbol(String? symbol) {
    if (symbol == null || symbol.isEmpty) return ToneMark.none;
    return switch (symbol) {
      '่' => ToneMark.maiEk,
      '้' => ToneMark.maiTho,
      '๊' => ToneMark.maiTri,
      '๋' => ToneMark.maiChattawa,
      _ => ToneMark.none,
    };
  }

  static ToneMark fromJson(String? value) {
    if (value == null) return ToneMark.none;
    return switch (value) {
      'mai_ek' => ToneMark.maiEk,
      'mai_tho' => ToneMark.maiTho,
      'mai_tri' => ToneMark.maiTri,
      'mai_chattawa' => ToneMark.maiChattawa,
      _ => ToneMark.none,
    };
  }

  String? toJson() => switch (this) {
        ToneMark.none => null,
        ToneMark.maiEk => 'mai_ek',
        ToneMark.maiTho => 'mai_tho',
        ToneMark.maiTri => 'mai_tri',
        ToneMark.maiChattawa => 'mai_chattawa',
      };
}

/// Syllable type for tone determination
enum SyllableType {
  live, // Open syllable or closed with sonorant coda (น ม ง ย ว ร ล)
  deadLong, // Closed with stop coda + long vowel
  deadShort; // Closed with stop coda + short vowel

  static SyllableType fromJson(String value) => switch (value) {
        'live' => SyllableType.live,
        'dead_long' => SyllableType.deadLong,
        'dead_short' => SyllableType.deadShort,
        _ => SyllableType.live,
      };

  String toJson() => switch (this) {
        SyllableType.live => 'live',
        SyllableType.deadLong => 'dead_long',
        SyllableType.deadShort => 'dead_short',
      };
}

/// Deterministic Thai tone rule engine.
///
/// Given the three variables — consonant class, tone mark, and syllable type —
/// returns the exact tone. This is a finite lookup table, not heuristic.
///
/// Reference: standard Thai phonology tone rules.
ToneType determineTone({
  required ConsonantClass consonantClass,
  required ToneMark toneMark,
  required SyllableType syllableType,
}) {
  return switch ((consonantClass, toneMark, syllableType)) {
    // ── Mid class ──────────────────────────────────────
    (ConsonantClass.mid, ToneMark.none, SyllableType.live) => ToneType.mid,
    (ConsonantClass.mid, ToneMark.none, SyllableType.deadLong) => ToneType.low,
    (ConsonantClass.mid, ToneMark.none, SyllableType.deadShort) =>
      ToneType.low,
    (ConsonantClass.mid, ToneMark.maiEk, _) => ToneType.low,
    (ConsonantClass.mid, ToneMark.maiTho, _) => ToneType.fall,
    (ConsonantClass.mid, ToneMark.maiTri, _) => ToneType.high,
    (ConsonantClass.mid, ToneMark.maiChattawa, _) => ToneType.rise,

    // ── High class ─────────────────────────────────────
    (ConsonantClass.high, ToneMark.none, SyllableType.live) => ToneType.rise,
    (ConsonantClass.high, ToneMark.none, SyllableType.deadLong) =>
      ToneType.low,
    (ConsonantClass.high, ToneMark.none, SyllableType.deadShort) =>
      ToneType.low,
    (ConsonantClass.high, ToneMark.maiEk, _) => ToneType.low,
    (ConsonantClass.high, ToneMark.maiTho, _) => ToneType.fall,
    // mai tri and mai chattawa are not standard for high class,
    // but handle gracefully
    (ConsonantClass.high, ToneMark.maiTri, _) => ToneType.high,
    (ConsonantClass.high, ToneMark.maiChattawa, _) => ToneType.rise,

    // ── Low class ──────────────────────────────────────
    (ConsonantClass.low, ToneMark.none, SyllableType.live) => ToneType.mid,
    (ConsonantClass.low, ToneMark.none, SyllableType.deadLong) =>
      ToneType.fall,
    (ConsonantClass.low, ToneMark.none, SyllableType.deadShort) =>
      ToneType.high,
    (ConsonantClass.low, ToneMark.maiEk, _) => ToneType.fall,
    (ConsonantClass.low, ToneMark.maiTho, _) => ToneType.high,
    // mai tri and mai chattawa with low class (rare but handle)
    (ConsonantClass.low, ToneMark.maiTri, _) => ToneType.high,
    (ConsonantClass.low, ToneMark.maiChattawa, _) => ToneType.rise,
  };
}
