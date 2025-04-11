// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credential_status_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CredentialStatusState {
  /// Liste des résultats de vérification
  Map<String, StatusCheckResult> get checkResults =>
      throw _privateConstructorUsedError;

  /// Indique si une vérification est en cours
  bool get isLoading => throw _privateConstructorUsedError;

  /// Erreur éventuelle
  String? get error => throw _privateConstructorUsedError;

  /// Date de la dernière vérification
  DateTime? get lastCheck => throw _privateConstructorUsedError;

  /// Prochaine vérification programmée
  DateTime? get nextCheck => throw _privateConstructorUsedError;

  /// Create a copy of CredentialStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialStatusStateCopyWith<CredentialStatusState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialStatusStateCopyWith<$Res> {
  factory $CredentialStatusStateCopyWith(CredentialStatusState value,
          $Res Function(CredentialStatusState) then) =
      _$CredentialStatusStateCopyWithImpl<$Res, CredentialStatusState>;
  @useResult
  $Res call(
      {Map<String, StatusCheckResult> checkResults,
      bool isLoading,
      String? error,
      DateTime? lastCheck,
      DateTime? nextCheck});
}

/// @nodoc
class _$CredentialStatusStateCopyWithImpl<$Res,
        $Val extends CredentialStatusState>
    implements $CredentialStatusStateCopyWith<$Res> {
  _$CredentialStatusStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialStatusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkResults = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? lastCheck = freezed,
    Object? nextCheck = freezed,
  }) {
    return _then(_value.copyWith(
      checkResults: null == checkResults
          ? _value.checkResults
          : checkResults // ignore: cast_nullable_to_non_nullable
              as Map<String, StatusCheckResult>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastCheck: freezed == lastCheck
          ? _value.lastCheck
          : lastCheck // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextCheck: freezed == nextCheck
          ? _value.nextCheck
          : nextCheck // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialStatusStateImplCopyWith<$Res>
    implements $CredentialStatusStateCopyWith<$Res> {
  factory _$$CredentialStatusStateImplCopyWith(
          _$CredentialStatusStateImpl value,
          $Res Function(_$CredentialStatusStateImpl) then) =
      __$$CredentialStatusStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, StatusCheckResult> checkResults,
      bool isLoading,
      String? error,
      DateTime? lastCheck,
      DateTime? nextCheck});
}

/// @nodoc
class __$$CredentialStatusStateImplCopyWithImpl<$Res>
    extends _$CredentialStatusStateCopyWithImpl<$Res,
        _$CredentialStatusStateImpl>
    implements _$$CredentialStatusStateImplCopyWith<$Res> {
  __$$CredentialStatusStateImplCopyWithImpl(_$CredentialStatusStateImpl _value,
      $Res Function(_$CredentialStatusStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialStatusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkResults = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? lastCheck = freezed,
    Object? nextCheck = freezed,
  }) {
    return _then(_$CredentialStatusStateImpl(
      checkResults: null == checkResults
          ? _value._checkResults
          : checkResults // ignore: cast_nullable_to_non_nullable
              as Map<String, StatusCheckResult>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastCheck: freezed == lastCheck
          ? _value.lastCheck
          : lastCheck // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextCheck: freezed == nextCheck
          ? _value.nextCheck
          : nextCheck // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$CredentialStatusStateImpl implements _CredentialStatusState {
  const _$CredentialStatusStateImpl(
      {required final Map<String, StatusCheckResult> checkResults,
      this.isLoading = false,
      this.error,
      this.lastCheck,
      this.nextCheck})
      : _checkResults = checkResults;

  /// Liste des résultats de vérification
  final Map<String, StatusCheckResult> _checkResults;

  /// Liste des résultats de vérification
  @override
  Map<String, StatusCheckResult> get checkResults {
    if (_checkResults is EqualUnmodifiableMapView) return _checkResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_checkResults);
  }

  /// Indique si une vérification est en cours
  @override
  @JsonKey()
  final bool isLoading;

  /// Erreur éventuelle
  @override
  final String? error;

  /// Date de la dernière vérification
  @override
  final DateTime? lastCheck;

  /// Prochaine vérification programmée
  @override
  final DateTime? nextCheck;

  @override
  String toString() {
    return 'CredentialStatusState(checkResults: $checkResults, isLoading: $isLoading, error: $error, lastCheck: $lastCheck, nextCheck: $nextCheck)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialStatusStateImpl &&
            const DeepCollectionEquality()
                .equals(other._checkResults, _checkResults) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastCheck, lastCheck) ||
                other.lastCheck == lastCheck) &&
            (identical(other.nextCheck, nextCheck) ||
                other.nextCheck == nextCheck));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_checkResults),
      isLoading,
      error,
      lastCheck,
      nextCheck);

  /// Create a copy of CredentialStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialStatusStateImplCopyWith<_$CredentialStatusStateImpl>
      get copyWith => __$$CredentialStatusStateImplCopyWithImpl<
          _$CredentialStatusStateImpl>(this, _$identity);
}

abstract class _CredentialStatusState implements CredentialStatusState {
  const factory _CredentialStatusState(
      {required final Map<String, StatusCheckResult> checkResults,
      final bool isLoading,
      final String? error,
      final DateTime? lastCheck,
      final DateTime? nextCheck}) = _$CredentialStatusStateImpl;

  /// Liste des résultats de vérification
  @override
  Map<String, StatusCheckResult> get checkResults;

  /// Indique si une vérification est en cours
  @override
  bool get isLoading;

  /// Erreur éventuelle
  @override
  String? get error;

  /// Date de la dernière vérification
  @override
  DateTime? get lastCheck;

  /// Prochaine vérification programmée
  @override
  DateTime? get nextCheck;

  /// Create a copy of CredentialStatusState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialStatusStateImplCopyWith<_$CredentialStatusStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
