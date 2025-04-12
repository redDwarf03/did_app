// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_list_2021.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StatusList2021Credential _$StatusList2021CredentialFromJson(
    Map<String, dynamic> json) {
  return _StatusList2021Credential.fromJson(json);
}

/// @nodoc
mixin _$StatusList2021Credential {
  /// The unique identifier (URI) for this Status List credential.
  String get id => throw _privateConstructorUsedError;

  /// The JSON-LD context(s). Must include the VC context and the StatusList2021 context.
  /// e.g., ["https://www.w3.org/2018/credentials/v1", "https://w3id.org/vc/status-list/2021/v1"]
  @JsonKey(name: '@context')
  List<String> get context => throw _privateConstructorUsedError;

  /// The type(s) of the credential. Must include "VerifiableCredential" and "StatusList2021Credential".
  List<String> get type => throw _privateConstructorUsedError;

  /// The DID or URI of the issuer of this status list credential.
  String get issuer => throw _privateConstructorUsedError;

  /// The date and time when this status list credential was issued.
  DateTime get issuanceDate => throw _privateConstructorUsedError;

  /// An optional date and time after which this status list credential is no longer valid.
  DateTime? get expirationDate => throw _privateConstructorUsedError;

  /// An optional human-readable description of the status list.
  String? get description => throw _privateConstructorUsedError;

  /// The main subject of the credential, containing the actual status list data.
  /// See [StatusList2021Subject].
  StatusList2021Subject get credentialSubject =>
      throw _privateConstructorUsedError;

  /// The cryptographic proof (e.g., digital signature) that binds the credential
  /// contents to the issuer and ensures integrity.
  /// See [StatusList2021Proof].
  StatusList2021Proof get proof => throw _privateConstructorUsedError;

  /// Serializes this StatusList2021Credential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusList2021Credential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusList2021CredentialCopyWith<StatusList2021Credential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusList2021CredentialCopyWith<$Res> {
  factory $StatusList2021CredentialCopyWith(StatusList2021Credential value,
          $Res Function(StatusList2021Credential) then) =
      _$StatusList2021CredentialCopyWithImpl<$Res, StatusList2021Credential>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: '@context') List<String> context,
      List<String> type,
      String issuer,
      DateTime issuanceDate,
      DateTime? expirationDate,
      String? description,
      StatusList2021Subject credentialSubject,
      StatusList2021Proof proof});

  $StatusList2021SubjectCopyWith<$Res> get credentialSubject;
  $StatusList2021ProofCopyWith<$Res> get proof;
}

/// @nodoc
class _$StatusList2021CredentialCopyWithImpl<$Res,
        $Val extends StatusList2021Credential>
    implements $StatusList2021CredentialCopyWith<$Res> {
  _$StatusList2021CredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusList2021Credential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? context = null,
    Object? type = null,
    Object? issuer = null,
    Object? issuanceDate = null,
    Object? expirationDate = freezed,
    Object? description = freezed,
    Object? credentialSubject = null,
    Object? proof = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      credentialSubject: null == credentialSubject
          ? _value.credentialSubject
          : credentialSubject // ignore: cast_nullable_to_non_nullable
              as StatusList2021Subject,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as StatusList2021Proof,
    ) as $Val);
  }

  /// Create a copy of StatusList2021Credential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusList2021SubjectCopyWith<$Res> get credentialSubject {
    return $StatusList2021SubjectCopyWith<$Res>(_value.credentialSubject,
        (value) {
      return _then(_value.copyWith(credentialSubject: value) as $Val);
    });
  }

  /// Create a copy of StatusList2021Credential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusList2021ProofCopyWith<$Res> get proof {
    return $StatusList2021ProofCopyWith<$Res>(_value.proof, (value) {
      return _then(_value.copyWith(proof: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StatusList2021CredentialImplCopyWith<$Res>
    implements $StatusList2021CredentialCopyWith<$Res> {
  factory _$$StatusList2021CredentialImplCopyWith(
          _$StatusList2021CredentialImpl value,
          $Res Function(_$StatusList2021CredentialImpl) then) =
      __$$StatusList2021CredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: '@context') List<String> context,
      List<String> type,
      String issuer,
      DateTime issuanceDate,
      DateTime? expirationDate,
      String? description,
      StatusList2021Subject credentialSubject,
      StatusList2021Proof proof});

  @override
  $StatusList2021SubjectCopyWith<$Res> get credentialSubject;
  @override
  $StatusList2021ProofCopyWith<$Res> get proof;
}

/// @nodoc
class __$$StatusList2021CredentialImplCopyWithImpl<$Res>
    extends _$StatusList2021CredentialCopyWithImpl<$Res,
        _$StatusList2021CredentialImpl>
    implements _$$StatusList2021CredentialImplCopyWith<$Res> {
  __$$StatusList2021CredentialImplCopyWithImpl(
      _$StatusList2021CredentialImpl _value,
      $Res Function(_$StatusList2021CredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusList2021Credential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? context = null,
    Object? type = null,
    Object? issuer = null,
    Object? issuanceDate = null,
    Object? expirationDate = freezed,
    Object? description = freezed,
    Object? credentialSubject = null,
    Object? proof = null,
  }) {
    return _then(_$StatusList2021CredentialImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      context: null == context
          ? _value._context
          : context // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      credentialSubject: null == credentialSubject
          ? _value.credentialSubject
          : credentialSubject // ignore: cast_nullable_to_non_nullable
              as StatusList2021Subject,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as StatusList2021Proof,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusList2021CredentialImpl implements _StatusList2021Credential {
  const _$StatusList2021CredentialImpl(
      {required this.id,
      @JsonKey(name: '@context') required final List<String> context,
      required final List<String> type,
      required this.issuer,
      required this.issuanceDate,
      this.expirationDate,
      this.description,
      required this.credentialSubject,
      required this.proof})
      : _context = context,
        _type = type;

  factory _$StatusList2021CredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusList2021CredentialImplFromJson(json);

  /// The unique identifier (URI) for this Status List credential.
  @override
  final String id;

  /// The JSON-LD context(s). Must include the VC context and the StatusList2021 context.
  /// e.g., ["https://www.w3.org/2018/credentials/v1", "https://w3id.org/vc/status-list/2021/v1"]
  final List<String> _context;

  /// The JSON-LD context(s). Must include the VC context and the StatusList2021 context.
  /// e.g., ["https://www.w3.org/2018/credentials/v1", "https://w3id.org/vc/status-list/2021/v1"]
  @override
  @JsonKey(name: '@context')
  List<String> get context {
    if (_context is EqualUnmodifiableListView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_context);
  }

  /// The type(s) of the credential. Must include "VerifiableCredential" and "StatusList2021Credential".
  final List<String> _type;

  /// The type(s) of the credential. Must include "VerifiableCredential" and "StatusList2021Credential".
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  /// The DID or URI of the issuer of this status list credential.
  @override
  final String issuer;

  /// The date and time when this status list credential was issued.
  @override
  final DateTime issuanceDate;

  /// An optional date and time after which this status list credential is no longer valid.
  @override
  final DateTime? expirationDate;

  /// An optional human-readable description of the status list.
  @override
  final String? description;

  /// The main subject of the credential, containing the actual status list data.
  /// See [StatusList2021Subject].
  @override
  final StatusList2021Subject credentialSubject;

  /// The cryptographic proof (e.g., digital signature) that binds the credential
  /// contents to the issuer and ensures integrity.
  /// See [StatusList2021Proof].
  @override
  final StatusList2021Proof proof;

  @override
  String toString() {
    return 'StatusList2021Credential(id: $id, context: $context, type: $type, issuer: $issuer, issuanceDate: $issuanceDate, expirationDate: $expirationDate, description: $description, credentialSubject: $credentialSubject, proof: $proof)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusList2021CredentialImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.issuanceDate, issuanceDate) ||
                other.issuanceDate == issuanceDate) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.credentialSubject, credentialSubject) ||
                other.credentialSubject == credentialSubject) &&
            (identical(other.proof, proof) || other.proof == proof));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_context),
      const DeepCollectionEquality().hash(_type),
      issuer,
      issuanceDate,
      expirationDate,
      description,
      credentialSubject,
      proof);

  /// Create a copy of StatusList2021Credential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusList2021CredentialImplCopyWith<_$StatusList2021CredentialImpl>
      get copyWith => __$$StatusList2021CredentialImplCopyWithImpl<
          _$StatusList2021CredentialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusList2021CredentialImplToJson(
      this,
    );
  }
}

abstract class _StatusList2021Credential implements StatusList2021Credential {
  const factory _StatusList2021Credential(
          {required final String id,
          @JsonKey(name: '@context') required final List<String> context,
          required final List<String> type,
          required final String issuer,
          required final DateTime issuanceDate,
          final DateTime? expirationDate,
          final String? description,
          required final StatusList2021Subject credentialSubject,
          required final StatusList2021Proof proof}) =
      _$StatusList2021CredentialImpl;

  factory _StatusList2021Credential.fromJson(Map<String, dynamic> json) =
      _$StatusList2021CredentialImpl.fromJson;

  /// The unique identifier (URI) for this Status List credential.
  @override
  String get id;

  /// The JSON-LD context(s). Must include the VC context and the StatusList2021 context.
  /// e.g., ["https://www.w3.org/2018/credentials/v1", "https://w3id.org/vc/status-list/2021/v1"]
  @override
  @JsonKey(name: '@context')
  List<String> get context;

  /// The type(s) of the credential. Must include "VerifiableCredential" and "StatusList2021Credential".
  @override
  List<String> get type;

  /// The DID or URI of the issuer of this status list credential.
  @override
  String get issuer;

  /// The date and time when this status list credential was issued.
  @override
  DateTime get issuanceDate;

  /// An optional date and time after which this status list credential is no longer valid.
  @override
  DateTime? get expirationDate;

  /// An optional human-readable description of the status list.
  @override
  String? get description;

  /// The main subject of the credential, containing the actual status list data.
  /// See [StatusList2021Subject].
  @override
  StatusList2021Subject get credentialSubject;

  /// The cryptographic proof (e.g., digital signature) that binds the credential
  /// contents to the issuer and ensures integrity.
  /// See [StatusList2021Proof].
  @override
  StatusList2021Proof get proof;

  /// Create a copy of StatusList2021Credential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusList2021CredentialImplCopyWith<_$StatusList2021CredentialImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StatusList2021Subject _$StatusList2021SubjectFromJson(
    Map<String, dynamic> json) {
  return _StatusList2021Subject.fromJson(json);
}

/// @nodoc
mixin _$StatusList2021Subject {
  /// An identifier for the subject, often the same as the credential ID or related.
  String get id => throw _privateConstructorUsedError;

  /// The type of the credential subject. Must be "StatusList2021".
  String get type => throw _privateConstructorUsedError;

  /// Specifies the purpose of the status entries (e.g., revocation, suspension).
  /// See [StatusPurpose].
  StatusPurpose get statusPurpose => throw _privateConstructorUsedError;

  /// The encoding format used for the `encodedList`. Defaults to "base64url".
  /// Other potential values might include "base64", although "base64url" is common.
  String get encoding => throw _privateConstructorUsedError;

  /// The core status list, represented as a compressed bitstring, encoded according
  /// to the specified `encoding` (typically base64url).
  /// Each bit in the decoded list corresponds to a specific `statusListIndex` from a
  /// [StatusList2021Entry]. A '1' usually indicates the status applies (e.g., revoked),
  /// while a '0' indicates it does not.
  String get encodedList => throw _privateConstructorUsedError;

  /// Serializes this StatusList2021Subject to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusList2021Subject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusList2021SubjectCopyWith<StatusList2021Subject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusList2021SubjectCopyWith<$Res> {
  factory $StatusList2021SubjectCopyWith(StatusList2021Subject value,
          $Res Function(StatusList2021Subject) then) =
      _$StatusList2021SubjectCopyWithImpl<$Res, StatusList2021Subject>;
  @useResult
  $Res call(
      {String id,
      String type,
      StatusPurpose statusPurpose,
      String encoding,
      String encodedList});
}

/// @nodoc
class _$StatusList2021SubjectCopyWithImpl<$Res,
        $Val extends StatusList2021Subject>
    implements $StatusList2021SubjectCopyWith<$Res> {
  _$StatusList2021SubjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusList2021Subject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? statusPurpose = null,
    Object? encoding = null,
    Object? encodedList = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      statusPurpose: null == statusPurpose
          ? _value.statusPurpose
          : statusPurpose // ignore: cast_nullable_to_non_nullable
              as StatusPurpose,
      encoding: null == encoding
          ? _value.encoding
          : encoding // ignore: cast_nullable_to_non_nullable
              as String,
      encodedList: null == encodedList
          ? _value.encodedList
          : encodedList // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusList2021SubjectImplCopyWith<$Res>
    implements $StatusList2021SubjectCopyWith<$Res> {
  factory _$$StatusList2021SubjectImplCopyWith(
          _$StatusList2021SubjectImpl value,
          $Res Function(_$StatusList2021SubjectImpl) then) =
      __$$StatusList2021SubjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      StatusPurpose statusPurpose,
      String encoding,
      String encodedList});
}

/// @nodoc
class __$$StatusList2021SubjectImplCopyWithImpl<$Res>
    extends _$StatusList2021SubjectCopyWithImpl<$Res,
        _$StatusList2021SubjectImpl>
    implements _$$StatusList2021SubjectImplCopyWith<$Res> {
  __$$StatusList2021SubjectImplCopyWithImpl(_$StatusList2021SubjectImpl _value,
      $Res Function(_$StatusList2021SubjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusList2021Subject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? statusPurpose = null,
    Object? encoding = null,
    Object? encodedList = null,
  }) {
    return _then(_$StatusList2021SubjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      statusPurpose: null == statusPurpose
          ? _value.statusPurpose
          : statusPurpose // ignore: cast_nullable_to_non_nullable
              as StatusPurpose,
      encoding: null == encoding
          ? _value.encoding
          : encoding // ignore: cast_nullable_to_non_nullable
              as String,
      encodedList: null == encodedList
          ? _value.encodedList
          : encodedList // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusList2021SubjectImpl implements _StatusList2021Subject {
  const _$StatusList2021SubjectImpl(
      {required this.id,
      required this.type,
      required this.statusPurpose,
      this.encoding = 'base64url',
      required this.encodedList});

  factory _$StatusList2021SubjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusList2021SubjectImplFromJson(json);

  /// An identifier for the subject, often the same as the credential ID or related.
  @override
  final String id;

  /// The type of the credential subject. Must be "StatusList2021".
  @override
  final String type;

  /// Specifies the purpose of the status entries (e.g., revocation, suspension).
  /// See [StatusPurpose].
  @override
  final StatusPurpose statusPurpose;

  /// The encoding format used for the `encodedList`. Defaults to "base64url".
  /// Other potential values might include "base64", although "base64url" is common.
  @override
  @JsonKey()
  final String encoding;

  /// The core status list, represented as a compressed bitstring, encoded according
  /// to the specified `encoding` (typically base64url).
  /// Each bit in the decoded list corresponds to a specific `statusListIndex` from a
  /// [StatusList2021Entry]. A '1' usually indicates the status applies (e.g., revoked),
  /// while a '0' indicates it does not.
  @override
  final String encodedList;

  @override
  String toString() {
    return 'StatusList2021Subject(id: $id, type: $type, statusPurpose: $statusPurpose, encoding: $encoding, encodedList: $encodedList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusList2021SubjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.statusPurpose, statusPurpose) ||
                other.statusPurpose == statusPurpose) &&
            (identical(other.encoding, encoding) ||
                other.encoding == encoding) &&
            (identical(other.encodedList, encodedList) ||
                other.encodedList == encodedList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, statusPurpose, encoding, encodedList);

  /// Create a copy of StatusList2021Subject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusList2021SubjectImplCopyWith<_$StatusList2021SubjectImpl>
      get copyWith => __$$StatusList2021SubjectImplCopyWithImpl<
          _$StatusList2021SubjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusList2021SubjectImplToJson(
      this,
    );
  }
}

abstract class _StatusList2021Subject implements StatusList2021Subject {
  const factory _StatusList2021Subject(
      {required final String id,
      required final String type,
      required final StatusPurpose statusPurpose,
      final String encoding,
      required final String encodedList}) = _$StatusList2021SubjectImpl;

  factory _StatusList2021Subject.fromJson(Map<String, dynamic> json) =
      _$StatusList2021SubjectImpl.fromJson;

  /// An identifier for the subject, often the same as the credential ID or related.
  @override
  String get id;

  /// The type of the credential subject. Must be "StatusList2021".
  @override
  String get type;

  /// Specifies the purpose of the status entries (e.g., revocation, suspension).
  /// See [StatusPurpose].
  @override
  StatusPurpose get statusPurpose;

  /// The encoding format used for the `encodedList`. Defaults to "base64url".
  /// Other potential values might include "base64", although "base64url" is common.
  @override
  String get encoding;

  /// The core status list, represented as a compressed bitstring, encoded according
  /// to the specified `encoding` (typically base64url).
  /// Each bit in the decoded list corresponds to a specific `statusListIndex` from a
  /// [StatusList2021Entry]. A '1' usually indicates the status applies (e.g., revoked),
  /// while a '0' indicates it does not.
  @override
  String get encodedList;

  /// Create a copy of StatusList2021Subject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusList2021SubjectImplCopyWith<_$StatusList2021SubjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StatusList2021Proof _$StatusList2021ProofFromJson(Map<String, dynamic> json) {
  return _StatusList2021Proof.fromJson(json);
}

/// @nodoc
mixin _$StatusList2021Proof {
  /// The type of the cryptographic suite used for the proof (e.g., "Ed25519Signature2020").
  String get type => throw _privateConstructorUsedError;

  /// The timestamp when the proof was generated.
  DateTime get created => throw _privateConstructorUsedError;

  /// The DID URL identifying the verification method (e.g., public key) used to create the proof.
  /// This is used by verifiers to check the signature.
  String get verificationMethod => throw _privateConstructorUsedError;

  /// The purpose for which the proof was created (e.g., "assertionMethod").
  String get proofPurpose => throw _privateConstructorUsedError;

  /// The digital signature or proof value itself, typically encoded in base64url or multibase.
  String get proofValue => throw _privateConstructorUsedError;

  /// Serializes this StatusList2021Proof to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusList2021Proof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusList2021ProofCopyWith<StatusList2021Proof> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusList2021ProofCopyWith<$Res> {
  factory $StatusList2021ProofCopyWith(
          StatusList2021Proof value, $Res Function(StatusList2021Proof) then) =
      _$StatusList2021ProofCopyWithImpl<$Res, StatusList2021Proof>;
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String verificationMethod,
      String proofPurpose,
      String proofValue});
}

/// @nodoc
class _$StatusList2021ProofCopyWithImpl<$Res, $Val extends StatusList2021Proof>
    implements $StatusList2021ProofCopyWith<$Res> {
  _$StatusList2021ProofCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusList2021Proof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? verificationMethod = null,
    Object? proofPurpose = null,
    Object? proofValue = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      proofPurpose: null == proofPurpose
          ? _value.proofPurpose
          : proofPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      proofValue: null == proofValue
          ? _value.proofValue
          : proofValue // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusList2021ProofImplCopyWith<$Res>
    implements $StatusList2021ProofCopyWith<$Res> {
  factory _$$StatusList2021ProofImplCopyWith(_$StatusList2021ProofImpl value,
          $Res Function(_$StatusList2021ProofImpl) then) =
      __$$StatusList2021ProofImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String verificationMethod,
      String proofPurpose,
      String proofValue});
}

/// @nodoc
class __$$StatusList2021ProofImplCopyWithImpl<$Res>
    extends _$StatusList2021ProofCopyWithImpl<$Res, _$StatusList2021ProofImpl>
    implements _$$StatusList2021ProofImplCopyWith<$Res> {
  __$$StatusList2021ProofImplCopyWithImpl(_$StatusList2021ProofImpl _value,
      $Res Function(_$StatusList2021ProofImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusList2021Proof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? verificationMethod = null,
    Object? proofPurpose = null,
    Object? proofValue = null,
  }) {
    return _then(_$StatusList2021ProofImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      proofPurpose: null == proofPurpose
          ? _value.proofPurpose
          : proofPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      proofValue: null == proofValue
          ? _value.proofValue
          : proofValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusList2021ProofImpl implements _StatusList2021Proof {
  const _$StatusList2021ProofImpl(
      {required this.type,
      required this.created,
      required this.verificationMethod,
      required this.proofPurpose,
      required this.proofValue});

  factory _$StatusList2021ProofImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusList2021ProofImplFromJson(json);

  /// The type of the cryptographic suite used for the proof (e.g., "Ed25519Signature2020").
  @override
  final String type;

  /// The timestamp when the proof was generated.
  @override
  final DateTime created;

  /// The DID URL identifying the verification method (e.g., public key) used to create the proof.
  /// This is used by verifiers to check the signature.
  @override
  final String verificationMethod;

  /// The purpose for which the proof was created (e.g., "assertionMethod").
  @override
  final String proofPurpose;

  /// The digital signature or proof value itself, typically encoded in base64url or multibase.
  @override
  final String proofValue;

  @override
  String toString() {
    return 'StatusList2021Proof(type: $type, created: $created, verificationMethod: $verificationMethod, proofPurpose: $proofPurpose, proofValue: $proofValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusList2021ProofImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod) &&
            (identical(other.proofPurpose, proofPurpose) ||
                other.proofPurpose == proofPurpose) &&
            (identical(other.proofValue, proofValue) ||
                other.proofValue == proofValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, created, verificationMethod, proofPurpose, proofValue);

  /// Create a copy of StatusList2021Proof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusList2021ProofImplCopyWith<_$StatusList2021ProofImpl> get copyWith =>
      __$$StatusList2021ProofImplCopyWithImpl<_$StatusList2021ProofImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusList2021ProofImplToJson(
      this,
    );
  }
}

abstract class _StatusList2021Proof implements StatusList2021Proof {
  const factory _StatusList2021Proof(
      {required final String type,
      required final DateTime created,
      required final String verificationMethod,
      required final String proofPurpose,
      required final String proofValue}) = _$StatusList2021ProofImpl;

  factory _StatusList2021Proof.fromJson(Map<String, dynamic> json) =
      _$StatusList2021ProofImpl.fromJson;

  /// The type of the cryptographic suite used for the proof (e.g., "Ed25519Signature2020").
  @override
  String get type;

  /// The timestamp when the proof was generated.
  @override
  DateTime get created;

  /// The DID URL identifying the verification method (e.g., public key) used to create the proof.
  /// This is used by verifiers to check the signature.
  @override
  String get verificationMethod;

  /// The purpose for which the proof was created (e.g., "assertionMethod").
  @override
  String get proofPurpose;

  /// The digital signature or proof value itself, typically encoded in base64url or multibase.
  @override
  String get proofValue;

  /// Create a copy of StatusList2021Proof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusList2021ProofImplCopyWith<_$StatusList2021ProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusList2021Entry _$StatusList2021EntryFromJson(Map<String, dynamic> json) {
  return _StatusList2021Entry.fromJson(json);
}

/// @nodoc
mixin _$StatusList2021Entry {
  /// The identifier for this status entry, typically the VC ID + '#status-<index>'.
  String get id => throw _privateConstructorUsedError;

  /// The type of this status entry. Must be "StatusList2021".
  /// (Note: The spec defines this as "StatusList2021", not "StatusList2021Entry").
  String get type => throw _privateConstructorUsedError;

  /// The purpose of the status check (e.g., "revocation"). Should match the
  /// `statusPurpose` of the referenced [StatusList2021Credential].
  /// See [StatusPurpose].
  StatusPurpose get statusPurpose => throw _privateConstructorUsedError;

  /// The URL (typically the `id`) of the [StatusList2021Credential] containing the relevant status list.
  String get statusListCredential => throw _privateConstructorUsedError;

  /// The zero-based index of the bit within the `encodedList` (after decoding)
  /// that represents the status of the credential containing this entry.
  int get statusListIndex => throw _privateConstructorUsedError;

  /// Serializes this StatusList2021Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusList2021Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusList2021EntryCopyWith<StatusList2021Entry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusList2021EntryCopyWith<$Res> {
  factory $StatusList2021EntryCopyWith(
          StatusList2021Entry value, $Res Function(StatusList2021Entry) then) =
      _$StatusList2021EntryCopyWithImpl<$Res, StatusList2021Entry>;
  @useResult
  $Res call(
      {String id,
      String type,
      StatusPurpose statusPurpose,
      String statusListCredential,
      int statusListIndex});
}

/// @nodoc
class _$StatusList2021EntryCopyWithImpl<$Res, $Val extends StatusList2021Entry>
    implements $StatusList2021EntryCopyWith<$Res> {
  _$StatusList2021EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusList2021Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? statusPurpose = null,
    Object? statusListCredential = null,
    Object? statusListIndex = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      statusPurpose: null == statusPurpose
          ? _value.statusPurpose
          : statusPurpose // ignore: cast_nullable_to_non_nullable
              as StatusPurpose,
      statusListCredential: null == statusListCredential
          ? _value.statusListCredential
          : statusListCredential // ignore: cast_nullable_to_non_nullable
              as String,
      statusListIndex: null == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusList2021EntryImplCopyWith<$Res>
    implements $StatusList2021EntryCopyWith<$Res> {
  factory _$$StatusList2021EntryImplCopyWith(_$StatusList2021EntryImpl value,
          $Res Function(_$StatusList2021EntryImpl) then) =
      __$$StatusList2021EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      StatusPurpose statusPurpose,
      String statusListCredential,
      int statusListIndex});
}

/// @nodoc
class __$$StatusList2021EntryImplCopyWithImpl<$Res>
    extends _$StatusList2021EntryCopyWithImpl<$Res, _$StatusList2021EntryImpl>
    implements _$$StatusList2021EntryImplCopyWith<$Res> {
  __$$StatusList2021EntryImplCopyWithImpl(_$StatusList2021EntryImpl _value,
      $Res Function(_$StatusList2021EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusList2021Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? statusPurpose = null,
    Object? statusListCredential = null,
    Object? statusListIndex = null,
  }) {
    return _then(_$StatusList2021EntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      statusPurpose: null == statusPurpose
          ? _value.statusPurpose
          : statusPurpose // ignore: cast_nullable_to_non_nullable
              as StatusPurpose,
      statusListCredential: null == statusListCredential
          ? _value.statusListCredential
          : statusListCredential // ignore: cast_nullable_to_non_nullable
              as String,
      statusListIndex: null == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusList2021EntryImpl implements _StatusList2021Entry {
  const _$StatusList2021EntryImpl(
      {required this.id,
      this.type = 'StatusList2021',
      required this.statusPurpose,
      required this.statusListCredential,
      required this.statusListIndex});

  factory _$StatusList2021EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusList2021EntryImplFromJson(json);

  /// The identifier for this status entry, typically the VC ID + '#status-<index>'.
  @override
  final String id;

  /// The type of this status entry. Must be "StatusList2021".
  /// (Note: The spec defines this as "StatusList2021", not "StatusList2021Entry").
  @override
  @JsonKey()
  final String type;

  /// The purpose of the status check (e.g., "revocation"). Should match the
  /// `statusPurpose` of the referenced [StatusList2021Credential].
  /// See [StatusPurpose].
  @override
  final StatusPurpose statusPurpose;

  /// The URL (typically the `id`) of the [StatusList2021Credential] containing the relevant status list.
  @override
  final String statusListCredential;

  /// The zero-based index of the bit within the `encodedList` (after decoding)
  /// that represents the status of the credential containing this entry.
  @override
  final int statusListIndex;

  @override
  String toString() {
    return 'StatusList2021Entry(id: $id, type: $type, statusPurpose: $statusPurpose, statusListCredential: $statusListCredential, statusListIndex: $statusListIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusList2021EntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.statusPurpose, statusPurpose) ||
                other.statusPurpose == statusPurpose) &&
            (identical(other.statusListCredential, statusListCredential) ||
                other.statusListCredential == statusListCredential) &&
            (identical(other.statusListIndex, statusListIndex) ||
                other.statusListIndex == statusListIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, statusPurpose,
      statusListCredential, statusListIndex);

  /// Create a copy of StatusList2021Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusList2021EntryImplCopyWith<_$StatusList2021EntryImpl> get copyWith =>
      __$$StatusList2021EntryImplCopyWithImpl<_$StatusList2021EntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusList2021EntryImplToJson(
      this,
    );
  }
}

abstract class _StatusList2021Entry implements StatusList2021Entry {
  const factory _StatusList2021Entry(
      {required final String id,
      final String type,
      required final StatusPurpose statusPurpose,
      required final String statusListCredential,
      required final int statusListIndex}) = _$StatusList2021EntryImpl;

  factory _StatusList2021Entry.fromJson(Map<String, dynamic> json) =
      _$StatusList2021EntryImpl.fromJson;

  /// The identifier for this status entry, typically the VC ID + '#status-<index>'.
  @override
  String get id;

  /// The type of this status entry. Must be "StatusList2021".
  /// (Note: The spec defines this as "StatusList2021", not "StatusList2021Entry").
  @override
  String get type;

  /// The purpose of the status check (e.g., "revocation"). Should match the
  /// `statusPurpose` of the referenced [StatusList2021Credential].
  /// See [StatusPurpose].
  @override
  StatusPurpose get statusPurpose;

  /// The URL (typically the `id`) of the [StatusList2021Credential] containing the relevant status list.
  @override
  String get statusListCredential;

  /// The zero-based index of the bit within the `encodedList` (after decoding)
  /// that represents the status of the credential containing this entry.
  @override
  int get statusListIndex;

  /// Create a copy of StatusList2021Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusList2021EntryImplCopyWith<_$StatusList2021EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
