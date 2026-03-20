// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordBlockImpl _$$WordBlockImplFromJson(
  Map<String, dynamic> json,
) => _$WordBlockImpl(
  thai: json['thai'] as String,
  roman: json['roman'] as String,
  gloss: json['gloss'] as String,
  tones: json['tones'] == null
      ? const [ToneType.mid]
      : _tonesFromJson(json['tones']),
  toneReason: json['toneReason'] as String,
  initialConsonant: json['initialConsonant'] as String?,
  consonantClass: _consonantClassFromJson(json['consonantClass'] as String?),
  toneMark: _toneMarkFromJson(json['toneMark'] as String?),
  syllableType: _syllableTypeFromJson(json['syllableType'] as String?),
  sentenceIndex: (json['sentenceIndex'] as num?)?.toInt() ?? 0,
  originalSyllables:
      (json['originalSyllables'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  syllableBreakdowns:
      (json['syllableBreakdowns'] as List<dynamic>?)
          ?.map((e) => SyllableBreakdown.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$WordBlockImplToJson(_$WordBlockImpl instance) =>
    <String, dynamic>{
      'thai': instance.thai,
      'roman': instance.roman,
      'gloss': instance.gloss,
      'tones': _tonesToJson(instance.tones),
      'toneReason': instance.toneReason,
      'initialConsonant': instance.initialConsonant,
      'consonantClass': _consonantClassToJson(instance.consonantClass),
      'toneMark': _toneMarkToJson(instance.toneMark),
      'syllableType': _syllableTypeToJson(instance.syllableType),
      'sentenceIndex': instance.sentenceIndex,
      'originalSyllables': instance.originalSyllables,
      'syllableBreakdowns': instance.syllableBreakdowns,
    };

_$PhonemeBreakdownImpl _$$PhonemeBreakdownImplFromJson(
  Map<String, dynamic> json,
) => _$PhonemeBreakdownImpl(
  label: json['label'] as String,
  char_: json['char'] as String,
  sound: json['sound'] as String,
  zhApprox: json['zhApprox'] as String,
  isSilent: json['isSilent'] as bool? ?? false,
);

Map<String, dynamic> _$$PhonemeBreakdownImplToJson(
  _$PhonemeBreakdownImpl instance,
) => <String, dynamic>{
  'label': instance.label,
  'char': instance.char_,
  'sound': instance.sound,
  'zhApprox': instance.zhApprox,
  'isSilent': instance.isSilent,
};

_$SyllableBreakdownImpl _$$SyllableBreakdownImplFromJson(
  Map<String, dynamic> json,
) => _$SyllableBreakdownImpl(
  thai: json['thai'] as String,
  originalThai: json['originalThai'] as String? ?? '',
  rtgs: json['rtgs'] as String? ?? '',
  tone: json['tone'] as String? ?? 'mid',
  toneReason: json['toneReason'] as String? ?? '',
  gloss: json['gloss'] as String? ?? '…',
  parts:
      (json['parts'] as List<dynamic>?)
          ?.map((e) => PhonemeBreakdown.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isHoNam: json['isHoNam'] as bool? ?? false,
  hasImplicitVowel: json['hasImplicitVowel'] as bool? ?? false,
);

Map<String, dynamic> _$$SyllableBreakdownImplToJson(
  _$SyllableBreakdownImpl instance,
) => <String, dynamic>{
  'thai': instance.thai,
  'originalThai': instance.originalThai,
  'rtgs': instance.rtgs,
  'tone': instance.tone,
  'toneReason': instance.toneReason,
  'gloss': instance.gloss,
  'parts': instance.parts,
  'isHoNam': instance.isHoNam,
  'hasImplicitVowel': instance.hasImplicitVowel,
};
