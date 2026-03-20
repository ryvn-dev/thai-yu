import 'package:freezed_annotation/freezed_annotation.dart';

import 'consonant_class.dart';
import 'tone_rules.dart';
import 'tone_type.dart';

part 'word_block.freezed.dart';
part 'word_block.g.dart';

@freezed
abstract class WordBlock with _$WordBlock {
  const factory WordBlock({
    required String thai,
    required String roman,
    required String gloss,
    @Default([ToneType.mid])
    @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
    List<ToneType> tones,
    required String toneReason,
    // Tone rule variables (populated by OpenAI, used to verify tone)
    String? initialConsonant,
    @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
    ConsonantClass? consonantClass,
    @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
    ToneMark? toneMark,
    @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
    SyllableType? syllableType,
    @Default(0) int sentenceIndex,
    @Default([]) List<String> originalSyllables,
    @Default([]) List<SyllableBreakdown> syllableBreakdowns,
  }) = _WordBlock;

  factory WordBlock.fromJson(Map<String, dynamic> json) =>
      _$WordBlockFromJson(json);
}

@freezed
abstract class PhonemeBreakdown with _$PhonemeBreakdown {
  const factory PhonemeBreakdown({
    required String label,
    @JsonKey(name: 'char') required String char_,
    required String sound,
    required String zhApprox,
    @Default(false) bool isSilent,
  }) = _PhonemeBreakdown;

  factory PhonemeBreakdown.fromJson(Map<String, dynamic> json) =>
      _$PhonemeBreakdownFromJson(json);
}

@freezed
abstract class SyllableBreakdown with _$SyllableBreakdown {
  const factory SyllableBreakdown({
    required String thai,
    @Default('') String originalThai,
    @Default('') String rtgs,
    @Default('mid') String tone,
    @Default('') String toneReason,
    @Default('…') String gloss,
    @Default([]) List<PhonemeBreakdown> parts,
    @Default(false) bool isHoNam,
    @Default(false) bool hasImplicitVowel,
  }) = _SyllableBreakdown;

  factory SyllableBreakdown.fromJson(Map<String, dynamic> json) =>
      _$SyllableBreakdownFromJson(json);
}

List<ToneType> _tonesFromJson(dynamic value) {
  if (value is List) {
    return value.map((e) => ToneType.fromJson(e as String)).toList();
  }
  // Fallback: single tone string (legacy)
  if (value is String) {
    return [ToneType.fromJson(value)];
  }
  return [ToneType.mid];
}

List<String> _tonesToJson(List<ToneType> tones) =>
    tones.map((t) => t.toJson()).toList();

ConsonantClass? _consonantClassFromJson(String? value) =>
    value != null ? ConsonantClass.fromJson(value) : null;

String? _consonantClassToJson(ConsonantClass? value) => value?.toJson();

ToneMark? _toneMarkFromJson(String? value) =>
    value != null ? ToneMark.fromJson(value) : null;

String? _toneMarkToJson(ToneMark? value) => value?.toJson();

SyllableType? _syllableTypeFromJson(String? value) =>
    value != null ? SyllableType.fromJson(value) : null;

String? _syllableTypeToJson(SyllableType? value) => value?.toJson();
