// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnalysisResult _$AnalysisResultFromJson(Map<String, dynamic> json) {
  return _AnalysisResult.fromJson(json);
}

/// @nodoc
mixin _$AnalysisResult {
  String get input => throw _privateConstructorUsedError;
  List<WordBlock> get words => throw _privateConstructorUsedError;
  DateTime get analyzedAt => throw _privateConstructorUsedError;

  /// Serializes this AnalysisResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisResultCopyWith<AnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisResultCopyWith<$Res> {
  factory $AnalysisResultCopyWith(
    AnalysisResult value,
    $Res Function(AnalysisResult) then,
  ) = _$AnalysisResultCopyWithImpl<$Res, AnalysisResult>;
  @useResult
  $Res call({String input, List<WordBlock> words, DateTime analyzedAt});
}

/// @nodoc
class _$AnalysisResultCopyWithImpl<$Res, $Val extends AnalysisResult>
    implements $AnalysisResultCopyWith<$Res> {
  _$AnalysisResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = null,
    Object? words = null,
    Object? analyzedAt = null,
  }) {
    return _then(
      _value.copyWith(
            input: null == input
                ? _value.input
                : input // ignore: cast_nullable_to_non_nullable
                      as String,
            words: null == words
                ? _value.words
                : words // ignore: cast_nullable_to_non_nullable
                      as List<WordBlock>,
            analyzedAt: null == analyzedAt
                ? _value.analyzedAt
                : analyzedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalysisResultImplCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$AnalysisResultImplCopyWith(
    _$AnalysisResultImpl value,
    $Res Function(_$AnalysisResultImpl) then,
  ) = __$$AnalysisResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String input, List<WordBlock> words, DateTime analyzedAt});
}

/// @nodoc
class __$$AnalysisResultImplCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$AnalysisResultImpl>
    implements _$$AnalysisResultImplCopyWith<$Res> {
  __$$AnalysisResultImplCopyWithImpl(
    _$AnalysisResultImpl _value,
    $Res Function(_$AnalysisResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? input = null,
    Object? words = null,
    Object? analyzedAt = null,
  }) {
    return _then(
      _$AnalysisResultImpl(
        input: null == input
            ? _value.input
            : input // ignore: cast_nullable_to_non_nullable
                  as String,
        words: null == words
            ? _value._words
            : words // ignore: cast_nullable_to_non_nullable
                  as List<WordBlock>,
        analyzedAt: null == analyzedAt
            ? _value.analyzedAt
            : analyzedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalysisResultImpl implements _AnalysisResult {
  const _$AnalysisResultImpl({
    required this.input,
    required final List<WordBlock> words,
    required this.analyzedAt,
  }) : _words = words;

  factory _$AnalysisResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalysisResultImplFromJson(json);

  @override
  final String input;
  final List<WordBlock> _words;
  @override
  List<WordBlock> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  final DateTime analyzedAt;

  @override
  String toString() {
    return 'AnalysisResult(input: $input, words: $words, analyzedAt: $analyzedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisResultImpl &&
            (identical(other.input, input) || other.input == input) &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    input,
    const DeepCollectionEquality().hash(_words),
    analyzedAt,
  );

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisResultImplCopyWith<_$AnalysisResultImpl> get copyWith =>
      __$$AnalysisResultImplCopyWithImpl<_$AnalysisResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalysisResultImplToJson(this);
  }
}

abstract class _AnalysisResult implements AnalysisResult {
  const factory _AnalysisResult({
    required final String input,
    required final List<WordBlock> words,
    required final DateTime analyzedAt,
  }) = _$AnalysisResultImpl;

  factory _AnalysisResult.fromJson(Map<String, dynamic> json) =
      _$AnalysisResultImpl.fromJson;

  @override
  String get input;
  @override
  List<WordBlock> get words;
  @override
  DateTime get analyzedAt;

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisResultImplCopyWith<_$AnalysisResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
