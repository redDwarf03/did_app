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
mixin _$IdentityState {
  /// The user's detailed digital identity profile ([DigitalIdentity]).
  /// This holds personal information, verification status, etc.
  /// It is `null` if no identity has been created or loaded yet.
  DigitalIdentity? get identity => throw _privateConstructorUsedError;

  /// Indicates whether an identity-related operation (e.g., fetching, creating,
  /// updating) is currently in progress.
  bool get isLoading => throw _privateConstructorUsedError;

  /// Stores an error message if the last identity operation failed.
  /// `null` if the last operation was successful or no operation has been performed.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of IdentityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IdentityStateCopyWith<IdentityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentityStateCopyWith<$Res> {
  factory $IdentityStateCopyWith(
          IdentityState value, $Res Function(IdentityState) then) =
      _$IdentityStateCopyWithImpl<$Res, IdentityState>;
  @useResult
  $Res call({DigitalIdentity? identity, bool isLoading, String? errorMessage});

  $DigitalIdentityCopyWith<$Res>? get identity;
}

/// @nodoc
class _$IdentityStateCopyWithImpl<$Res, $Val extends IdentityState>
    implements $IdentityStateCopyWith<$Res> {
  _$IdentityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IdentityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identity = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      identity: freezed == identity
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as DigitalIdentity?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of IdentityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DigitalIdentityCopyWith<$Res>? get identity {
    if (_value.identity == null) {
      return null;
    }

    return $DigitalIdentityCopyWith<$Res>(_value.identity!, (value) {
      return _then(_value.copyWith(identity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IdentityStateImplCopyWith<$Res>
    implements $IdentityStateCopyWith<$Res> {
  factory _$$IdentityStateImplCopyWith(
          _$IdentityStateImpl value, $Res Function(_$IdentityStateImpl) then) =
      __$$IdentityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DigitalIdentity? identity, bool isLoading, String? errorMessage});

  @override
  $DigitalIdentityCopyWith<$Res>? get identity;
}

/// @nodoc
class __$$IdentityStateImplCopyWithImpl<$Res>
    extends _$IdentityStateCopyWithImpl<$Res, _$IdentityStateImpl>
    implements _$$IdentityStateImplCopyWith<$Res> {
  __$$IdentityStateImplCopyWithImpl(
      _$IdentityStateImpl _value, $Res Function(_$IdentityStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of IdentityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identity = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$IdentityStateImpl(
      identity: freezed == identity
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as DigitalIdentity?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$IdentityStateImpl implements _IdentityState {
  const _$IdentityStateImpl(
      {this.identity, this.isLoading = false, this.errorMessage});

  /// The user's detailed digital identity profile ([DigitalIdentity]).
  /// This holds personal information, verification status, etc.
  /// It is `null` if no identity has been created or loaded yet.
  @override
  final DigitalIdentity? identity;

  /// Indicates whether an identity-related operation (e.g., fetching, creating,
  /// updating) is currently in progress.
  @override
  @JsonKey()
  final bool isLoading;

  /// Stores an error message if the last identity operation failed.
  /// `null` if the last operation was successful or no operation has been performed.
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'IdentityState(identity: $identity, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdentityStateImpl &&
            (identical(other.identity, identity) ||
                other.identity == identity) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, identity, isLoading, errorMessage);

  /// Create a copy of IdentityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IdentityStateImplCopyWith<_$IdentityStateImpl> get copyWith =>
      __$$IdentityStateImplCopyWithImpl<_$IdentityStateImpl>(this, _$identity);
}

abstract class _IdentityState implements IdentityState {
  const factory _IdentityState(
      {final DigitalIdentity? identity,
      final bool isLoading,
      final String? errorMessage}) = _$IdentityStateImpl;

  /// The user's detailed digital identity profile ([DigitalIdentity]).
  /// This holds personal information, verification status, etc.
  /// It is `null` if no identity has been created or loaded yet.
  @override
  DigitalIdentity? get identity;

  /// Indicates whether an identity-related operation (e.g., fetching, creating,
  /// updating) is currently in progress.
  @override
  bool get isLoading;

  /// Stores an error message if the last identity operation failed.
  /// `null` if the last operation was successful or no operation has been performed.
  @override
  String? get errorMessage;

  /// Create a copy of IdentityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IdentityStateImplCopyWith<_$IdentityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
