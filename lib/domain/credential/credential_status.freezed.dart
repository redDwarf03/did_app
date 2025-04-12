// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credential_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CredentialStatus _$CredentialStatusFromJson(Map<String, dynamic> json) {
  return _CredentialStatus.fromJson(json);
}

/// @nodoc
mixin _$CredentialStatus {
  /// The unique ID of the credential whose status this object represents.
  String get credentialId => throw _privateConstructorUsedError;

  /// The determined status of the credential. See [CredentialStatusType].
  CredentialStatusType get status => throw _privateConstructorUsedError;

  /// The timestamp when the credential's status was last successfully checked
  /// against its status mechanism (e.g., StatusList2021).
  DateTime get lastChecked => throw _privateConstructorUsedError;

  /// If the status is [CredentialStatusType.revoked], the timestamp when the revocation occurred.
  DateTime? get revokedAt => throw _privateConstructorUsedError;

  /// If the status is [CredentialStatusType.revoked], the reason for revocation.
  /// See [RevocationReason].
  RevocationReason? get revocationReason => throw _privateConstructorUsedError;

  /// Optional additional details regarding the revocation.
  String? get revocationDetails => throw _privateConstructorUsedError;

  /// The URL of the status list credential (e.g., a StatusList2021Credential)
  /// used to determine the status.
  String get statusListUrl => throw _privateConstructorUsedError;

  /// The index within the referenced status list that corresponds to this credential.
  int get statusListIndex => throw _privateConstructorUsedError;

  /// The expiration date of the credential itself, if applicable.
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// The timestamp when the status of this credential should be checked again.
  /// Useful for managing cache validity or polling frequency.
  DateTime get nextCheck => throw _privateConstructorUsedError;

  /// Serializes this CredentialStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialStatusCopyWith<CredentialStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialStatusCopyWith<$Res> {
  factory $CredentialStatusCopyWith(
          CredentialStatus value, $Res Function(CredentialStatus) then) =
      _$CredentialStatusCopyWithImpl<$Res, CredentialStatus>;
  @useResult
  $Res call(
      {String credentialId,
      CredentialStatusType status,
      DateTime lastChecked,
      DateTime? revokedAt,
      RevocationReason? revocationReason,
      String? revocationDetails,
      String statusListUrl,
      int statusListIndex,
      DateTime? expiresAt,
      DateTime nextCheck});
}

/// @nodoc
class _$CredentialStatusCopyWithImpl<$Res, $Val extends CredentialStatus>
    implements $CredentialStatusCopyWith<$Res> {
  _$CredentialStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? status = null,
    Object? lastChecked = null,
    Object? revokedAt = freezed,
    Object? revocationReason = freezed,
    Object? revocationDetails = freezed,
    Object? statusListUrl = null,
    Object? statusListIndex = null,
    Object? expiresAt = freezed,
    Object? nextCheck = null,
  }) {
    return _then(_value.copyWith(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CredentialStatusType,
      lastChecked: null == lastChecked
          ? _value.lastChecked
          : lastChecked // ignore: cast_nullable_to_non_nullable
              as DateTime,
      revokedAt: freezed == revokedAt
          ? _value.revokedAt
          : revokedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revocationReason: freezed == revocationReason
          ? _value.revocationReason
          : revocationReason // ignore: cast_nullable_to_non_nullable
              as RevocationReason?,
      revocationDetails: freezed == revocationDetails
          ? _value.revocationDetails
          : revocationDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      statusListUrl: null == statusListUrl
          ? _value.statusListUrl
          : statusListUrl // ignore: cast_nullable_to_non_nullable
              as String,
      statusListIndex: null == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextCheck: null == nextCheck
          ? _value.nextCheck
          : nextCheck // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialStatusImplCopyWith<$Res>
    implements $CredentialStatusCopyWith<$Res> {
  factory _$$CredentialStatusImplCopyWith(_$CredentialStatusImpl value,
          $Res Function(_$CredentialStatusImpl) then) =
      __$$CredentialStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String credentialId,
      CredentialStatusType status,
      DateTime lastChecked,
      DateTime? revokedAt,
      RevocationReason? revocationReason,
      String? revocationDetails,
      String statusListUrl,
      int statusListIndex,
      DateTime? expiresAt,
      DateTime nextCheck});
}

/// @nodoc
class __$$CredentialStatusImplCopyWithImpl<$Res>
    extends _$CredentialStatusCopyWithImpl<$Res, _$CredentialStatusImpl>
    implements _$$CredentialStatusImplCopyWith<$Res> {
  __$$CredentialStatusImplCopyWithImpl(_$CredentialStatusImpl _value,
      $Res Function(_$CredentialStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? status = null,
    Object? lastChecked = null,
    Object? revokedAt = freezed,
    Object? revocationReason = freezed,
    Object? revocationDetails = freezed,
    Object? statusListUrl = null,
    Object? statusListIndex = null,
    Object? expiresAt = freezed,
    Object? nextCheck = null,
  }) {
    return _then(_$CredentialStatusImpl(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CredentialStatusType,
      lastChecked: null == lastChecked
          ? _value.lastChecked
          : lastChecked // ignore: cast_nullable_to_non_nullable
              as DateTime,
      revokedAt: freezed == revokedAt
          ? _value.revokedAt
          : revokedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revocationReason: freezed == revocationReason
          ? _value.revocationReason
          : revocationReason // ignore: cast_nullable_to_non_nullable
              as RevocationReason?,
      revocationDetails: freezed == revocationDetails
          ? _value.revocationDetails
          : revocationDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      statusListUrl: null == statusListUrl
          ? _value.statusListUrl
          : statusListUrl // ignore: cast_nullable_to_non_nullable
              as String,
      statusListIndex: null == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextCheck: null == nextCheck
          ? _value.nextCheck
          : nextCheck // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialStatusImpl implements _CredentialStatus {
  const _$CredentialStatusImpl(
      {required this.credentialId,
      required this.status,
      required this.lastChecked,
      this.revokedAt,
      this.revocationReason,
      this.revocationDetails,
      required this.statusListUrl,
      required this.statusListIndex,
      this.expiresAt,
      required this.nextCheck});

  factory _$CredentialStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialStatusImplFromJson(json);

  /// The unique ID of the credential whose status this object represents.
  @override
  final String credentialId;

  /// The determined status of the credential. See [CredentialStatusType].
  @override
  final CredentialStatusType status;

  /// The timestamp when the credential's status was last successfully checked
  /// against its status mechanism (e.g., StatusList2021).
  @override
  final DateTime lastChecked;

  /// If the status is [CredentialStatusType.revoked], the timestamp when the revocation occurred.
  @override
  final DateTime? revokedAt;

  /// If the status is [CredentialStatusType.revoked], the reason for revocation.
  /// See [RevocationReason].
  @override
  final RevocationReason? revocationReason;

  /// Optional additional details regarding the revocation.
  @override
  final String? revocationDetails;

  /// The URL of the status list credential (e.g., a StatusList2021Credential)
  /// used to determine the status.
  @override
  final String statusListUrl;

  /// The index within the referenced status list that corresponds to this credential.
  @override
  final int statusListIndex;

  /// The expiration date of the credential itself, if applicable.
  @override
  final DateTime? expiresAt;

  /// The timestamp when the status of this credential should be checked again.
  /// Useful for managing cache validity or polling frequency.
  @override
  final DateTime nextCheck;

  @override
  String toString() {
    return 'CredentialStatus(credentialId: $credentialId, status: $status, lastChecked: $lastChecked, revokedAt: $revokedAt, revocationReason: $revocationReason, revocationDetails: $revocationDetails, statusListUrl: $statusListUrl, statusListIndex: $statusListIndex, expiresAt: $expiresAt, nextCheck: $nextCheck)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialStatusImpl &&
            (identical(other.credentialId, credentialId) ||
                other.credentialId == credentialId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastChecked, lastChecked) ||
                other.lastChecked == lastChecked) &&
            (identical(other.revokedAt, revokedAt) ||
                other.revokedAt == revokedAt) &&
            (identical(other.revocationReason, revocationReason) ||
                other.revocationReason == revocationReason) &&
            (identical(other.revocationDetails, revocationDetails) ||
                other.revocationDetails == revocationDetails) &&
            (identical(other.statusListUrl, statusListUrl) ||
                other.statusListUrl == statusListUrl) &&
            (identical(other.statusListIndex, statusListIndex) ||
                other.statusListIndex == statusListIndex) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.nextCheck, nextCheck) ||
                other.nextCheck == nextCheck));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      credentialId,
      status,
      lastChecked,
      revokedAt,
      revocationReason,
      revocationDetails,
      statusListUrl,
      statusListIndex,
      expiresAt,
      nextCheck);

  /// Create a copy of CredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialStatusImplCopyWith<_$CredentialStatusImpl> get copyWith =>
      __$$CredentialStatusImplCopyWithImpl<_$CredentialStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialStatusImplToJson(
      this,
    );
  }
}

abstract class _CredentialStatus implements CredentialStatus {
  const factory _CredentialStatus(
      {required final String credentialId,
      required final CredentialStatusType status,
      required final DateTime lastChecked,
      final DateTime? revokedAt,
      final RevocationReason? revocationReason,
      final String? revocationDetails,
      required final String statusListUrl,
      required final int statusListIndex,
      final DateTime? expiresAt,
      required final DateTime nextCheck}) = _$CredentialStatusImpl;

  factory _CredentialStatus.fromJson(Map<String, dynamic> json) =
      _$CredentialStatusImpl.fromJson;

  /// The unique ID of the credential whose status this object represents.
  @override
  String get credentialId;

  /// The determined status of the credential. See [CredentialStatusType].
  @override
  CredentialStatusType get status;

  /// The timestamp when the credential's status was last successfully checked
  /// against its status mechanism (e.g., StatusList2021).
  @override
  DateTime get lastChecked;

  /// If the status is [CredentialStatusType.revoked], the timestamp when the revocation occurred.
  @override
  DateTime? get revokedAt;

  /// If the status is [CredentialStatusType.revoked], the reason for revocation.
  /// See [RevocationReason].
  @override
  RevocationReason? get revocationReason;

  /// Optional additional details regarding the revocation.
  @override
  String? get revocationDetails;

  /// The URL of the status list credential (e.g., a StatusList2021Credential)
  /// used to determine the status.
  @override
  String get statusListUrl;

  /// The index within the referenced status list that corresponds to this credential.
  @override
  int get statusListIndex;

  /// The expiration date of the credential itself, if applicable.
  @override
  DateTime? get expiresAt;

  /// The timestamp when the status of this credential should be checked again.
  /// Useful for managing cache validity or polling frequency.
  @override
  DateTime get nextCheck;

  /// Create a copy of CredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialStatusImplCopyWith<_$CredentialStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusList _$StatusListFromJson(Map<String, dynamic> json) {
  return _StatusList.fromJson(json);
}

/// @nodoc
mixin _$StatusList {
  /// The identifier (usually the URL) of the source StatusList2021Credential.
  String get id =>
      throw _privateConstructorUsedError; // Corresponds to statusListUrl in CredentialStatus
// /// The URL of the status list (potentially redundant with id).
// required String url,
  /// Timestamp indicating when this local representation of the list was last updated
  /// from the source.
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// The decoded status information, mapping the status index to its boolean status
  /// (e.g., true might mean revoked/suspended, false means active).
  Map<int, bool> get statuses => throw _privateConstructorUsedError;

  /// The total number of status entries (bits) in the list.
  int get size => throw _privateConstructorUsedError;

  /// Optional version identifier for the status list, if provided by the source.
  String? get version => throw _privateConstructorUsedError;

  /// Serializes this StatusList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusListCopyWith<StatusList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusListCopyWith<$Res> {
  factory $StatusListCopyWith(
          StatusList value, $Res Function(StatusList) then) =
      _$StatusListCopyWithImpl<$Res, StatusList>;
  @useResult
  $Res call(
      {String id,
      DateTime lastUpdated,
      Map<int, bool> statuses,
      int size,
      String? version});
}

/// @nodoc
class _$StatusListCopyWithImpl<$Res, $Val extends StatusList>
    implements $StatusListCopyWith<$Res> {
  _$StatusListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastUpdated = null,
    Object? statuses = null,
    Object? size = null,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      statuses: null == statuses
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusListImplCopyWith<$Res>
    implements $StatusListCopyWith<$Res> {
  factory _$$StatusListImplCopyWith(
          _$StatusListImpl value, $Res Function(_$StatusListImpl) then) =
      __$$StatusListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime lastUpdated,
      Map<int, bool> statuses,
      int size,
      String? version});
}

/// @nodoc
class __$$StatusListImplCopyWithImpl<$Res>
    extends _$StatusListCopyWithImpl<$Res, _$StatusListImpl>
    implements _$$StatusListImplCopyWith<$Res> {
  __$$StatusListImplCopyWithImpl(
      _$StatusListImpl _value, $Res Function(_$StatusListImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastUpdated = null,
    Object? statuses = null,
    Object? size = null,
    Object? version = freezed,
  }) {
    return _then(_$StatusListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      statuses: null == statuses
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusListImpl implements _StatusList {
  const _$StatusListImpl(
      {required this.id,
      required this.lastUpdated,
      required final Map<int, bool> statuses,
      required this.size,
      this.version})
      : _statuses = statuses;

  factory _$StatusListImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusListImplFromJson(json);

  /// The identifier (usually the URL) of the source StatusList2021Credential.
  @override
  final String id;
// Corresponds to statusListUrl in CredentialStatus
// /// The URL of the status list (potentially redundant with id).
// required String url,
  /// Timestamp indicating when this local representation of the list was last updated
  /// from the source.
  @override
  final DateTime lastUpdated;

  /// The decoded status information, mapping the status index to its boolean status
  /// (e.g., true might mean revoked/suspended, false means active).
  final Map<int, bool> _statuses;

  /// The decoded status information, mapping the status index to its boolean status
  /// (e.g., true might mean revoked/suspended, false means active).
  @override
  Map<int, bool> get statuses {
    if (_statuses is EqualUnmodifiableMapView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statuses);
  }

  /// The total number of status entries (bits) in the list.
  @override
  final int size;

  /// Optional version identifier for the status list, if provided by the source.
  @override
  final String? version;

  @override
  String toString() {
    return 'StatusList(id: $id, lastUpdated: $lastUpdated, statuses: $statuses, size: $size, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, lastUpdated,
      const DeepCollectionEquality().hash(_statuses), size, version);

  /// Create a copy of StatusList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusListImplCopyWith<_$StatusListImpl> get copyWith =>
      __$$StatusListImplCopyWithImpl<_$StatusListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusListImplToJson(
      this,
    );
  }
}

abstract class _StatusList implements StatusList {
  const factory _StatusList(
      {required final String id,
      required final DateTime lastUpdated,
      required final Map<int, bool> statuses,
      required final int size,
      final String? version}) = _$StatusListImpl;

  factory _StatusList.fromJson(Map<String, dynamic> json) =
      _$StatusListImpl.fromJson;

  /// The identifier (usually the URL) of the source StatusList2021Credential.
  @override
  String get id; // Corresponds to statusListUrl in CredentialStatus
// /// The URL of the status list (potentially redundant with id).
// required String url,
  /// Timestamp indicating when this local representation of the list was last updated
  /// from the source.
  @override
  DateTime get lastUpdated;

  /// The decoded status information, mapping the status index to its boolean status
  /// (e.g., true might mean revoked/suspended, false means active).
  @override
  Map<int, bool> get statuses;

  /// The total number of status entries (bits) in the list.
  @override
  int get size;

  /// Optional version identifier for the status list, if provided by the source.
  @override
  String? get version;

  /// Create a copy of StatusList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusListImplCopyWith<_$StatusListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusCheckResult _$StatusCheckResultFromJson(Map<String, dynamic> json) {
  return _StatusCheckResult.fromJson(json);
}

/// @nodoc
mixin _$StatusCheckResult {
  /// The ID of the credential that was checked.
  String get credentialId => throw _privateConstructorUsedError;

  /// The status determined during the check. See [CredentialStatusType].
  CredentialStatusType get status => throw _privateConstructorUsedError;

  /// The timestamp when the check was performed.
  DateTime get checkedAt => throw _privateConstructorUsedError;

  /// Optional details about the verification process or the result.
  String? get details => throw _privateConstructorUsedError;

  /// Optional error message if the status check failed.
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this StatusCheckResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusCheckResultCopyWith<StatusCheckResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusCheckResultCopyWith<$Res> {
  factory $StatusCheckResultCopyWith(
          StatusCheckResult value, $Res Function(StatusCheckResult) then) =
      _$StatusCheckResultCopyWithImpl<$Res, StatusCheckResult>;
  @useResult
  $Res call(
      {String credentialId,
      CredentialStatusType status,
      DateTime checkedAt,
      String? details,
      String? error});
}

/// @nodoc
class _$StatusCheckResultCopyWithImpl<$Res, $Val extends StatusCheckResult>
    implements $StatusCheckResultCopyWith<$Res> {
  _$StatusCheckResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? status = null,
    Object? checkedAt = null,
    Object? details = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CredentialStatusType,
      checkedAt: null == checkedAt
          ? _value.checkedAt
          : checkedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusCheckResultImplCopyWith<$Res>
    implements $StatusCheckResultCopyWith<$Res> {
  factory _$$StatusCheckResultImplCopyWith(_$StatusCheckResultImpl value,
          $Res Function(_$StatusCheckResultImpl) then) =
      __$$StatusCheckResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String credentialId,
      CredentialStatusType status,
      DateTime checkedAt,
      String? details,
      String? error});
}

/// @nodoc
class __$$StatusCheckResultImplCopyWithImpl<$Res>
    extends _$StatusCheckResultCopyWithImpl<$Res, _$StatusCheckResultImpl>
    implements _$$StatusCheckResultImplCopyWith<$Res> {
  __$$StatusCheckResultImplCopyWithImpl(_$StatusCheckResultImpl _value,
      $Res Function(_$StatusCheckResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? status = null,
    Object? checkedAt = null,
    Object? details = freezed,
    Object? error = freezed,
  }) {
    return _then(_$StatusCheckResultImpl(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CredentialStatusType,
      checkedAt: null == checkedAt
          ? _value.checkedAt
          : checkedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusCheckResultImpl implements _StatusCheckResult {
  const _$StatusCheckResultImpl(
      {required this.credentialId,
      required this.status,
      required this.checkedAt,
      this.details,
      this.error});

  factory _$StatusCheckResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusCheckResultImplFromJson(json);

  /// The ID of the credential that was checked.
  @override
  final String credentialId;

  /// The status determined during the check. See [CredentialStatusType].
  @override
  final CredentialStatusType status;

  /// The timestamp when the check was performed.
  @override
  final DateTime checkedAt;

  /// Optional details about the verification process or the result.
  @override
  final String? details;

  /// Optional error message if the status check failed.
  @override
  final String? error;

  @override
  String toString() {
    return 'StatusCheckResult(credentialId: $credentialId, status: $status, checkedAt: $checkedAt, details: $details, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusCheckResultImpl &&
            (identical(other.credentialId, credentialId) ||
                other.credentialId == credentialId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.checkedAt, checkedAt) ||
                other.checkedAt == checkedAt) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, credentialId, status, checkedAt, details, error);

  /// Create a copy of StatusCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusCheckResultImplCopyWith<_$StatusCheckResultImpl> get copyWith =>
      __$$StatusCheckResultImplCopyWithImpl<_$StatusCheckResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusCheckResultImplToJson(
      this,
    );
  }
}

abstract class _StatusCheckResult implements StatusCheckResult {
  const factory _StatusCheckResult(
      {required final String credentialId,
      required final CredentialStatusType status,
      required final DateTime checkedAt,
      final String? details,
      final String? error}) = _$StatusCheckResultImpl;

  factory _StatusCheckResult.fromJson(Map<String, dynamic> json) =
      _$StatusCheckResultImpl.fromJson;

  /// The ID of the credential that was checked.
  @override
  String get credentialId;

  /// The status determined during the check. See [CredentialStatusType].
  @override
  CredentialStatusType get status;

  /// The timestamp when the check was performed.
  @override
  DateTime get checkedAt;

  /// Optional details about the verification process or the result.
  @override
  String? get details;

  /// Optional error message if the status check failed.
  @override
  String? get error;

  /// Create a copy of StatusCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusCheckResultImplCopyWith<_$StatusCheckResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
