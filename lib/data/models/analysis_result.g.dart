// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalysisResultImpl _$$AnalysisResultImplFromJson(Map<String, dynamic> json) =>
    _$AnalysisResultImpl(
      input: json['input'] as String,
      words: (json['words'] as List<dynamic>)
          .map((e) => WordBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
      analyzedAt: DateTime.parse(json['analyzedAt'] as String),
      sentenceGlosses:
          (json['sentenceGlosses'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$AnalysisResultImplToJson(
  _$AnalysisResultImpl instance,
) => <String, dynamic>{
  'input': instance.input,
  'words': instance.words,
  'analyzedAt': instance.analyzedAt.toIso8601String(),
  'sentenceGlosses': instance.sentenceGlosses.map(
    (k, e) => MapEntry(k.toString(), e),
  ),
};
