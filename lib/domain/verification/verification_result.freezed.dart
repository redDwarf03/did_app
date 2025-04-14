// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerificationResult _$VerificationResultFromJson(Map<String, dynamic> json) {
  return _VerificationResult.fromJson(json);
}

/// @nodoc
mixin _$VerificationResult {
  /// Whether the verification was successful.
  bool get isValid => throw _privateConstructorUsedError;

  /// An optional message providing details about the verification outcome (e.g., error reason).
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this VerificationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerificationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationResultCopyWith<VerificationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationResultCopyWith<$Res> {
  factory $VerificationResultCopyWith(
          VerificationResult value, $Res Function(VerificationResult) then) =
      _$VerificationResultCopyWithImpl<$Res, VerificationResult>;
  @useResult
  $Res call({bool isValid, String? message});
}

/// @nodoc
class _$VerificationResultCopyWithImpl<$Res, $Val extends VerificationResult>
    implements $VerificationResultCopyWith<$Res> {
  _$VerificationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationResultImplCopyWith<$Res>
    implements $VerificationResultCopyWith<$Res> {
  factory _$$VerificationResultImplCopyWith(_$VerificationResultImpl value,
          $Res Function(_$VerificationResultImpl) then) =
      __$$VerificationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isValid, String? message});
}

/// @nodoc
class __$$VerificationResultImplCopyWithImpl<$Res>
    extends _$VerificationResultCopyWithImpl<$Res, _$VerificationResultImpl>
    implements _$$VerificationResultImplCopyWith<$Res> {
  __$$VerificationResultImplCopyWithImpl(_$VerificationResultImpl _value,
      $Res Function(_$VerificationResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? message = freezed,
  }) {
    return _then(_$VerificationResultImpl(
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationResultImpl extends _VerificationResult {
  const _$VerificationResultImpl({required this.isValid, this.message})
      : super._();

  factory _$VerificationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationResultImplFromJson(json);

  /// Whether the verification was successful.
  @override
  final bool isValid;

  /// An optional message providing details about the verification outcome (e.g., error reason).
  @override
  final String? message;

  @override
  String toString() {
    return 'VerificationResult(isValid: $isValid, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationResultImpl &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isValid, message);

  /// Create a copy of VerificationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationResultImplCopyWith<_$VerificationResultImpl> get copyWith =>
      __$$VerificationResultImplCopyWithImpl<_$VerificationResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationResultImplToJson(
      this,
    );
  }
}

abstract class _VerificationResult extends VerificationResult {
  const factory _VerificationResult(
      {required final bool isValid,
      final String? message}) = _$VerificationResultImpl;
  const _VerificationResult._() : super._();

  factory _VerificationResult.fromJson(Map<String, dynamic> json) =
      _$VerificationResultImpl.fromJson;

  /// Whether the verification was successful.
  @override
  bool get isValid;

  /// An optional message providing details about the verification outcome (e.g., error reason).
  @override
  String? get message;

  /// Create a copy of VerificationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationResultImplCopyWith<_$VerificationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
