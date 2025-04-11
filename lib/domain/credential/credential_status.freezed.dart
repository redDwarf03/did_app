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
  /// ID unique de l'attestation
  String get credentialId => throw _privateConstructorUsedError;

  /// Type de statut
  CredentialStatusType get status => throw _privateConstructorUsedError;

  /// Date de la dernière vérification
  DateTime get lastChecked => throw _privateConstructorUsedError;

  /// Date de révocation (si applicable)
  DateTime? get revokedAt => throw _privateConstructorUsedError;

  /// Raison de la révocation (si applicable)
  RevocationReason? get revocationReason => throw _privateConstructorUsedError;

  /// Détails supplémentaires sur la révocation
  String? get revocationDetails => throw _privateConstructorUsedError;

  /// URL de la liste de statut
  String get statusListUrl => throw _privateConstructorUsedError;

  /// Index dans la liste de statut
  int get statusListIndex => throw _privateConstructorUsedError;

  /// Date d'expiration de l'attestation
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Date de la prochaine vérification
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

  /// ID unique de l'attestation
  @override
  final String credentialId;

  /// Type de statut
  @override
  final CredentialStatusType status;

  /// Date de la dernière vérification
  @override
  final DateTime lastChecked;

  /// Date de révocation (si applicable)
  @override
  final DateTime? revokedAt;

  /// Raison de la révocation (si applicable)
  @override
  final RevocationReason? revocationReason;

  /// Détails supplémentaires sur la révocation
  @override
  final String? revocationDetails;

  /// URL de la liste de statut
  @override
  final String statusListUrl;

  /// Index dans la liste de statut
  @override
  final int statusListIndex;

  /// Date d'expiration de l'attestation
  @override
  final DateTime? expiresAt;

  /// Date de la prochaine vérification
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

  /// ID unique de l'attestation
  @override
  String get credentialId;

  /// Type de statut
  @override
  CredentialStatusType get status;

  /// Date de la dernière vérification
  @override
  DateTime get lastChecked;

  /// Date de révocation (si applicable)
  @override
  DateTime? get revokedAt;

  /// Raison de la révocation (si applicable)
  @override
  RevocationReason? get revocationReason;

  /// Détails supplémentaires sur la révocation
  @override
  String? get revocationDetails;

  /// URL de la liste de statut
  @override
  String get statusListUrl;

  /// Index dans la liste de statut
  @override
  int get statusListIndex;

  /// Date d'expiration de l'attestation
  @override
  DateTime? get expiresAt;

  /// Date de la prochaine vérification
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
  /// ID de la liste de statut
  String get id => throw _privateConstructorUsedError;

  /// URL de la liste de statut
  String get url => throw _privateConstructorUsedError;

  /// Date de la dernière mise à jour
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Liste des statuts indexés
  Map<int, bool> get statuses => throw _privateConstructorUsedError;

  /// Taille de la liste
  int get size => throw _privateConstructorUsedError;

  /// Version de la liste
  String get version => throw _privateConstructorUsedError;

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
      String url,
      DateTime lastUpdated,
      Map<int, bool> statuses,
      int size,
      String version});
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
    Object? url = null,
    Object? lastUpdated = null,
    Object? statuses = null,
    Object? size = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
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
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
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
      String url,
      DateTime lastUpdated,
      Map<int, bool> statuses,
      int size,
      String version});
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
    Object? url = null,
    Object? lastUpdated = null,
    Object? statuses = null,
    Object? size = null,
    Object? version = null,
  }) {
    return _then(_$StatusListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
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
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusListImpl implements _StatusList {
  const _$StatusListImpl(
      {required this.id,
      required this.url,
      required this.lastUpdated,
      required final Map<int, bool> statuses,
      required this.size,
      required this.version})
      : _statuses = statuses;

  factory _$StatusListImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusListImplFromJson(json);

  /// ID de la liste de statut
  @override
  final String id;

  /// URL de la liste de statut
  @override
  final String url;

  /// Date de la dernière mise à jour
  @override
  final DateTime lastUpdated;

  /// Liste des statuts indexés
  final Map<int, bool> _statuses;

  /// Liste des statuts indexés
  @override
  Map<int, bool> get statuses {
    if (_statuses is EqualUnmodifiableMapView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statuses);
  }

  /// Taille de la liste
  @override
  final int size;

  /// Version de la liste
  @override
  final String version;

  @override
  String toString() {
    return 'StatusList(id: $id, url: $url, lastUpdated: $lastUpdated, statuses: $statuses, size: $size, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, lastUpdated,
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
      required final String url,
      required final DateTime lastUpdated,
      required final Map<int, bool> statuses,
      required final int size,
      required final String version}) = _$StatusListImpl;

  factory _StatusList.fromJson(Map<String, dynamic> json) =
      _$StatusListImpl.fromJson;

  /// ID de la liste de statut
  @override
  String get id;

  /// URL de la liste de statut
  @override
  String get url;

  /// Date de la dernière mise à jour
  @override
  DateTime get lastUpdated;

  /// Liste des statuts indexés
  @override
  Map<int, bool> get statuses;

  /// Taille de la liste
  @override
  int get size;

  /// Version de la liste
  @override
  String get version;

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
  /// ID de l'attestation vérifiée
  String get credentialId => throw _privateConstructorUsedError;

  /// Statut de l'attestation
  CredentialStatusType get status => throw _privateConstructorUsedError;

  /// Date de la vérification
  DateTime get checkedAt => throw _privateConstructorUsedError;

  /// Détails de la vérification
  String? get details => throw _privateConstructorUsedError;

  /// Erreur éventuelle
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

  /// ID de l'attestation vérifiée
  @override
  final String credentialId;

  /// Statut de l'attestation
  @override
  final CredentialStatusType status;

  /// Date de la vérification
  @override
  final DateTime checkedAt;

  /// Détails de la vérification
  @override
  final String? details;

  /// Erreur éventuelle
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

  /// ID de l'attestation vérifiée
  @override
  String get credentialId;

  /// Statut de l'attestation
  @override
  CredentialStatusType get status;

  /// Date de la vérification
  @override
  DateTime get checkedAt;

  /// Détails de la vérification
  @override
  String? get details;

  /// Erreur éventuelle
  @override
  String? get error;

  /// Create a copy of StatusCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusCheckResultImplCopyWith<_$StatusCheckResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
