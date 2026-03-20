// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WordBlock _$WordBlockFromJson(Map<String, dynamic> json) {
  return _WordBlock.fromJson(json);
}

/// @nodoc
mixin _$WordBlock {
  String get thai => throw _privateConstructorUsedError;
  String get roman => throw _privateConstructorUsedError;
  String get gloss => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
  List<ToneType> get tones => throw _privateConstructorUsedError;
  String get toneReason =>
      throw _privateConstructorUsedError; // Tone rule variables (populated by OpenAI, used to verify tone)
  String? get initialConsonant => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
  ConsonantClass? get consonantClass => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
  ToneMark? get toneMark => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
  SyllableType? get syllableType => throw _privateConstructorUsedError;
  int get sentenceIndex => throw _privateConstructorUsedError;
  List<String> get originalSyllables => throw _privateConstructorUsedError;
  List<SyllableBreakdown> get syllableBreakdowns =>
      throw _privateConstructorUsedError;

  /// Serializes this WordBlock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordBlockCopyWith<WordBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordBlockCopyWith<$Res> {
  factory $WordBlockCopyWith(WordBlock value, $Res Function(WordBlock) then) =
      _$WordBlockCopyWithImpl<$Res, WordBlock>;
  @useResult
  $Res call({
    String thai,
    String roman,
    String gloss,
    @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
    List<ToneType> tones,
    String toneReason,
    String? initialConsonant,
    @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
    ConsonantClass? consonantClass,
    @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
    ToneMark? toneMark,
    @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
    SyllableType? syllableType,
    int sentenceIndex,
    List<String> originalSyllables,
    List<SyllableBreakdown> syllableBreakdowns,
  });
}

/// @nodoc
class _$WordBlockCopyWithImpl<$Res, $Val extends WordBlock>
    implements $WordBlockCopyWith<$Res> {
  _$WordBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thai = null,
    Object? roman = null,
    Object? gloss = null,
    Object? tones = null,
    Object? toneReason = null,
    Object? initialConsonant = freezed,
    Object? consonantClass = freezed,
    Object? toneMark = freezed,
    Object? syllableType = freezed,
    Object? sentenceIndex = null,
    Object? originalSyllables = null,
    Object? syllableBreakdowns = null,
  }) {
    return _then(
      _value.copyWith(
            thai: null == thai
                ? _value.thai
                : thai // ignore: cast_nullable_to_non_nullable
                      as String,
            roman: null == roman
                ? _value.roman
                : roman // ignore: cast_nullable_to_non_nullable
                      as String,
            gloss: null == gloss
                ? _value.gloss
                : gloss // ignore: cast_nullable_to_non_nullable
                      as String,
            tones: null == tones
                ? _value.tones
                : tones // ignore: cast_nullable_to_non_nullable
                      as List<ToneType>,
            toneReason: null == toneReason
                ? _value.toneReason
                : toneReason // ignore: cast_nullable_to_non_nullable
                      as String,
            initialConsonant: freezed == initialConsonant
                ? _value.initialConsonant
                : initialConsonant // ignore: cast_nullable_to_non_nullable
                      as String?,
            consonantClass: freezed == consonantClass
                ? _value.consonantClass
                : consonantClass // ignore: cast_nullable_to_non_nullable
                      as ConsonantClass?,
            toneMark: freezed == toneMark
                ? _value.toneMark
                : toneMark // ignore: cast_nullable_to_non_nullable
                      as ToneMark?,
            syllableType: freezed == syllableType
                ? _value.syllableType
                : syllableType // ignore: cast_nullable_to_non_nullable
                      as SyllableType?,
            sentenceIndex: null == sentenceIndex
                ? _value.sentenceIndex
                : sentenceIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            originalSyllables: null == originalSyllables
                ? _value.originalSyllables
                : originalSyllables // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            syllableBreakdowns: null == syllableBreakdowns
                ? _value.syllableBreakdowns
                : syllableBreakdowns // ignore: cast_nullable_to_non_nullable
                      as List<SyllableBreakdown>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordBlockImplCopyWith<$Res>
    implements $WordBlockCopyWith<$Res> {
  factory _$$WordBlockImplCopyWith(
    _$WordBlockImpl value,
    $Res Function(_$WordBlockImpl) then,
  ) = __$$WordBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String thai,
    String roman,
    String gloss,
    @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
    List<ToneType> tones,
    String toneReason,
    String? initialConsonant,
    @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
    ConsonantClass? consonantClass,
    @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
    ToneMark? toneMark,
    @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
    SyllableType? syllableType,
    int sentenceIndex,
    List<String> originalSyllables,
    List<SyllableBreakdown> syllableBreakdowns,
  });
}

/// @nodoc
class __$$WordBlockImplCopyWithImpl<$Res>
    extends _$WordBlockCopyWithImpl<$Res, _$WordBlockImpl>
    implements _$$WordBlockImplCopyWith<$Res> {
  __$$WordBlockImplCopyWithImpl(
    _$WordBlockImpl _value,
    $Res Function(_$WordBlockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WordBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thai = null,
    Object? roman = null,
    Object? gloss = null,
    Object? tones = null,
    Object? toneReason = null,
    Object? initialConsonant = freezed,
    Object? consonantClass = freezed,
    Object? toneMark = freezed,
    Object? syllableType = freezed,
    Object? sentenceIndex = null,
    Object? originalSyllables = null,
    Object? syllableBreakdowns = null,
  }) {
    return _then(
      _$WordBlockImpl(
        thai: null == thai
            ? _value.thai
            : thai // ignore: cast_nullable_to_non_nullable
                  as String,
        roman: null == roman
            ? _value.roman
            : roman // ignore: cast_nullable_to_non_nullable
                  as String,
        gloss: null == gloss
            ? _value.gloss
            : gloss // ignore: cast_nullable_to_non_nullable
                  as String,
        tones: null == tones
            ? _value._tones
            : tones // ignore: cast_nullable_to_non_nullable
                  as List<ToneType>,
        toneReason: null == toneReason
            ? _value.toneReason
            : toneReason // ignore: cast_nullable_to_non_nullable
                  as String,
        initialConsonant: freezed == initialConsonant
            ? _value.initialConsonant
            : initialConsonant // ignore: cast_nullable_to_non_nullable
                  as String?,
        consonantClass: freezed == consonantClass
            ? _value.consonantClass
            : consonantClass // ignore: cast_nullable_to_non_nullable
                  as ConsonantClass?,
        toneMark: freezed == toneMark
            ? _value.toneMark
            : toneMark // ignore: cast_nullable_to_non_nullable
                  as ToneMark?,
        syllableType: freezed == syllableType
            ? _value.syllableType
            : syllableType // ignore: cast_nullable_to_non_nullable
                  as SyllableType?,
        sentenceIndex: null == sentenceIndex
            ? _value.sentenceIndex
            : sentenceIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        originalSyllables: null == originalSyllables
            ? _value._originalSyllables
            : originalSyllables // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        syllableBreakdowns: null == syllableBreakdowns
            ? _value._syllableBreakdowns
            : syllableBreakdowns // ignore: cast_nullable_to_non_nullable
                  as List<SyllableBreakdown>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WordBlockImpl implements _WordBlock {
  const _$WordBlockImpl({
    required this.thai,
    required this.roman,
    required this.gloss,
    @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
    final List<ToneType> tones = const [ToneType.mid],
    required this.toneReason,
    this.initialConsonant,
    @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
    this.consonantClass,
    @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
    this.toneMark,
    @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
    this.syllableType,
    this.sentenceIndex = 0,
    final List<String> originalSyllables = const [],
    final List<SyllableBreakdown> syllableBreakdowns = const [],
  }) : _tones = tones,
       _originalSyllables = originalSyllables,
       _syllableBreakdowns = syllableBreakdowns;

  factory _$WordBlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordBlockImplFromJson(json);

  @override
  final String thai;
  @override
  final String roman;
  @override
  final String gloss;
  final List<ToneType> _tones;
  @override
  @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
  List<ToneType> get tones {
    if (_tones is EqualUnmodifiableListView) return _tones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tones);
  }

  @override
  final String toneReason;
  // Tone rule variables (populated by OpenAI, used to verify tone)
  @override
  final String? initialConsonant;
  @override
  @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
  final ConsonantClass? consonantClass;
  @override
  @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
  final ToneMark? toneMark;
  @override
  @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
  final SyllableType? syllableType;
  @override
  @JsonKey()
  final int sentenceIndex;
  final List<String> _originalSyllables;
  @override
  @JsonKey()
  List<String> get originalSyllables {
    if (_originalSyllables is EqualUnmodifiableListView)
      return _originalSyllables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_originalSyllables);
  }

  final List<SyllableBreakdown> _syllableBreakdowns;
  @override
  @JsonKey()
  List<SyllableBreakdown> get syllableBreakdowns {
    if (_syllableBreakdowns is EqualUnmodifiableListView)
      return _syllableBreakdowns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syllableBreakdowns);
  }

  @override
  String toString() {
    return 'WordBlock(thai: $thai, roman: $roman, gloss: $gloss, tones: $tones, toneReason: $toneReason, initialConsonant: $initialConsonant, consonantClass: $consonantClass, toneMark: $toneMark, syllableType: $syllableType, sentenceIndex: $sentenceIndex, originalSyllables: $originalSyllables, syllableBreakdowns: $syllableBreakdowns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordBlockImpl &&
            (identical(other.thai, thai) || other.thai == thai) &&
            (identical(other.roman, roman) || other.roman == roman) &&
            (identical(other.gloss, gloss) || other.gloss == gloss) &&
            const DeepCollectionEquality().equals(other._tones, _tones) &&
            (identical(other.toneReason, toneReason) ||
                other.toneReason == toneReason) &&
            (identical(other.initialConsonant, initialConsonant) ||
                other.initialConsonant == initialConsonant) &&
            (identical(other.consonantClass, consonantClass) ||
                other.consonantClass == consonantClass) &&
            (identical(other.toneMark, toneMark) ||
                other.toneMark == toneMark) &&
            (identical(other.syllableType, syllableType) ||
                other.syllableType == syllableType) &&
            (identical(other.sentenceIndex, sentenceIndex) ||
                other.sentenceIndex == sentenceIndex) &&
            const DeepCollectionEquality().equals(
              other._originalSyllables,
              _originalSyllables,
            ) &&
            const DeepCollectionEquality().equals(
              other._syllableBreakdowns,
              _syllableBreakdowns,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    thai,
    roman,
    gloss,
    const DeepCollectionEquality().hash(_tones),
    toneReason,
    initialConsonant,
    consonantClass,
    toneMark,
    syllableType,
    sentenceIndex,
    const DeepCollectionEquality().hash(_originalSyllables),
    const DeepCollectionEquality().hash(_syllableBreakdowns),
  );

  /// Create a copy of WordBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordBlockImplCopyWith<_$WordBlockImpl> get copyWith =>
      __$$WordBlockImplCopyWithImpl<_$WordBlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordBlockImplToJson(this);
  }
}

abstract class _WordBlock implements WordBlock {
  const factory _WordBlock({
    required final String thai,
    required final String roman,
    required final String gloss,
    @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
    final List<ToneType> tones,
    required final String toneReason,
    final String? initialConsonant,
    @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
    final ConsonantClass? consonantClass,
    @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
    final ToneMark? toneMark,
    @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
    final SyllableType? syllableType,
    final int sentenceIndex,
    final List<String> originalSyllables,
    final List<SyllableBreakdown> syllableBreakdowns,
  }) = _$WordBlockImpl;

  factory _WordBlock.fromJson(Map<String, dynamic> json) =
      _$WordBlockImpl.fromJson;

  @override
  String get thai;
  @override
  String get roman;
  @override
  String get gloss;
  @override
  @JsonKey(fromJson: _tonesFromJson, toJson: _tonesToJson)
  List<ToneType> get tones;
  @override
  String get toneReason; // Tone rule variables (populated by OpenAI, used to verify tone)
  @override
  String? get initialConsonant;
  @override
  @JsonKey(fromJson: _consonantClassFromJson, toJson: _consonantClassToJson)
  ConsonantClass? get consonantClass;
  @override
  @JsonKey(fromJson: _toneMarkFromJson, toJson: _toneMarkToJson)
  ToneMark? get toneMark;
  @override
  @JsonKey(fromJson: _syllableTypeFromJson, toJson: _syllableTypeToJson)
  SyllableType? get syllableType;
  @override
  int get sentenceIndex;
  @override
  List<String> get originalSyllables;
  @override
  List<SyllableBreakdown> get syllableBreakdowns;

  /// Create a copy of WordBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordBlockImplCopyWith<_$WordBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhonemeBreakdown _$PhonemeBreakdownFromJson(Map<String, dynamic> json) {
  return _PhonemeBreakdown.fromJson(json);
}

/// @nodoc
mixin _$PhonemeBreakdown {
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'char')
  String get char_ => throw _privateConstructorUsedError;
  String get sound => throw _privateConstructorUsedError;
  String get zhApprox => throw _privateConstructorUsedError;
  bool get isSilent => throw _privateConstructorUsedError;

  /// Serializes this PhonemeBreakdown to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhonemeBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhonemeBreakdownCopyWith<PhonemeBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhonemeBreakdownCopyWith<$Res> {
  factory $PhonemeBreakdownCopyWith(
    PhonemeBreakdown value,
    $Res Function(PhonemeBreakdown) then,
  ) = _$PhonemeBreakdownCopyWithImpl<$Res, PhonemeBreakdown>;
  @useResult
  $Res call({
    String label,
    @JsonKey(name: 'char') String char_,
    String sound,
    String zhApprox,
    bool isSilent,
  });
}

/// @nodoc
class _$PhonemeBreakdownCopyWithImpl<$Res, $Val extends PhonemeBreakdown>
    implements $PhonemeBreakdownCopyWith<$Res> {
  _$PhonemeBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhonemeBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? char_ = null,
    Object? sound = null,
    Object? zhApprox = null,
    Object? isSilent = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            char_: null == char_
                ? _value.char_
                : char_ // ignore: cast_nullable_to_non_nullable
                      as String,
            sound: null == sound
                ? _value.sound
                : sound // ignore: cast_nullable_to_non_nullable
                      as String,
            zhApprox: null == zhApprox
                ? _value.zhApprox
                : zhApprox // ignore: cast_nullable_to_non_nullable
                      as String,
            isSilent: null == isSilent
                ? _value.isSilent
                : isSilent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhonemeBreakdownImplCopyWith<$Res>
    implements $PhonemeBreakdownCopyWith<$Res> {
  factory _$$PhonemeBreakdownImplCopyWith(
    _$PhonemeBreakdownImpl value,
    $Res Function(_$PhonemeBreakdownImpl) then,
  ) = __$$PhonemeBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String label,
    @JsonKey(name: 'char') String char_,
    String sound,
    String zhApprox,
    bool isSilent,
  });
}

/// @nodoc
class __$$PhonemeBreakdownImplCopyWithImpl<$Res>
    extends _$PhonemeBreakdownCopyWithImpl<$Res, _$PhonemeBreakdownImpl>
    implements _$$PhonemeBreakdownImplCopyWith<$Res> {
  __$$PhonemeBreakdownImplCopyWithImpl(
    _$PhonemeBreakdownImpl _value,
    $Res Function(_$PhonemeBreakdownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhonemeBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? char_ = null,
    Object? sound = null,
    Object? zhApprox = null,
    Object? isSilent = null,
  }) {
    return _then(
      _$PhonemeBreakdownImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        char_: null == char_
            ? _value.char_
            : char_ // ignore: cast_nullable_to_non_nullable
                  as String,
        sound: null == sound
            ? _value.sound
            : sound // ignore: cast_nullable_to_non_nullable
                  as String,
        zhApprox: null == zhApprox
            ? _value.zhApprox
            : zhApprox // ignore: cast_nullable_to_non_nullable
                  as String,
        isSilent: null == isSilent
            ? _value.isSilent
            : isSilent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhonemeBreakdownImpl implements _PhonemeBreakdown {
  const _$PhonemeBreakdownImpl({
    required this.label,
    @JsonKey(name: 'char') required this.char_,
    required this.sound,
    required this.zhApprox,
    this.isSilent = false,
  });

  factory _$PhonemeBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhonemeBreakdownImplFromJson(json);

  @override
  final String label;
  @override
  @JsonKey(name: 'char')
  final String char_;
  @override
  final String sound;
  @override
  final String zhApprox;
  @override
  @JsonKey()
  final bool isSilent;

  @override
  String toString() {
    return 'PhonemeBreakdown(label: $label, char_: $char_, sound: $sound, zhApprox: $zhApprox, isSilent: $isSilent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhonemeBreakdownImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.char_, char_) || other.char_ == char_) &&
            (identical(other.sound, sound) || other.sound == sound) &&
            (identical(other.zhApprox, zhApprox) ||
                other.zhApprox == zhApprox) &&
            (identical(other.isSilent, isSilent) ||
                other.isSilent == isSilent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, label, char_, sound, zhApprox, isSilent);

  /// Create a copy of PhonemeBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhonemeBreakdownImplCopyWith<_$PhonemeBreakdownImpl> get copyWith =>
      __$$PhonemeBreakdownImplCopyWithImpl<_$PhonemeBreakdownImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PhonemeBreakdownImplToJson(this);
  }
}

abstract class _PhonemeBreakdown implements PhonemeBreakdown {
  const factory _PhonemeBreakdown({
    required final String label,
    @JsonKey(name: 'char') required final String char_,
    required final String sound,
    required final String zhApprox,
    final bool isSilent,
  }) = _$PhonemeBreakdownImpl;

  factory _PhonemeBreakdown.fromJson(Map<String, dynamic> json) =
      _$PhonemeBreakdownImpl.fromJson;

  @override
  String get label;
  @override
  @JsonKey(name: 'char')
  String get char_;
  @override
  String get sound;
  @override
  String get zhApprox;
  @override
  bool get isSilent;

  /// Create a copy of PhonemeBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhonemeBreakdownImplCopyWith<_$PhonemeBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyllableBreakdown _$SyllableBreakdownFromJson(Map<String, dynamic> json) {
  return _SyllableBreakdown.fromJson(json);
}

/// @nodoc
mixin _$SyllableBreakdown {
  String get thai => throw _privateConstructorUsedError;
  String get originalThai => throw _privateConstructorUsedError;
  String get rtgs => throw _privateConstructorUsedError;
  String get tone => throw _privateConstructorUsedError;
  String get toneReason => throw _privateConstructorUsedError;
  String get gloss => throw _privateConstructorUsedError;
  List<PhonemeBreakdown> get parts => throw _privateConstructorUsedError;
  bool get isHoNam => throw _privateConstructorUsedError;
  bool get hasImplicitVowel => throw _privateConstructorUsedError;

  /// Serializes this SyllableBreakdown to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyllableBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyllableBreakdownCopyWith<SyllableBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyllableBreakdownCopyWith<$Res> {
  factory $SyllableBreakdownCopyWith(
    SyllableBreakdown value,
    $Res Function(SyllableBreakdown) then,
  ) = _$SyllableBreakdownCopyWithImpl<$Res, SyllableBreakdown>;
  @useResult
  $Res call({
    String thai,
    String originalThai,
    String rtgs,
    String tone,
    String toneReason,
    String gloss,
    List<PhonemeBreakdown> parts,
    bool isHoNam,
    bool hasImplicitVowel,
  });
}

/// @nodoc
class _$SyllableBreakdownCopyWithImpl<$Res, $Val extends SyllableBreakdown>
    implements $SyllableBreakdownCopyWith<$Res> {
  _$SyllableBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyllableBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thai = null,
    Object? originalThai = null,
    Object? rtgs = null,
    Object? tone = null,
    Object? toneReason = null,
    Object? gloss = null,
    Object? parts = null,
    Object? isHoNam = null,
    Object? hasImplicitVowel = null,
  }) {
    return _then(
      _value.copyWith(
            thai: null == thai
                ? _value.thai
                : thai // ignore: cast_nullable_to_non_nullable
                      as String,
            originalThai: null == originalThai
                ? _value.originalThai
                : originalThai // ignore: cast_nullable_to_non_nullable
                      as String,
            rtgs: null == rtgs
                ? _value.rtgs
                : rtgs // ignore: cast_nullable_to_non_nullable
                      as String,
            tone: null == tone
                ? _value.tone
                : tone // ignore: cast_nullable_to_non_nullable
                      as String,
            toneReason: null == toneReason
                ? _value.toneReason
                : toneReason // ignore: cast_nullable_to_non_nullable
                      as String,
            gloss: null == gloss
                ? _value.gloss
                : gloss // ignore: cast_nullable_to_non_nullable
                      as String,
            parts: null == parts
                ? _value.parts
                : parts // ignore: cast_nullable_to_non_nullable
                      as List<PhonemeBreakdown>,
            isHoNam: null == isHoNam
                ? _value.isHoNam
                : isHoNam // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasImplicitVowel: null == hasImplicitVowel
                ? _value.hasImplicitVowel
                : hasImplicitVowel // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SyllableBreakdownImplCopyWith<$Res>
    implements $SyllableBreakdownCopyWith<$Res> {
  factory _$$SyllableBreakdownImplCopyWith(
    _$SyllableBreakdownImpl value,
    $Res Function(_$SyllableBreakdownImpl) then,
  ) = __$$SyllableBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String thai,
    String originalThai,
    String rtgs,
    String tone,
    String toneReason,
    String gloss,
    List<PhonemeBreakdown> parts,
    bool isHoNam,
    bool hasImplicitVowel,
  });
}

/// @nodoc
class __$$SyllableBreakdownImplCopyWithImpl<$Res>
    extends _$SyllableBreakdownCopyWithImpl<$Res, _$SyllableBreakdownImpl>
    implements _$$SyllableBreakdownImplCopyWith<$Res> {
  __$$SyllableBreakdownImplCopyWithImpl(
    _$SyllableBreakdownImpl _value,
    $Res Function(_$SyllableBreakdownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SyllableBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thai = null,
    Object? originalThai = null,
    Object? rtgs = null,
    Object? tone = null,
    Object? toneReason = null,
    Object? gloss = null,
    Object? parts = null,
    Object? isHoNam = null,
    Object? hasImplicitVowel = null,
  }) {
    return _then(
      _$SyllableBreakdownImpl(
        thai: null == thai
            ? _value.thai
            : thai // ignore: cast_nullable_to_non_nullable
                  as String,
        originalThai: null == originalThai
            ? _value.originalThai
            : originalThai // ignore: cast_nullable_to_non_nullable
                  as String,
        rtgs: null == rtgs
            ? _value.rtgs
            : rtgs // ignore: cast_nullable_to_non_nullable
                  as String,
        tone: null == tone
            ? _value.tone
            : tone // ignore: cast_nullable_to_non_nullable
                  as String,
        toneReason: null == toneReason
            ? _value.toneReason
            : toneReason // ignore: cast_nullable_to_non_nullable
                  as String,
        gloss: null == gloss
            ? _value.gloss
            : gloss // ignore: cast_nullable_to_non_nullable
                  as String,
        parts: null == parts
            ? _value._parts
            : parts // ignore: cast_nullable_to_non_nullable
                  as List<PhonemeBreakdown>,
        isHoNam: null == isHoNam
            ? _value.isHoNam
            : isHoNam // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasImplicitVowel: null == hasImplicitVowel
            ? _value.hasImplicitVowel
            : hasImplicitVowel // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SyllableBreakdownImpl implements _SyllableBreakdown {
  const _$SyllableBreakdownImpl({
    required this.thai,
    this.originalThai = '',
    this.rtgs = '',
    this.tone = 'mid',
    this.toneReason = '',
    this.gloss = '…',
    final List<PhonemeBreakdown> parts = const [],
    this.isHoNam = false,
    this.hasImplicitVowel = false,
  }) : _parts = parts;

  factory _$SyllableBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyllableBreakdownImplFromJson(json);

  @override
  final String thai;
  @override
  @JsonKey()
  final String originalThai;
  @override
  @JsonKey()
  final String rtgs;
  @override
  @JsonKey()
  final String tone;
  @override
  @JsonKey()
  final String toneReason;
  @override
  @JsonKey()
  final String gloss;
  final List<PhonemeBreakdown> _parts;
  @override
  @JsonKey()
  List<PhonemeBreakdown> get parts {
    if (_parts is EqualUnmodifiableListView) return _parts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parts);
  }

  @override
  @JsonKey()
  final bool isHoNam;
  @override
  @JsonKey()
  final bool hasImplicitVowel;

  @override
  String toString() {
    return 'SyllableBreakdown(thai: $thai, originalThai: $originalThai, rtgs: $rtgs, tone: $tone, toneReason: $toneReason, gloss: $gloss, parts: $parts, isHoNam: $isHoNam, hasImplicitVowel: $hasImplicitVowel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyllableBreakdownImpl &&
            (identical(other.thai, thai) || other.thai == thai) &&
            (identical(other.originalThai, originalThai) ||
                other.originalThai == originalThai) &&
            (identical(other.rtgs, rtgs) || other.rtgs == rtgs) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.toneReason, toneReason) ||
                other.toneReason == toneReason) &&
            (identical(other.gloss, gloss) || other.gloss == gloss) &&
            const DeepCollectionEquality().equals(other._parts, _parts) &&
            (identical(other.isHoNam, isHoNam) || other.isHoNam == isHoNam) &&
            (identical(other.hasImplicitVowel, hasImplicitVowel) ||
                other.hasImplicitVowel == hasImplicitVowel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    thai,
    originalThai,
    rtgs,
    tone,
    toneReason,
    gloss,
    const DeepCollectionEquality().hash(_parts),
    isHoNam,
    hasImplicitVowel,
  );

  /// Create a copy of SyllableBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyllableBreakdownImplCopyWith<_$SyllableBreakdownImpl> get copyWith =>
      __$$SyllableBreakdownImplCopyWithImpl<_$SyllableBreakdownImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SyllableBreakdownImplToJson(this);
  }
}

abstract class _SyllableBreakdown implements SyllableBreakdown {
  const factory _SyllableBreakdown({
    required final String thai,
    final String originalThai,
    final String rtgs,
    final String tone,
    final String toneReason,
    final String gloss,
    final List<PhonemeBreakdown> parts,
    final bool isHoNam,
    final bool hasImplicitVowel,
  }) = _$SyllableBreakdownImpl;

  factory _SyllableBreakdown.fromJson(Map<String, dynamic> json) =
      _$SyllableBreakdownImpl.fromJson;

  @override
  String get thai;
  @override
  String get originalThai;
  @override
  String get rtgs;
  @override
  String get tone;
  @override
  String get toneReason;
  @override
  String get gloss;
  @override
  List<PhonemeBreakdown> get parts;
  @override
  bool get isHoNam;
  @override
  bool get hasImplicitVowel;

  /// Create a copy of SyllableBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyllableBreakdownImplCopyWith<_$SyllableBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
