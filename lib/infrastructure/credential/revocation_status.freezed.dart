// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revocation_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RevocationStatus _$RevocationStatusFromJson(Map<String, dynamic> json) {
  return _RevocationStatus.fromJson(json);
}

/// @nodoc
mixin _$RevocationStatus {
  /// Indicates whether the credential is confirmed revoked.
  bool get isRevoked => throw _privateConstructorUsedError;

  /// A message providing details about the status check outcome.
  String get message => throw _privateConstructorUsedError;

  /// Timestamp indicating when the status was last checked.
  DateTime get lastChecked => throw _privateConstructorUsedError;

  /// An optional error message if the status check failed.
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this RevocationStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevocationStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevocationStatusCopyWith<RevocationStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevocationStatusCopyWith<$Res> {
  factory $RevocationStatusCopyWith(
          RevocationStatus value, $Res Function(RevocationStatus) then) =
      _$RevocationStatusCopyWithImpl<$Res, RevocationStatus>;
  @useResult
  $Res call(
      {bool isRevoked, String message, DateTime lastChecked, String? error});
}

/// @nodoc
class _$RevocationStatusCopyWithImpl<$Res, $Val extends RevocationStatus>
    implements $RevocationStatusCopyWith<$Res> {
  _$RevocationStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevocationStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRevoked = null,
    Object? message = null,
    Object? lastChecked = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isRevoked: null == isRevoked
          ? _value.isRevoked
          : isRevoked // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      lastChecked: null == lastChecked
          ? _value.lastChecked
          : lastChecked // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevocationStatusImplCopyWith<$Res>
    implements $RevocationStatusCopyWith<$Res> {
  factory _$$RevocationStatusImplCopyWith(_$RevocationStatusImpl value,
          $Res Function(_$RevocationStatusImpl) then) =
      __$$RevocationStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isRevoked, String message, DateTime lastChecked, String? error});
}

/// @nodoc
class __$$RevocationStatusImplCopyWithImpl<$Res>
    extends _$RevocationStatusCopyWithImpl<$Res, _$RevocationStatusImpl>
    implements _$$RevocationStatusImplCopyWith<$Res> {
  __$$RevocationStatusImplCopyWithImpl(_$RevocationStatusImpl _value,
      $Res Function(_$RevocationStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of RevocationStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRevoked = null,
    Object? message = null,
    Object? lastChecked = null,
    Object? error = freezed,
  }) {
    return _then(_$RevocationStatusImpl(
      isRevoked: null == isRevoked
          ? _value.isRevoked
          : isRevoked // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      lastChecked: null == lastChecked
          ? _value.lastChecked
          : lastChecked // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevocationStatusImpl
    with DiagnosticableTreeMixin
    implements _RevocationStatus {
  const _$RevocationStatusImpl(
      {required this.isRevoked,
      required this.message,
      required this.lastChecked,
      this.error});

  factory _$RevocationStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevocationStatusImplFromJson(json);

  /// Indicates whether the credential is confirmed revoked.
  @override
  final bool isRevoked;

  /// A message providing details about the status check outcome.
  @override
  final String message;

  /// Timestamp indicating when the status was last checked.
  @override
  final DateTime lastChecked;

  /// An optional error message if the status check failed.
  @override
  final String? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RevocationStatus(isRevoked: $isRevoked, message: $message, lastChecked: $lastChecked, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RevocationStatus'))
      ..add(DiagnosticsProperty('isRevoked', isRevoked))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('lastChecked', lastChecked))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevocationStatusImpl &&
            (identical(other.isRevoked, isRevoked) ||
                other.isRevoked == isRevoked) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.lastChecked, lastChecked) ||
                other.lastChecked == lastChecked) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isRevoked, message, lastChecked, error);

  /// Create a copy of RevocationStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevocationStatusImplCopyWith<_$RevocationStatusImpl> get copyWith =>
      __$$RevocationStatusImplCopyWithImpl<_$RevocationStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevocationStatusImplToJson(
      this,
    );
  }
}

abstract class _RevocationStatus implements RevocationStatus {
  const factory _RevocationStatus(
      {required final bool isRevoked,
      required final String message,
      required final DateTime lastChecked,
      final String? error}) = _$RevocationStatusImpl;

  factory _RevocationStatus.fromJson(Map<String, dynamic> json) =
      _$RevocationStatusImpl.fromJson;

  /// Indicates whether the credential is confirmed revoked.
  @override
  bool get isRevoked;

  /// A message providing details about the status check outcome.
  @override
  String get message;

  /// Timestamp indicating when the status was last checked.
  @override
  DateTime get lastChecked;

  /// An optional error message if the status check failed.
  @override
  String? get error;

  /// Create a copy of RevocationStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevocationStatusImplCopyWith<_$RevocationStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
