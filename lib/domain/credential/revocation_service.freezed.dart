// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revocation_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RevocationResult _$RevocationResultFromJson(Map<String, dynamic> json) {
  return _RevocationResult.fromJson(json);
}

/// @nodoc
mixin _$RevocationResult {
  /// The unique identifier of the credential that was targeted by the operation.
  String get credentialId => throw _privateConstructorUsedError;

  /// Indicates whether the revocation or un-revocation operation was successful.
  bool get success => throw _privateConstructorUsedError;

  /// An optional message providing details in case of failure (`success` is false).
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Optional additional details about the result of the operation.
  String? get details => throw _privateConstructorUsedError;

  /// The timestamp when the revocation or un-revocation operation was processed.
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this RevocationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevocationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevocationResultCopyWith<RevocationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevocationResultCopyWith<$Res> {
  factory $RevocationResultCopyWith(
          RevocationResult value, $Res Function(RevocationResult) then) =
      _$RevocationResultCopyWithImpl<$Res, RevocationResult>;
  @useResult
  $Res call(
      {String credentialId,
      bool success,
      String? errorMessage,
      String? details,
      DateTime timestamp});
}

/// @nodoc
class _$RevocationResultCopyWithImpl<$Res, $Val extends RevocationResult>
    implements $RevocationResultCopyWith<$Res> {
  _$RevocationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevocationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? success = null,
    Object? errorMessage = freezed,
    Object? details = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevocationResultImplCopyWith<$Res>
    implements $RevocationResultCopyWith<$Res> {
  factory _$$RevocationResultImplCopyWith(_$RevocationResultImpl value,
          $Res Function(_$RevocationResultImpl) then) =
      __$$RevocationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String credentialId,
      bool success,
      String? errorMessage,
      String? details,
      DateTime timestamp});
}

/// @nodoc
class __$$RevocationResultImplCopyWithImpl<$Res>
    extends _$RevocationResultCopyWithImpl<$Res, _$RevocationResultImpl>
    implements _$$RevocationResultImplCopyWith<$Res> {
  __$$RevocationResultImplCopyWithImpl(_$RevocationResultImpl _value,
      $Res Function(_$RevocationResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of RevocationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? success = null,
    Object? errorMessage = freezed,
    Object? details = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$RevocationResultImpl(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevocationResultImpl implements _RevocationResult {
  const _$RevocationResultImpl(
      {required this.credentialId,
      required this.success,
      this.errorMessage,
      this.details,
      required this.timestamp});

  factory _$RevocationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevocationResultImplFromJson(json);

  /// The unique identifier of the credential that was targeted by the operation.
  @override
  final String credentialId;

  /// Indicates whether the revocation or un-revocation operation was successful.
  @override
  final bool success;

  /// An optional message providing details in case of failure (`success` is false).
  @override
  final String? errorMessage;

  /// Optional additional details about the result of the operation.
  @override
  final String? details;

  /// The timestamp when the revocation or un-revocation operation was processed.
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'RevocationResult(credentialId: $credentialId, success: $success, errorMessage: $errorMessage, details: $details, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevocationResultImpl &&
            (identical(other.credentialId, credentialId) ||
                other.credentialId == credentialId) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, credentialId, success, errorMessage, details, timestamp);

  /// Create a copy of RevocationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevocationResultImplCopyWith<_$RevocationResultImpl> get copyWith =>
      __$$RevocationResultImplCopyWithImpl<_$RevocationResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevocationResultImplToJson(
      this,
    );
  }
}

abstract class _RevocationResult implements RevocationResult {
  const factory _RevocationResult(
      {required final String credentialId,
      required final bool success,
      final String? errorMessage,
      final String? details,
      required final DateTime timestamp}) = _$RevocationResultImpl;

  factory _RevocationResult.fromJson(Map<String, dynamic> json) =
      _$RevocationResultImpl.fromJson;

  /// The unique identifier of the credential that was targeted by the operation.
  @override
  String get credentialId;

  /// Indicates whether the revocation or un-revocation operation was successful.
  @override
  bool get success;

  /// An optional message providing details in case of failure (`success` is false).
  @override
  String? get errorMessage;

  /// Optional additional details about the result of the operation.
  @override
  String? get details;

  /// The timestamp when the revocation or un-revocation operation was processed.
  @override
  DateTime get timestamp;

  /// Create a copy of RevocationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevocationResultImplCopyWith<_$RevocationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevocationHistoryEntry _$RevocationHistoryEntryFromJson(
    Map<String, dynamic> json) {
  return _RevocationHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$RevocationHistoryEntry {
  /// The ID of the credential this history entry pertains to.
  String get credentialId => throw _privateConstructorUsedError;

  /// The timestamp when the revocation action occurred.
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// The specific action performed (revoke or un-revoke). See [RevocationAction].
  RevocationAction get action => throw _privateConstructorUsedError;

  /// The reason provided if the action was a revocation. See [RevocationReason].
  RevocationReason? get reason => throw _privateConstructorUsedError;

  /// Optional additional details about this specific history event.
  String? get details => throw _privateConstructorUsedError;

  /// An identifier for the entity (e.g., issuer DID, administrator ID) that performed the action.
  String get actor => throw _privateConstructorUsedError;

  /// Serializes this RevocationHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevocationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevocationHistoryEntryCopyWith<RevocationHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevocationHistoryEntryCopyWith<$Res> {
  factory $RevocationHistoryEntryCopyWith(RevocationHistoryEntry value,
          $Res Function(RevocationHistoryEntry) then) =
      _$RevocationHistoryEntryCopyWithImpl<$Res, RevocationHistoryEntry>;
  @useResult
  $Res call(
      {String credentialId,
      DateTime timestamp,
      RevocationAction action,
      RevocationReason? reason,
      String? details,
      String actor});
}

/// @nodoc
class _$RevocationHistoryEntryCopyWithImpl<$Res,
        $Val extends RevocationHistoryEntry>
    implements $RevocationHistoryEntryCopyWith<$Res> {
  _$RevocationHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevocationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? timestamp = null,
    Object? action = null,
    Object? reason = freezed,
    Object? details = freezed,
    Object? actor = null,
  }) {
    return _then(_value.copyWith(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as RevocationAction,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as RevocationReason?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      actor: null == actor
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevocationHistoryEntryImplCopyWith<$Res>
    implements $RevocationHistoryEntryCopyWith<$Res> {
  factory _$$RevocationHistoryEntryImplCopyWith(
          _$RevocationHistoryEntryImpl value,
          $Res Function(_$RevocationHistoryEntryImpl) then) =
      __$$RevocationHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String credentialId,
      DateTime timestamp,
      RevocationAction action,
      RevocationReason? reason,
      String? details,
      String actor});
}

/// @nodoc
class __$$RevocationHistoryEntryImplCopyWithImpl<$Res>
    extends _$RevocationHistoryEntryCopyWithImpl<$Res,
        _$RevocationHistoryEntryImpl>
    implements _$$RevocationHistoryEntryImplCopyWith<$Res> {
  __$$RevocationHistoryEntryImplCopyWithImpl(
      _$RevocationHistoryEntryImpl _value,
      $Res Function(_$RevocationHistoryEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of RevocationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? timestamp = null,
    Object? action = null,
    Object? reason = freezed,
    Object? details = freezed,
    Object? actor = null,
  }) {
    return _then(_$RevocationHistoryEntryImpl(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as RevocationAction,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as RevocationReason?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      actor: null == actor
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevocationHistoryEntryImpl implements _RevocationHistoryEntry {
  const _$RevocationHistoryEntryImpl(
      {required this.credentialId,
      required this.timestamp,
      required this.action,
      this.reason,
      this.details,
      required this.actor});

  factory _$RevocationHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevocationHistoryEntryImplFromJson(json);

  /// The ID of the credential this history entry pertains to.
  @override
  final String credentialId;

  /// The timestamp when the revocation action occurred.
  @override
  final DateTime timestamp;

  /// The specific action performed (revoke or un-revoke). See [RevocationAction].
  @override
  final RevocationAction action;

  /// The reason provided if the action was a revocation. See [RevocationReason].
  @override
  final RevocationReason? reason;

  /// Optional additional details about this specific history event.
  @override
  final String? details;

  /// An identifier for the entity (e.g., issuer DID, administrator ID) that performed the action.
  @override
  final String actor;

  @override
  String toString() {
    return 'RevocationHistoryEntry(credentialId: $credentialId, timestamp: $timestamp, action: $action, reason: $reason, details: $details, actor: $actor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevocationHistoryEntryImpl &&
            (identical(other.credentialId, credentialId) ||
                other.credentialId == credentialId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.actor, actor) || other.actor == actor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, credentialId, timestamp, action, reason, details, actor);

  /// Create a copy of RevocationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevocationHistoryEntryImplCopyWith<_$RevocationHistoryEntryImpl>
      get copyWith => __$$RevocationHistoryEntryImplCopyWithImpl<
          _$RevocationHistoryEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevocationHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _RevocationHistoryEntry implements RevocationHistoryEntry {
  const factory _RevocationHistoryEntry(
      {required final String credentialId,
      required final DateTime timestamp,
      required final RevocationAction action,
      final RevocationReason? reason,
      final String? details,
      required final String actor}) = _$RevocationHistoryEntryImpl;

  factory _RevocationHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$RevocationHistoryEntryImpl.fromJson;

  /// The ID of the credential this history entry pertains to.
  @override
  String get credentialId;

  /// The timestamp when the revocation action occurred.
  @override
  DateTime get timestamp;

  /// The specific action performed (revoke or un-revoke). See [RevocationAction].
  @override
  RevocationAction get action;

  /// The reason provided if the action was a revocation. See [RevocationReason].
  @override
  RevocationReason? get reason;

  /// Optional additional details about this specific history event.
  @override
  String? get details;

  /// An identifier for the entity (e.g., issuer DID, administrator ID) that performed the action.
  @override
  String get actor;

  /// Create a copy of RevocationHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevocationHistoryEntryImplCopyWith<_$RevocationHistoryEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
