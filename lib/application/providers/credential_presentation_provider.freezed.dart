// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credential_presentation_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CredentialPresentationState {
  /// Indicates if a presentation creation operation is in progress.
  bool get loading => throw _privateConstructorUsedError;

  /// Indicates if a presentation verification operation is in progress.
  bool get isValidating => throw _privateConstructorUsedError;

  /// The currently generated or processed credential presentation.
  CredentialPresentation? get presentation =>
      throw _privateConstructorUsedError;

  /// Holds a potential error message from the last operation.
  String? get error => throw _privateConstructorUsedError;

  /// Holds the result of the last presentation verification.
  VerificationResult? get verificationResult =>
      throw _privateConstructorUsedError;

  /// Create a copy of CredentialPresentationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialPresentationStateCopyWith<CredentialPresentationState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialPresentationStateCopyWith<$Res> {
  factory $CredentialPresentationStateCopyWith(
          CredentialPresentationState value,
          $Res Function(CredentialPresentationState) then) =
      _$CredentialPresentationStateCopyWithImpl<$Res,
          CredentialPresentationState>;
  @useResult
  $Res call(
      {bool loading,
      bool isValidating,
      CredentialPresentation? presentation,
      String? error,
      VerificationResult? verificationResult});

  $CredentialPresentationCopyWith<$Res>? get presentation;
  $VerificationResultCopyWith<$Res>? get verificationResult;
}

/// @nodoc
class _$CredentialPresentationStateCopyWithImpl<$Res,
        $Val extends CredentialPresentationState>
    implements $CredentialPresentationStateCopyWith<$Res> {
  _$CredentialPresentationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialPresentationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isValidating = null,
    Object? presentation = freezed,
    Object? error = freezed,
    Object? verificationResult = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidating: null == isValidating
          ? _value.isValidating
          : isValidating // ignore: cast_nullable_to_non_nullable
              as bool,
      presentation: freezed == presentation
          ? _value.presentation
          : presentation // ignore: cast_nullable_to_non_nullable
              as CredentialPresentation?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationResult: freezed == verificationResult
          ? _value.verificationResult
          : verificationResult // ignore: cast_nullable_to_non_nullable
              as VerificationResult?,
    ) as $Val);
  }

  /// Create a copy of CredentialPresentationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialPresentationCopyWith<$Res>? get presentation {
    if (_value.presentation == null) {
      return null;
    }

    return $CredentialPresentationCopyWith<$Res>(_value.presentation!, (value) {
      return _then(_value.copyWith(presentation: value) as $Val);
    });
  }

  /// Create a copy of CredentialPresentationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerificationResultCopyWith<$Res>? get verificationResult {
    if (_value.verificationResult == null) {
      return null;
    }

    return $VerificationResultCopyWith<$Res>(_value.verificationResult!,
        (value) {
      return _then(_value.copyWith(verificationResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CredentialPresentationStateImplCopyWith<$Res>
    implements $CredentialPresentationStateCopyWith<$Res> {
  factory _$$CredentialPresentationStateImplCopyWith(
          _$CredentialPresentationStateImpl value,
          $Res Function(_$CredentialPresentationStateImpl) then) =
      __$$CredentialPresentationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool isValidating,
      CredentialPresentation? presentation,
      String? error,
      VerificationResult? verificationResult});

  @override
  $CredentialPresentationCopyWith<$Res>? get presentation;
  @override
  $VerificationResultCopyWith<$Res>? get verificationResult;
}

/// @nodoc
class __$$CredentialPresentationStateImplCopyWithImpl<$Res>
    extends _$CredentialPresentationStateCopyWithImpl<$Res,
        _$CredentialPresentationStateImpl>
    implements _$$CredentialPresentationStateImplCopyWith<$Res> {
  __$$CredentialPresentationStateImplCopyWithImpl(
      _$CredentialPresentationStateImpl _value,
      $Res Function(_$CredentialPresentationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialPresentationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isValidating = null,
    Object? presentation = freezed,
    Object? error = freezed,
    Object? verificationResult = freezed,
  }) {
    return _then(_$CredentialPresentationStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidating: null == isValidating
          ? _value.isValidating
          : isValidating // ignore: cast_nullable_to_non_nullable
              as bool,
      presentation: freezed == presentation
          ? _value.presentation
          : presentation // ignore: cast_nullable_to_non_nullable
              as CredentialPresentation?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationResult: freezed == verificationResult
          ? _value.verificationResult
          : verificationResult // ignore: cast_nullable_to_non_nullable
              as VerificationResult?,
    ));
  }
}

/// @nodoc

class _$CredentialPresentationStateImpl extends _CredentialPresentationState {
  const _$CredentialPresentationStateImpl(
      {this.loading = false,
      this.isValidating = false,
      this.presentation,
      this.error,
      this.verificationResult})
      : super._();

  /// Indicates if a presentation creation operation is in progress.
  @override
  @JsonKey()
  final bool loading;

  /// Indicates if a presentation verification operation is in progress.
  @override
  @JsonKey()
  final bool isValidating;

  /// The currently generated or processed credential presentation.
  @override
  final CredentialPresentation? presentation;

  /// Holds a potential error message from the last operation.
  @override
  final String? error;

  /// Holds the result of the last presentation verification.
  @override
  final VerificationResult? verificationResult;

  @override
  String toString() {
    return 'CredentialPresentationState(loading: $loading, isValidating: $isValidating, presentation: $presentation, error: $error, verificationResult: $verificationResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialPresentationStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.isValidating, isValidating) ||
                other.isValidating == isValidating) &&
            (identical(other.presentation, presentation) ||
                other.presentation == presentation) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.verificationResult, verificationResult) ||
                other.verificationResult == verificationResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, isValidating,
      presentation, error, verificationResult);

  /// Create a copy of CredentialPresentationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialPresentationStateImplCopyWith<_$CredentialPresentationStateImpl>
      get copyWith => __$$CredentialPresentationStateImplCopyWithImpl<
          _$CredentialPresentationStateImpl>(this, _$identity);
}

abstract class _CredentialPresentationState
    extends CredentialPresentationState {
  const factory _CredentialPresentationState(
          {final bool loading,
          final bool isValidating,
          final CredentialPresentation? presentation,
          final String? error,
          final VerificationResult? verificationResult}) =
      _$CredentialPresentationStateImpl;
  const _CredentialPresentationState._() : super._();

  /// Indicates if a presentation creation operation is in progress.
  @override
  bool get loading;

  /// Indicates if a presentation verification operation is in progress.
  @override
  bool get isValidating;

  /// The currently generated or processed credential presentation.
  @override
  CredentialPresentation? get presentation;

  /// Holds a potential error message from the last operation.
  @override
  String? get error;

  /// Holds the result of the last presentation verification.
  @override
  VerificationResult? get verificationResult;

  /// Create a copy of CredentialPresentationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialPresentationStateImplCopyWith<_$CredentialPresentationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
