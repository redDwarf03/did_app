// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometric_auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BiometricAuthState _$BiometricAuthStateFromJson(Map<String, dynamic> json) {
  return _BiometricAuthState.fromJson(json);
}

/// @nodoc
mixin _$BiometricAuthState {
  /// A list of biometric types supported by the current device.
  List<BiometricType> get availableBiometrics =>
      throw _privateConstructorUsedError;

  /// The specific biometric type currently configured or used for authentication.
  BiometricType get currentBiometricType => throw _privateConstructorUsedError;

  /// The current status of the authentication process. See [AuthStatus].
  AuthStatus get status => throw _privateConstructorUsedError;

  /// An optional message providing details about an authentication failure or error.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Indicates whether the user has enabled biometric authentication for the application.
  bool get isBiometricEnabled => throw _privateConstructorUsedError;

  /// Indicates whether Two-Factor Authentication (2FA), potentially involving biometrics
  /// as one factor, is enabled.
  bool get isTwoFactorEnabled => throw _privateConstructorUsedError;

  /// Indicates whether a passwordless authentication flow (potentially relying solely
  /// on biometrics after initial setup) is enabled.
  bool get isPasswordlessEnabled => throw _privateConstructorUsedError;

  /// Serializes this BiometricAuthState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BiometricAuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BiometricAuthStateCopyWith<BiometricAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BiometricAuthStateCopyWith<$Res> {
  factory $BiometricAuthStateCopyWith(
          BiometricAuthState value, $Res Function(BiometricAuthState) then) =
      _$BiometricAuthStateCopyWithImpl<$Res, BiometricAuthState>;
  @useResult
  $Res call(
      {List<BiometricType> availableBiometrics,
      BiometricType currentBiometricType,
      AuthStatus status,
      String? errorMessage,
      bool isBiometricEnabled,
      bool isTwoFactorEnabled,
      bool isPasswordlessEnabled});
}

/// @nodoc
class _$BiometricAuthStateCopyWithImpl<$Res, $Val extends BiometricAuthState>
    implements $BiometricAuthStateCopyWith<$Res> {
  _$BiometricAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BiometricAuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableBiometrics = null,
    Object? currentBiometricType = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? isBiometricEnabled = null,
    Object? isTwoFactorEnabled = null,
    Object? isPasswordlessEnabled = null,
  }) {
    return _then(_value.copyWith(
      availableBiometrics: null == availableBiometrics
          ? _value.availableBiometrics
          : availableBiometrics // ignore: cast_nullable_to_non_nullable
              as List<BiometricType>,
      currentBiometricType: null == currentBiometricType
          ? _value.currentBiometricType
          : currentBiometricType // ignore: cast_nullable_to_non_nullable
              as BiometricType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isBiometricEnabled: null == isBiometricEnabled
          ? _value.isBiometricEnabled
          : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isTwoFactorEnabled: null == isTwoFactorEnabled
          ? _value.isTwoFactorEnabled
          : isTwoFactorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isPasswordlessEnabled: null == isPasswordlessEnabled
          ? _value.isPasswordlessEnabled
          : isPasswordlessEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BiometricAuthStateImplCopyWith<$Res>
    implements $BiometricAuthStateCopyWith<$Res> {
  factory _$$BiometricAuthStateImplCopyWith(_$BiometricAuthStateImpl value,
          $Res Function(_$BiometricAuthStateImpl) then) =
      __$$BiometricAuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BiometricType> availableBiometrics,
      BiometricType currentBiometricType,
      AuthStatus status,
      String? errorMessage,
      bool isBiometricEnabled,
      bool isTwoFactorEnabled,
      bool isPasswordlessEnabled});
}

/// @nodoc
class __$$BiometricAuthStateImplCopyWithImpl<$Res>
    extends _$BiometricAuthStateCopyWithImpl<$Res, _$BiometricAuthStateImpl>
    implements _$$BiometricAuthStateImplCopyWith<$Res> {
  __$$BiometricAuthStateImplCopyWithImpl(_$BiometricAuthStateImpl _value,
      $Res Function(_$BiometricAuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BiometricAuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableBiometrics = null,
    Object? currentBiometricType = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? isBiometricEnabled = null,
    Object? isTwoFactorEnabled = null,
    Object? isPasswordlessEnabled = null,
  }) {
    return _then(_$BiometricAuthStateImpl(
      availableBiometrics: null == availableBiometrics
          ? _value._availableBiometrics
          : availableBiometrics // ignore: cast_nullable_to_non_nullable
              as List<BiometricType>,
      currentBiometricType: null == currentBiometricType
          ? _value.currentBiometricType
          : currentBiometricType // ignore: cast_nullable_to_non_nullable
              as BiometricType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isBiometricEnabled: null == isBiometricEnabled
          ? _value.isBiometricEnabled
          : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isTwoFactorEnabled: null == isTwoFactorEnabled
          ? _value.isTwoFactorEnabled
          : isTwoFactorEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isPasswordlessEnabled: null == isPasswordlessEnabled
          ? _value.isPasswordlessEnabled
          : isPasswordlessEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BiometricAuthStateImpl implements _BiometricAuthState {
  const _$BiometricAuthStateImpl(
      {final List<BiometricType> availableBiometrics = const [],
      this.currentBiometricType = BiometricType.none,
      this.status = AuthStatus.notAuthenticated,
      this.errorMessage,
      this.isBiometricEnabled = false,
      this.isTwoFactorEnabled = false,
      this.isPasswordlessEnabled = false})
      : _availableBiometrics = availableBiometrics;

  factory _$BiometricAuthStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BiometricAuthStateImplFromJson(json);

  /// A list of biometric types supported by the current device.
  final List<BiometricType> _availableBiometrics;

  /// A list of biometric types supported by the current device.
  @override
  @JsonKey()
  List<BiometricType> get availableBiometrics {
    if (_availableBiometrics is EqualUnmodifiableListView)
      return _availableBiometrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableBiometrics);
  }

  /// The specific biometric type currently configured or used for authentication.
  @override
  @JsonKey()
  final BiometricType currentBiometricType;

  /// The current status of the authentication process. See [AuthStatus].
  @override
  @JsonKey()
  final AuthStatus status;

  /// An optional message providing details about an authentication failure or error.
  @override
  final String? errorMessage;

  /// Indicates whether the user has enabled biometric authentication for the application.
  @override
  @JsonKey()
  final bool isBiometricEnabled;

  /// Indicates whether Two-Factor Authentication (2FA), potentially involving biometrics
  /// as one factor, is enabled.
  @override
  @JsonKey()
  final bool isTwoFactorEnabled;

  /// Indicates whether a passwordless authentication flow (potentially relying solely
  /// on biometrics after initial setup) is enabled.
  @override
  @JsonKey()
  final bool isPasswordlessEnabled;

  @override
  String toString() {
    return 'BiometricAuthState(availableBiometrics: $availableBiometrics, currentBiometricType: $currentBiometricType, status: $status, errorMessage: $errorMessage, isBiometricEnabled: $isBiometricEnabled, isTwoFactorEnabled: $isTwoFactorEnabled, isPasswordlessEnabled: $isPasswordlessEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BiometricAuthStateImpl &&
            const DeepCollectionEquality()
                .equals(other._availableBiometrics, _availableBiometrics) &&
            (identical(other.currentBiometricType, currentBiometricType) ||
                other.currentBiometricType == currentBiometricType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isBiometricEnabled, isBiometricEnabled) ||
                other.isBiometricEnabled == isBiometricEnabled) &&
            (identical(other.isTwoFactorEnabled, isTwoFactorEnabled) ||
                other.isTwoFactorEnabled == isTwoFactorEnabled) &&
            (identical(other.isPasswordlessEnabled, isPasswordlessEnabled) ||
                other.isPasswordlessEnabled == isPasswordlessEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableBiometrics),
      currentBiometricType,
      status,
      errorMessage,
      isBiometricEnabled,
      isTwoFactorEnabled,
      isPasswordlessEnabled);

  /// Create a copy of BiometricAuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BiometricAuthStateImplCopyWith<_$BiometricAuthStateImpl> get copyWith =>
      __$$BiometricAuthStateImplCopyWithImpl<_$BiometricAuthStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BiometricAuthStateImplToJson(
      this,
    );
  }
}

abstract class _BiometricAuthState implements BiometricAuthState {
  const factory _BiometricAuthState(
      {final List<BiometricType> availableBiometrics,
      final BiometricType currentBiometricType,
      final AuthStatus status,
      final String? errorMessage,
      final bool isBiometricEnabled,
      final bool isTwoFactorEnabled,
      final bool isPasswordlessEnabled}) = _$BiometricAuthStateImpl;

  factory _BiometricAuthState.fromJson(Map<String, dynamic> json) =
      _$BiometricAuthStateImpl.fromJson;

  /// A list of biometric types supported by the current device.
  @override
  List<BiometricType> get availableBiometrics;

  /// The specific biometric type currently configured or used for authentication.
  @override
  BiometricType get currentBiometricType;

  /// The current status of the authentication process. See [AuthStatus].
  @override
  AuthStatus get status;

  /// An optional message providing details about an authentication failure or error.
  @override
  String? get errorMessage;

  /// Indicates whether the user has enabled biometric authentication for the application.
  @override
  bool get isBiometricEnabled;

  /// Indicates whether Two-Factor Authentication (2FA), potentially involving biometrics
  /// as one factor, is enabled.
  @override
  bool get isTwoFactorEnabled;

  /// Indicates whether a passwordless authentication flow (potentially relying solely
  /// on biometrics after initial setup) is enabled.
  @override
  bool get isPasswordlessEnabled;

  /// Create a copy of BiometricAuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BiometricAuthStateImplCopyWith<_$BiometricAuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
