import 'package:freezed_annotation/freezed_annotation.dart';

import 'word_block.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

@freezed
abstract class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult({
    required String input,
    required List<WordBlock> words,
    required DateTime analyzedAt,
  }) = _AnalysisResult;

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);
}
