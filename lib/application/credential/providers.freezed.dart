// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CredentialState {
  /// List of W3C Verifiable Credentials held by the user.
  List<Credential> get credentials => throw _privateConstructorUsedError;

  /// The currently selected W3C Credential (e.g., for viewing details).
  Credential? get selectedCredential => throw _privateConstructorUsedError;

  /// Loading indicator for W3C credential operations.
  bool get isLoading => throw _privateConstructorUsedError;

  /// Potential error message related to W3C credential operations.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// List of created W3C Verifiable Presentations.
  List<CredentialPresentation> get presentations =>
      throw _privateConstructorUsedError;

  /// The most recently created W3C Verifiable Presentation.
  CredentialPresentation? get lastPresentation =>
      throw _privateConstructorUsedError;

  /// Create a copy of CredentialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialStateCopyWith<CredentialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialStateCopyWith<$Res> {
  factory $CredentialStateCopyWith(
          CredentialState value, $Res Function(CredentialState) then) =
      _$CredentialStateCopyWithImpl<$Res, CredentialState>;
  @useResult
  $Res call(
      {List<Credential> credentials,
      Credential? selectedCredential,
      bool isLoading,
      String? errorMessage,
      List<CredentialPresentation> presentations,
      CredentialPresentation? lastPresentation});

  $CredentialCopyWith<$Res>? get selectedCredential;
  $CredentialPresentationCopyWith<$Res>? get lastPresentation;
}

/// @nodoc
class _$CredentialStateCopyWithImpl<$Res, $Val extends CredentialState>
    implements $CredentialStateCopyWith<$Res> {
  _$CredentialStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentials = null,
    Object? selectedCredential = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? presentations = null,
    Object? lastPresentation = freezed,
  }) {
    return _then(_value.copyWith(
      credentials: null == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as List<Credential>,
      selectedCredential: freezed == selectedCredential
          ? _value.selectedCredential
          : selectedCredential // ignore: cast_nullable_to_non_nullable
              as Credential?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      presentations: null == presentations
          ? _value.presentations
          : presentations // ignore: cast_nullable_to_non_nullable
              as List<CredentialPresentation>,
      lastPresentation: freezed == lastPresentation
          ? _value.lastPresentation
          : lastPresentation // ignore: cast_nullable_to_non_nullable
              as CredentialPresentation?,
    ) as $Val);
  }

  /// Create a copy of CredentialState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialCopyWith<$Res>? get selectedCredential {
    if (_value.selectedCredential == null) {
      return null;
    }

    return $CredentialCopyWith<$Res>(_value.selectedCredential!, (value) {
      return _then(_value.copyWith(selectedCredential: value) as $Val);
    });
  }

  /// Create a copy of CredentialState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialPresentationCopyWith<$Res>? get lastPresentation {
    if (_value.lastPresentation == null) {
      return null;
    }

    return $CredentialPresentationCopyWith<$Res>(_value.lastPresentation!,
        (value) {
      return _then(_value.copyWith(lastPresentation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CredentialStateImplCopyWith<$Res>
    implements $CredentialStateCopyWith<$Res> {
  factory _$$CredentialStateImplCopyWith(_$CredentialStateImpl value,
          $Res Function(_$CredentialStateImpl) then) =
      __$$CredentialStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Credential> credentials,
      Credential? selectedCredential,
      bool isLoading,
      String? errorMessage,
      List<CredentialPresentation> presentations,
      CredentialPresentation? lastPresentation});

  @override
  $CredentialCopyWith<$Res>? get selectedCredential;
  @override
  $CredentialPresentationCopyWith<$Res>? get lastPresentation;
}

/// @nodoc
class __$$CredentialStateImplCopyWithImpl<$Res>
    extends _$CredentialStateCopyWithImpl<$Res, _$CredentialStateImpl>
    implements _$$CredentialStateImplCopyWith<$Res> {
  __$$CredentialStateImplCopyWithImpl(
      _$CredentialStateImpl _value, $Res Function(_$CredentialStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentials = null,
    Object? selectedCredential = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? presentations = null,
    Object? lastPresentation = freezed,
  }) {
    return _then(_$CredentialStateImpl(
      credentials: null == credentials
          ? _value._credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as List<Credential>,
      selectedCredential: freezed == selectedCredential
          ? _value.selectedCredential
          : selectedCredential // ignore: cast_nullable_to_non_nullable
              as Credential?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      presentations: null == presentations
          ? _value._presentations
          : presentations // ignore: cast_nullable_to_non_nullable
              as List<CredentialPresentation>,
      lastPresentation: freezed == lastPresentation
          ? _value.lastPresentation
          : lastPresentation // ignore: cast_nullable_to_non_nullable
              as CredentialPresentation?,
    ));
  }
}

/// @nodoc

class _$CredentialStateImpl implements _CredentialState {
  const _$CredentialStateImpl(
      {final List<Credential> credentials = const [],
      this.selectedCredential,
      this.isLoading = false,
      this.errorMessage,
      final List<CredentialPresentation> presentations = const [],
      this.lastPresentation})
      : _credentials = credentials,
        _presentations = presentations;

  /// List of W3C Verifiable Credentials held by the user.
  final List<Credential> _credentials;

  /// List of W3C Verifiable Credentials held by the user.
  @override
  @JsonKey()
  List<Credential> get credentials {
    if (_credentials is EqualUnmodifiableListView) return _credentials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_credentials);
  }

  /// The currently selected W3C Credential (e.g., for viewing details).
  @override
  final Credential? selectedCredential;

  /// Loading indicator for W3C credential operations.
  @override
  @JsonKey()
  final bool isLoading;

  /// Potential error message related to W3C credential operations.
  @override
  final String? errorMessage;

  /// List of created W3C Verifiable Presentations.
  final List<CredentialPresentation> _presentations;

  /// List of created W3C Verifiable Presentations.
  @override
  @JsonKey()
  List<CredentialPresentation> get presentations {
    if (_presentations is EqualUnmodifiableListView) return _presentations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_presentations);
  }

  /// The most recently created W3C Verifiable Presentation.
  @override
  final CredentialPresentation? lastPresentation;

  @override
  String toString() {
    return 'CredentialState(credentials: $credentials, selectedCredential: $selectedCredential, isLoading: $isLoading, errorMessage: $errorMessage, presentations: $presentations, lastPresentation: $lastPresentation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialStateImpl &&
            const DeepCollectionEquality()
                .equals(other._credentials, _credentials) &&
            (identical(other.selectedCredential, selectedCredential) ||
                other.selectedCredential == selectedCredential) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._presentations, _presentations) &&
            (identical(other.lastPresentation, lastPresentation) ||
                other.lastPresentation == lastPresentation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_credentials),
      selectedCredential,
      isLoading,
      errorMessage,
      const DeepCollectionEquality().hash(_presentations),
      lastPresentation);

  /// Create a copy of CredentialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialStateImplCopyWith<_$CredentialStateImpl> get copyWith =>
      __$$CredentialStateImplCopyWithImpl<_$CredentialStateImpl>(
          this, _$identity);
}

abstract class _CredentialState implements CredentialState {
  const factory _CredentialState(
      {final List<Credential> credentials,
      final Credential? selectedCredential,
      final bool isLoading,
      final String? errorMessage,
      final List<CredentialPresentation> presentations,
      final CredentialPresentation? lastPresentation}) = _$CredentialStateImpl;

  /// List of W3C Verifiable Credentials held by the user.
  @override
  List<Credential> get credentials;

  /// The currently selected W3C Credential (e.g., for viewing details).
  @override
  Credential? get selectedCredential;

  /// Loading indicator for W3C credential operations.
  @override
  bool get isLoading;

  /// Potential error message related to W3C credential operations.
  @override
  String? get errorMessage;

  /// List of created W3C Verifiable Presentations.
  @override
  List<CredentialPresentation> get presentations;

  /// The most recently created W3C Verifiable Presentation.
  @override
  CredentialPresentation? get lastPresentation;

  /// Create a copy of CredentialState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialStateImplCopyWith<_$CredentialStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SimplifiedCredentialsState {
  /// List of simplified credentials.
  List<SimplifiedCredential> get credentials =>
      throw _privateConstructorUsedError;

  /// Loading indicator for simplified credential operations.
  bool get isLoading => throw _privateConstructorUsedError;

  /// Potential error message for simplified credential operations.
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of SimplifiedCredentialsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimplifiedCredentialsStateCopyWith<SimplifiedCredentialsState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimplifiedCredentialsStateCopyWith<$Res> {
  factory $SimplifiedCredentialsStateCopyWith(SimplifiedCredentialsState value,
          $Res Function(SimplifiedCredentialsState) then) =
      _$SimplifiedCredentialsStateCopyWithImpl<$Res,
          SimplifiedCredentialsState>;
  @useResult
  $Res call(
      {List<SimplifiedCredential> credentials, bool isLoading, String? error});
}

/// @nodoc
class _$SimplifiedCredentialsStateCopyWithImpl<$Res,
        $Val extends SimplifiedCredentialsState>
    implements $SimplifiedCredentialsStateCopyWith<$Res> {
  _$SimplifiedCredentialsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimplifiedCredentialsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentials = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      credentials: null == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as List<SimplifiedCredential>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SimplifiedCredentialsStateImplCopyWith<$Res>
    implements $SimplifiedCredentialsStateCopyWith<$Res> {
  factory _$$SimplifiedCredentialsStateImplCopyWith(
          _$SimplifiedCredentialsStateImpl value,
          $Res Function(_$SimplifiedCredentialsStateImpl) then) =
      __$$SimplifiedCredentialsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SimplifiedCredential> credentials, bool isLoading, String? error});
}

/// @nodoc
class __$$SimplifiedCredentialsStateImplCopyWithImpl<$Res>
    extends _$SimplifiedCredentialsStateCopyWithImpl<$Res,
        _$SimplifiedCredentialsStateImpl>
    implements _$$SimplifiedCredentialsStateImplCopyWith<$Res> {
  __$$SimplifiedCredentialsStateImplCopyWithImpl(
      _$SimplifiedCredentialsStateImpl _value,
      $Res Function(_$SimplifiedCredentialsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SimplifiedCredentialsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentials = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$SimplifiedCredentialsStateImpl(
      credentials: null == credentials
          ? _value._credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as List<SimplifiedCredential>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SimplifiedCredentialsStateImpl implements _SimplifiedCredentialsState {
  const _$SimplifiedCredentialsStateImpl(
      {final List<SimplifiedCredential> credentials = const [],
      this.isLoading = false,
      this.error})
      : _credentials = credentials;

  /// List of simplified credentials.
  final List<SimplifiedCredential> _credentials;

  /// List of simplified credentials.
  @override
  @JsonKey()
  List<SimplifiedCredential> get credentials {
    if (_credentials is EqualUnmodifiableListView) return _credentials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_credentials);
  }

  /// Loading indicator for simplified credential operations.
  @override
  @JsonKey()
  final bool isLoading;

  /// Potential error message for simplified credential operations.
  @override
  final String? error;

  @override
  String toString() {
    return 'SimplifiedCredentialsState(credentials: $credentials, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimplifiedCredentialsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._credentials, _credentials) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_credentials), isLoading, error);

  /// Create a copy of SimplifiedCredentialsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimplifiedCredentialsStateImplCopyWith<_$SimplifiedCredentialsStateImpl>
      get copyWith => __$$SimplifiedCredentialsStateImplCopyWithImpl<
          _$SimplifiedCredentialsStateImpl>(this, _$identity);
}

abstract class _SimplifiedCredentialsState
    implements SimplifiedCredentialsState {
  const factory _SimplifiedCredentialsState(
      {final List<SimplifiedCredential> credentials,
      final bool isLoading,
      final String? error}) = _$SimplifiedCredentialsStateImpl;

  /// List of simplified credentials.
  @override
  List<SimplifiedCredential> get credentials;

  /// Loading indicator for simplified credential operations.
  @override
  bool get isLoading;

  /// Potential error message for simplified credential operations.
  @override
  String? get error;

  /// Create a copy of SimplifiedCredentialsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimplifiedCredentialsStateImplCopyWith<_$SimplifiedCredentialsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
