// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Credential _$CredentialFromJson(Map<String, dynamic> json) {
  return _Credential.fromJson(json);
}

/// @nodoc
mixin _$Credential {
  /// A unique identifier for the credential (URI). REQUIRED by W3C standard.
  /// Corresponds to the `id` property in the W3C VC Data Model.
  String get id => throw _privateConstructorUsedError;

  /// One or more URIs identifying the type(s) of the credential. REQUIRED.
  /// The first type MUST be `VerifiableCredential`. Additional types define the specific credential schema.
  /// Corresponds to the `type` property in the W3C VC Data Model.
  List<String> get type => throw _privateConstructorUsedError;

  /// The Decentralized Identifier (DID) URI or other identifier of the issuer. REQUIRED.
  /// Corresponds to the `issuer` property in the W3C VC Data Model. Can be a URI or an object containing an `id`.
  String get issuer =>
      throw _privateConstructorUsedError; // W3C allows string or object { id: string, ... }
  /// A human-readable name for the credential. OPTIONAL.
  /// Not part of the core W3C VC model, but useful for display.
  String? get name => throw _privateConstructorUsedError;

  /// A human-readable description of the credential. OPTIONAL.
  /// Not part of the core W3C VC model, but useful for display.
  String? get description => throw _privateConstructorUsedError;

  /// The identifier (e.g., DID URI) of the subject/holder of the credential. OPTIONAL.
  /// If not present, the credential subject is typically identified indirectly or is the holder.
  /// Corresponds to the `credentialSubject.id` property if the subject is represented by a URI.
  String? get subject =>
      throw _privateConstructorUsedError; // Often inferred or part of credentialSubject
  /// The date and time when the credential was issued. REQUIRED.
  /// Must be an XMLSchema dateTime value (e.g., '2023-10-26T10:00:00Z').
  /// Corresponds to the `issuanceDate` property in the W3C VC Data Model.
  DateTime get issuanceDate => throw _privateConstructorUsedError;

  /// The date and time when the credential expires. OPTIONAL.
  /// Must be an XMLSchema dateTime value. If absent, the credential does not expire.
  /// Corresponds to the `expirationDate` property in the W3C VC Data Model.
  DateTime? get expirationDate => throw _privateConstructorUsedError;

  /// **DEPRECATED:** Use the `status` field instead.
  /// URL pointing to the Status List 2021 credential used for revocation checks.
  /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
  /// See: https://w3c-ccg.github.io/vc-status-list-2021/
  @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object')
  String? get statusListUrl => throw _privateConstructorUsedError;

  /// **DEPRECATED:** Use the `status` field instead.
  /// Index within the Status List 2021 bitstring.
  /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
  @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object')
  int? get statusListIndex => throw _privateConstructorUsedError;

  /// The current verification status of the credential (a local assessment). OPTIONAL.
  /// This is application-specific and not part of the core W3C VC model's properties.
  VerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;

  /// Information about the schema used for the credential's subject data. OPTIONAL.
  /// Helps interpret the `credentialSubject` data structure.
  /// Corresponds to the `credentialSchema` property in the W3C VC Data Model (can be object or array).
  /// Use [CredentialSchema] for a typed representation.
  Map<String, dynamic>? get credentialSchema =>
      throw _privateConstructorUsedError; // W3C allows object or array { id: string, type: string, ... }
  /// Information used to determine the current status of the credential (e.g., revocation). OPTIONAL.
  /// Corresponds to the `credentialStatus` property in the W3C VC Data Model.
  /// Must contain `id` and `type`. Example type: `StatusList2021Entry`.
  /// Use [CredentialStatus] or specific implementations like [StatusList2021Entry].
  /// See: https://www.w3.org/TR/vc-data-model-2.0/#status
  Map<String, dynamic>? get status =>
      throw _privateConstructorUsedError; // W3C requires { id: string, type: string, ... }
  /// Indicates if the credential supports Zero-Knowledge Proofs (ZKPs). OPTIONAL.
  /// This is a non-standard property, specific to the application's ZKP implementation.
  bool get supportsZkp => throw _privateConstructorUsedError;

  /// The claims (properties) about the subject. REQUIRED.
  /// This is the core data payload of the credential. Its structure is defined by the credential `type` and `credentialSchema`.
  /// Corresponds to the `credentialSubject` property in the W3C VC Data Model.
  /// Can be a map or a list of maps. Must contain at least an `id` if representing a specific entity.
  Map<String, dynamic> get credentialSubject =>
      throw _privateConstructorUsedError; // W3C allows object or array
  /// The JSON-LD context(s) used in the credential. REQUIRED.
  /// Defines the vocabulary used in the credential. The first item MUST be `https://www.w3.org/ns/credentials/v2`.
  /// Corresponds to the `@context` property in the W3C VC Data Model.
  @JsonKey(name: '@context')
  List<String> get context =>
      throw _privateConstructorUsedError; // Reverted to List<String> for compatibility
  /// One or more cryptographic proofs verifying the credential's integrity and issuer. REQUIRED.
  /// Contains information like the proof type, creation date, verification method, and proof value.
  /// Corresponds to the `proof` property in the W3C VC Data Model.
  /// Can be a single proof object or an array of proof objects. Use the [Proof] model.
  Map<String, dynamic> get proof => throw _privateConstructorUsedError;

  /// Serializes this Credential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialCopyWith<Credential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialCopyWith<$Res> {
  factory $CredentialCopyWith(
          Credential value, $Res Function(Credential) then) =
      _$CredentialCopyWithImpl<$Res, Credential>;
  @useResult
  $Res call(
      {String id,
      List<String> type,
      String issuer,
      String? name,
      String? description,
      String? subject,
      DateTime issuanceDate,
      DateTime? expirationDate,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      String? statusListUrl,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      int? statusListIndex,
      VerificationStatus verificationStatus,
      Map<String, dynamic>? credentialSchema,
      Map<String, dynamic>? status,
      bool supportsZkp,
      Map<String, dynamic> credentialSubject,
      @JsonKey(name: '@context') List<String> context,
      Map<String, dynamic> proof});
}

/// @nodoc
class _$CredentialCopyWithImpl<$Res, $Val extends Credential>
    implements $CredentialCopyWith<$Res> {
  _$CredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? issuer = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? subject = freezed,
    Object? issuanceDate = null,
    Object? expirationDate = freezed,
    Object? statusListUrl = freezed,
    Object? statusListIndex = freezed,
    Object? verificationStatus = null,
    Object? credentialSchema = freezed,
    Object? status = freezed,
    Object? supportsZkp = null,
    Object? credentialSubject = null,
    Object? context = null,
    Object? proof = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      statusListUrl: freezed == statusListUrl
          ? _value.statusListUrl
          : statusListUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      statusListIndex: freezed == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      credentialSchema: freezed == credentialSchema
          ? _value.credentialSchema
          : credentialSchema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      supportsZkp: null == supportsZkp
          ? _value.supportsZkp
          : supportsZkp // ignore: cast_nullable_to_non_nullable
              as bool,
      credentialSubject: null == credentialSubject
          ? _value.credentialSubject
          : credentialSubject // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as List<String>,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialImplCopyWith<$Res>
    implements $CredentialCopyWith<$Res> {
  factory _$$CredentialImplCopyWith(
          _$CredentialImpl value, $Res Function(_$CredentialImpl) then) =
      __$$CredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<String> type,
      String issuer,
      String? name,
      String? description,
      String? subject,
      DateTime issuanceDate,
      DateTime? expirationDate,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      String? statusListUrl,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      int? statusListIndex,
      VerificationStatus verificationStatus,
      Map<String, dynamic>? credentialSchema,
      Map<String, dynamic>? status,
      bool supportsZkp,
      Map<String, dynamic> credentialSubject,
      @JsonKey(name: '@context') List<String> context,
      Map<String, dynamic> proof});
}

/// @nodoc
class __$$CredentialImplCopyWithImpl<$Res>
    extends _$CredentialCopyWithImpl<$Res, _$CredentialImpl>
    implements _$$CredentialImplCopyWith<$Res> {
  __$$CredentialImplCopyWithImpl(
      _$CredentialImpl _value, $Res Function(_$CredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? issuer = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? subject = freezed,
    Object? issuanceDate = null,
    Object? expirationDate = freezed,
    Object? statusListUrl = freezed,
    Object? statusListIndex = freezed,
    Object? verificationStatus = null,
    Object? credentialSchema = freezed,
    Object? status = freezed,
    Object? supportsZkp = null,
    Object? credentialSubject = null,
    Object? context = null,
    Object? proof = null,
  }) {
    return _then(_$CredentialImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      issuanceDate: null == issuanceDate
          ? _value.issuanceDate
          : issuanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      statusListUrl: freezed == statusListUrl
          ? _value.statusListUrl
          : statusListUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      statusListIndex: freezed == statusListIndex
          ? _value.statusListIndex
          : statusListIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      credentialSchema: freezed == credentialSchema
          ? _value._credentialSchema
          : credentialSchema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      status: freezed == status
          ? _value._status
          : status // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      supportsZkp: null == supportsZkp
          ? _value.supportsZkp
          : supportsZkp // ignore: cast_nullable_to_non_nullable
              as bool,
      credentialSubject: null == credentialSubject
          ? _value._credentialSubject
          : credentialSubject // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      context: null == context
          ? _value._context
          : context // ignore: cast_nullable_to_non_nullable
              as List<String>,
      proof: null == proof
          ? _value._proof
          : proof // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialImpl extends _Credential with DiagnosticableTreeMixin {
  const _$CredentialImpl(
      {required this.id,
      required final List<String> type,
      required this.issuer,
      this.name,
      this.description,
      this.subject,
      required this.issuanceDate,
      this.expirationDate,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      this.statusListUrl,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      this.statusListIndex,
      this.verificationStatus = VerificationStatus.unverified,
      final Map<String, dynamic>? credentialSchema,
      final Map<String, dynamic>? status,
      this.supportsZkp = false,
      required final Map<String, dynamic> credentialSubject,
      @JsonKey(name: '@context') final List<String> context = const <String>[
        'https://www.w3.org/ns/credentials/v2'
      ],
      required final Map<String, dynamic> proof})
      : _type = type,
        _credentialSchema = credentialSchema,
        _status = status,
        _credentialSubject = credentialSubject,
        _context = context,
        _proof = proof,
        super._();

  factory _$CredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialImplFromJson(json);

  /// A unique identifier for the credential (URI). REQUIRED by W3C standard.
  /// Corresponds to the `id` property in the W3C VC Data Model.
  @override
  final String id;

  /// One or more URIs identifying the type(s) of the credential. REQUIRED.
  /// The first type MUST be `VerifiableCredential`. Additional types define the specific credential schema.
  /// Corresponds to the `type` property in the W3C VC Data Model.
  final List<String> _type;

  /// One or more URIs identifying the type(s) of the credential. REQUIRED.
  /// The first type MUST be `VerifiableCredential`. Additional types define the specific credential schema.
  /// Corresponds to the `type` property in the W3C VC Data Model.
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  /// The Decentralized Identifier (DID) URI or other identifier of the issuer. REQUIRED.
  /// Corresponds to the `issuer` property in the W3C VC Data Model. Can be a URI or an object containing an `id`.
  @override
  final String issuer;
// W3C allows string or object { id: string, ... }
  /// A human-readable name for the credential. OPTIONAL.
  /// Not part of the core W3C VC model, but useful for display.
  @override
  final String? name;

  /// A human-readable description of the credential. OPTIONAL.
  /// Not part of the core W3C VC model, but useful for display.
  @override
  final String? description;

  /// The identifier (e.g., DID URI) of the subject/holder of the credential. OPTIONAL.
  /// If not present, the credential subject is typically identified indirectly or is the holder.
  /// Corresponds to the `credentialSubject.id` property if the subject is represented by a URI.
  @override
  final String? subject;
// Often inferred or part of credentialSubject
  /// The date and time when the credential was issued. REQUIRED.
  /// Must be an XMLSchema dateTime value (e.g., '2023-10-26T10:00:00Z').
  /// Corresponds to the `issuanceDate` property in the W3C VC Data Model.
  @override
  final DateTime issuanceDate;

  /// The date and time when the credential expires. OPTIONAL.
  /// Must be an XMLSchema dateTime value. If absent, the credential does not expire.
  /// Corresponds to the `expirationDate` property in the W3C VC Data Model.
  @override
  final DateTime? expirationDate;

  /// **DEPRECATED:** Use the `status` field instead.
  /// URL pointing to the Status List 2021 credential used for revocation checks.
  /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
  /// See: https://w3c-ccg.github.io/vc-status-list-2021/
  @override
  @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object')
  final String? statusListUrl;

  /// **DEPRECATED:** Use the `status` field instead.
  /// Index within the Status List 2021 bitstring.
  /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
  @override
  @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object')
  final int? statusListIndex;

  /// The current verification status of the credential (a local assessment). OPTIONAL.
  /// This is application-specific and not part of the core W3C VC model's properties.
  @override
  @JsonKey()
  final VerificationStatus verificationStatus;

  /// Information about the schema used for the credential's subject data. OPTIONAL.
  /// Helps interpret the `credentialSubject` data structure.
  /// Corresponds to the `credentialSchema` property in the W3C VC Data Model (can be object or array).
  /// Use [CredentialSchema] for a typed representation.
  final Map<String, dynamic>? _credentialSchema;

  /// Information about the schema used for the credential's subject data. OPTIONAL.
  /// Helps interpret the `credentialSubject` data structure.
  /// Corresponds to the `credentialSchema` property in the W3C VC Data Model (can be object or array).
  /// Use [CredentialSchema] for a typed representation.
  @override
  Map<String, dynamic>? get credentialSchema {
    final value = _credentialSchema;
    if (value == null) return null;
    if (_credentialSchema is EqualUnmodifiableMapView) return _credentialSchema;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// W3C allows object or array { id: string, type: string, ... }
  /// Information used to determine the current status of the credential (e.g., revocation). OPTIONAL.
  /// Corresponds to the `credentialStatus` property in the W3C VC Data Model.
  /// Must contain `id` and `type`. Example type: `StatusList2021Entry`.
  /// Use [CredentialStatus] or specific implementations like [StatusList2021Entry].
  /// See: https://www.w3.org/TR/vc-data-model-2.0/#status
  final Map<String, dynamic>? _status;
// W3C allows object or array { id: string, type: string, ... }
  /// Information used to determine the current status of the credential (e.g., revocation). OPTIONAL.
  /// Corresponds to the `credentialStatus` property in the W3C VC Data Model.
  /// Must contain `id` and `type`. Example type: `StatusList2021Entry`.
  /// Use [CredentialStatus] or specific implementations like [StatusList2021Entry].
  /// See: https://www.w3.org/TR/vc-data-model-2.0/#status
  @override
  Map<String, dynamic>? get status {
    final value = _status;
    if (value == null) return null;
    if (_status is EqualUnmodifiableMapView) return _status;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// W3C requires { id: string, type: string, ... }
  /// Indicates if the credential supports Zero-Knowledge Proofs (ZKPs). OPTIONAL.
  /// This is a non-standard property, specific to the application's ZKP implementation.
  @override
  @JsonKey()
  final bool supportsZkp;

  /// The claims (properties) about the subject. REQUIRED.
  /// This is the core data payload of the credential. Its structure is defined by the credential `type` and `credentialSchema`.
  /// Corresponds to the `credentialSubject` property in the W3C VC Data Model.
  /// Can be a map or a list of maps. Must contain at least an `id` if representing a specific entity.
  final Map<String, dynamic> _credentialSubject;

  /// The claims (properties) about the subject. REQUIRED.
  /// This is the core data payload of the credential. Its structure is defined by the credential `type` and `credentialSchema`.
  /// Corresponds to the `credentialSubject` property in the W3C VC Data Model.
  /// Can be a map or a list of maps. Must contain at least an `id` if representing a specific entity.
  @override
  Map<String, dynamic> get credentialSubject {
    if (_credentialSubject is EqualUnmodifiableMapView)
      return _credentialSubject;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_credentialSubject);
  }

// W3C allows object or array
  /// The JSON-LD context(s) used in the credential. REQUIRED.
  /// Defines the vocabulary used in the credential. The first item MUST be `https://www.w3.org/ns/credentials/v2`.
  /// Corresponds to the `@context` property in the W3C VC Data Model.
  final List<String> _context;
// W3C allows object or array
  /// The JSON-LD context(s) used in the credential. REQUIRED.
  /// Defines the vocabulary used in the credential. The first item MUST be `https://www.w3.org/ns/credentials/v2`.
  /// Corresponds to the `@context` property in the W3C VC Data Model.
  @override
  @JsonKey(name: '@context')
  List<String> get context {
    if (_context is EqualUnmodifiableListView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_context);
  }

// Reverted to List<String> for compatibility
  /// One or more cryptographic proofs verifying the credential's integrity and issuer. REQUIRED.
  /// Contains information like the proof type, creation date, verification method, and proof value.
  /// Corresponds to the `proof` property in the W3C VC Data Model.
  /// Can be a single proof object or an array of proof objects. Use the [Proof] model.
  final Map<String, dynamic> _proof;
// Reverted to List<String> for compatibility
  /// One or more cryptographic proofs verifying the credential's integrity and issuer. REQUIRED.
  /// Contains information like the proof type, creation date, verification method, and proof value.
  /// Corresponds to the `proof` property in the W3C VC Data Model.
  /// Can be a single proof object or an array of proof objects. Use the [Proof] model.
  @override
  Map<String, dynamic> get proof {
    if (_proof is EqualUnmodifiableMapView) return _proof;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_proof);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Credential(id: $id, type: $type, issuer: $issuer, name: $name, description: $description, subject: $subject, issuanceDate: $issuanceDate, expirationDate: $expirationDate, statusListUrl: $statusListUrl, statusListIndex: $statusListIndex, verificationStatus: $verificationStatus, credentialSchema: $credentialSchema, status: $status, supportsZkp: $supportsZkp, credentialSubject: $credentialSubject, context: $context, proof: $proof)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Credential'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('issuer', issuer))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('subject', subject))
      ..add(DiagnosticsProperty('issuanceDate', issuanceDate))
      ..add(DiagnosticsProperty('expirationDate', expirationDate))
      ..add(DiagnosticsProperty('statusListUrl', statusListUrl))
      ..add(DiagnosticsProperty('statusListIndex', statusListIndex))
      ..add(DiagnosticsProperty('verificationStatus', verificationStatus))
      ..add(DiagnosticsProperty('credentialSchema', credentialSchema))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('supportsZkp', supportsZkp))
      ..add(DiagnosticsProperty('credentialSubject', credentialSubject))
      ..add(DiagnosticsProperty('context', context))
      ..add(DiagnosticsProperty('proof', proof));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.issuanceDate, issuanceDate) ||
                other.issuanceDate == issuanceDate) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.statusListUrl, statusListUrl) ||
                other.statusListUrl == statusListUrl) &&
            (identical(other.statusListIndex, statusListIndex) ||
                other.statusListIndex == statusListIndex) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus) &&
            const DeepCollectionEquality()
                .equals(other._credentialSchema, _credentialSchema) &&
            const DeepCollectionEquality().equals(other._status, _status) &&
            (identical(other.supportsZkp, supportsZkp) ||
                other.supportsZkp == supportsZkp) &&
            const DeepCollectionEquality()
                .equals(other._credentialSubject, _credentialSubject) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            const DeepCollectionEquality().equals(other._proof, _proof));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_type),
      issuer,
      name,
      description,
      subject,
      issuanceDate,
      expirationDate,
      statusListUrl,
      statusListIndex,
      verificationStatus,
      const DeepCollectionEquality().hash(_credentialSchema),
      const DeepCollectionEquality().hash(_status),
      supportsZkp,
      const DeepCollectionEquality().hash(_credentialSubject),
      const DeepCollectionEquality().hash(_context),
      const DeepCollectionEquality().hash(_proof));

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialImplCopyWith<_$CredentialImpl> get copyWith =>
      __$$CredentialImplCopyWithImpl<_$CredentialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialImplToJson(
      this,
    );
  }
}

abstract class _Credential extends Credential {
  const factory _Credential(
      {required final String id,
      required final List<String> type,
      required final String issuer,
      final String? name,
      final String? description,
      final String? subject,
      required final DateTime issuanceDate,
      final DateTime? expirationDate,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      final String? statusListUrl,
      @Deprecated(
          'Use status field instead which contains the full StatusList2021Entry object')
      final int? statusListIndex,
      final VerificationStatus verificationStatus,
      final Map<String, dynamic>? credentialSchema,
      final Map<String, dynamic>? status,
      final bool supportsZkp,
      required final Map<String, dynamic> credentialSubject,
      @JsonKey(name: '@context') final List<String> context,
      required final Map<String, dynamic> proof}) = _$CredentialImpl;
  const _Credential._() : super._();

  factory _Credential.fromJson(Map<String, dynamic> json) =
      _$CredentialImpl.fromJson;

  /// A unique identifier for the credential (URI). REQUIRED by W3C standard.
  /// Corresponds to the `id` property in the W3C VC Data Model.
  @override
  String get id;

  /// One or more URIs identifying the type(s) of the credential. REQUIRED.
  /// The first type MUST be `VerifiableCredential`. Additional types define the specific credential schema.
  /// Corresponds to the `type` property in the W3C VC Data Model.
  @override
  List<String> get type;

  /// The Decentralized Identifier (DID) URI or other identifier of the issuer. REQUIRED.
  /// Corresponds to the `issuer` property in the W3C VC Data Model. Can be a URI or an object containing an `id`.
  @override
  String get issuer; // W3C allows string or object { id: string, ... }
  /// A human-readable name for the credential. OPTIONAL.
  /// Not part of the core W3C VC model, but useful for display.
  @override
  String? get name;

  /// A human-readable description of the credential. OPTIONAL.
  /// Not part of the core W3C VC model, but useful for display.
  @override
  String? get description;

  /// The identifier (e.g., DID URI) of the subject/holder of the credential. OPTIONAL.
  /// If not present, the credential subject is typically identified indirectly or is the holder.
  /// Corresponds to the `credentialSubject.id` property if the subject is represented by a URI.
  @override
  String? get subject; // Often inferred or part of credentialSubject
  /// The date and time when the credential was issued. REQUIRED.
  /// Must be an XMLSchema dateTime value (e.g., '2023-10-26T10:00:00Z').
  /// Corresponds to the `issuanceDate` property in the W3C VC Data Model.
  @override
  DateTime get issuanceDate;

  /// The date and time when the credential expires. OPTIONAL.
  /// Must be an XMLSchema dateTime value. If absent, the credential does not expire.
  /// Corresponds to the `expirationDate` property in the W3C VC Data Model.
  @override
  DateTime? get expirationDate;

  /// **DEPRECATED:** Use the `status` field instead.
  /// URL pointing to the Status List 2021 credential used for revocation checks.
  /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
  /// See: https://w3c-ccg.github.io/vc-status-list-2021/
  @override
  @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object')
  String? get statusListUrl;

  /// **DEPRECATED:** Use the `status` field instead.
  /// Index within the Status List 2021 bitstring.
  /// Part of the `credentialStatus` mechanism (StatusList2021Entry type).
  @override
  @Deprecated(
      'Use status field instead which contains the full StatusList2021Entry object')
  int? get statusListIndex;

  /// The current verification status of the credential (a local assessment). OPTIONAL.
  /// This is application-specific and not part of the core W3C VC model's properties.
  @override
  VerificationStatus get verificationStatus;

  /// Information about the schema used for the credential's subject data. OPTIONAL.
  /// Helps interpret the `credentialSubject` data structure.
  /// Corresponds to the `credentialSchema` property in the W3C VC Data Model (can be object or array).
  /// Use [CredentialSchema] for a typed representation.
  @override
  Map<String, dynamic>?
      get credentialSchema; // W3C allows object or array { id: string, type: string, ... }
  /// Information used to determine the current status of the credential (e.g., revocation). OPTIONAL.
  /// Corresponds to the `credentialStatus` property in the W3C VC Data Model.
  /// Must contain `id` and `type`. Example type: `StatusList2021Entry`.
  /// Use [CredentialStatus] or specific implementations like [StatusList2021Entry].
  /// See: https://www.w3.org/TR/vc-data-model-2.0/#status
  @override
  Map<String, dynamic>?
      get status; // W3C requires { id: string, type: string, ... }
  /// Indicates if the credential supports Zero-Knowledge Proofs (ZKPs). OPTIONAL.
  /// This is a non-standard property, specific to the application's ZKP implementation.
  @override
  bool get supportsZkp;

  /// The claims (properties) about the subject. REQUIRED.
  /// This is the core data payload of the credential. Its structure is defined by the credential `type` and `credentialSchema`.
  /// Corresponds to the `credentialSubject` property in the W3C VC Data Model.
  /// Can be a map or a list of maps. Must contain at least an `id` if representing a specific entity.
  @override
  Map<String, dynamic> get credentialSubject; // W3C allows object or array
  /// The JSON-LD context(s) used in the credential. REQUIRED.
  /// Defines the vocabulary used in the credential. The first item MUST be `https://www.w3.org/ns/credentials/v2`.
  /// Corresponds to the `@context` property in the W3C VC Data Model.
  @override
  @JsonKey(name: '@context')
  List<String> get context; // Reverted to List<String> for compatibility
  /// One or more cryptographic proofs verifying the credential's integrity and issuer. REQUIRED.
  /// Contains information like the proof type, creation date, verification method, and proof value.
  /// Corresponds to the `proof` property in the W3C VC Data Model.
  /// Can be a single proof object or an array of proof objects. Use the [Proof] model.
  @override
  Map<String, dynamic> get proof;

  /// Create a copy of Credential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialImplCopyWith<_$CredentialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CredentialPresentation _$CredentialPresentationFromJson(
    Map<String, dynamic> json) {
  return _CredentialPresentation.fromJson(json);
}

/// @nodoc
mixin _$CredentialPresentation {
  /// A unique identifier for the presentation (URI). OPTIONAL in the W3C standard.
  /// Note: Kept required here for compatibility with generated code.
  String get id => throw _privateConstructorUsedError;

  /// One or more URIs identifying the type(s) of the presentation. REQUIRED.
  /// The first type MUST be `VerifiablePresentation`.
  /// Corresponds to the `type` property in the W3C VP Data Model.
  List<String> get type => throw _privateConstructorUsedError;

  /// The list of Verifiable Credentials being presented. REQUIRED, but can be empty.
  /// These can be embedded VCs or references (URIs) to VCs.
  /// Corresponds to the `verifiableCredential` property in the W3C VP Data Model.
  List<Credential> get verifiableCredentials =>
      throw _privateConstructorUsedError; // W3C allows VCs or URIs
// /// The entity that created and signed the presentation, typically the holder of the VCs. REQUIRED by W3C.
// /// Usually a DID URI.
// /// Corresponds to the `holder` property in the W3C VP Data Model.
// required String holder, // Temporarily commented out for compatibility
  /// A cryptographic challenge provided by the verifier to prevent replay attacks. OPTIONAL.
  /// Included in the `proof` options when generating the VP proof.
  /// Corresponds to the `challenge` property within the `proof` options in W3C VP.
  String? get challenge =>
      throw _privateConstructorUsedError; // Part of proof options
  /// The intended domain (audience) for the presentation. OPTIONAL.
  /// Included in the `proof` options when generating the VP proof.
  /// Corresponds to the `domain` property within the `proof` options in W3C VP.
  String? get domain =>
      throw _privateConstructorUsedError; // Part of proof options
  /// **NON-STANDARD:** Specifies which attributes are revealed for each credential.
  /// Key: Credential ID, Value: List of revealed attribute names/paths.
  /// Used for selective disclosure implementations. Not part of W3C VP standard.
  /// Note: Kept required here for compatibility with generated code.
  Map<String, List<String>> get revealedAttributes =>
      throw _privateConstructorUsedError; // Application-specific
  /// One or more cryptographic proofs verifying the presentation's integrity and holder. REQUIRED.
  /// Binds the VCs to the holder for this specific transaction (challenge/domain).
  /// Corresponds to the `proof` property in the W3C VP Data Model.
  Map<String, dynamic> get proof =>
      throw _privateConstructorUsedError; // W3C allows object or array
  /// **NON-STANDARD:** The date and time when the presentation was created.
  /// The standard practice is to include the creation timestamp within the `proof` (`created` property).
  /// Note: Kept required here for compatibility with generated code.
  DateTime get created => throw _privateConstructorUsedError;

  /// Serializes this CredentialPresentation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialPresentationCopyWith<CredentialPresentation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialPresentationCopyWith<$Res> {
  factory $CredentialPresentationCopyWith(CredentialPresentation value,
          $Res Function(CredentialPresentation) then) =
      _$CredentialPresentationCopyWithImpl<$Res, CredentialPresentation>;
  @useResult
  $Res call(
      {String id,
      List<String> type,
      List<Credential> verifiableCredentials,
      String? challenge,
      String? domain,
      Map<String, List<String>> revealedAttributes,
      Map<String, dynamic> proof,
      DateTime created});
}

/// @nodoc
class _$CredentialPresentationCopyWithImpl<$Res,
        $Val extends CredentialPresentation>
    implements $CredentialPresentationCopyWith<$Res> {
  _$CredentialPresentationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? verifiableCredentials = null,
    Object? challenge = freezed,
    Object? domain = freezed,
    Object? revealedAttributes = null,
    Object? proof = null,
    Object? created = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verifiableCredentials: null == verifiableCredentials
          ? _value.verifiableCredentials
          : verifiableCredentials // ignore: cast_nullable_to_non_nullable
              as List<Credential>,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String?,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      revealedAttributes: null == revealedAttributes
          ? _value.revealedAttributes
          : revealedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialPresentationImplCopyWith<$Res>
    implements $CredentialPresentationCopyWith<$Res> {
  factory _$$CredentialPresentationImplCopyWith(
          _$CredentialPresentationImpl value,
          $Res Function(_$CredentialPresentationImpl) then) =
      __$$CredentialPresentationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<String> type,
      List<Credential> verifiableCredentials,
      String? challenge,
      String? domain,
      Map<String, List<String>> revealedAttributes,
      Map<String, dynamic> proof,
      DateTime created});
}

/// @nodoc
class __$$CredentialPresentationImplCopyWithImpl<$Res>
    extends _$CredentialPresentationCopyWithImpl<$Res,
        _$CredentialPresentationImpl>
    implements _$$CredentialPresentationImplCopyWith<$Res> {
  __$$CredentialPresentationImplCopyWithImpl(
      _$CredentialPresentationImpl _value,
      $Res Function(_$CredentialPresentationImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? verifiableCredentials = null,
    Object? challenge = freezed,
    Object? domain = freezed,
    Object? revealedAttributes = null,
    Object? proof = null,
    Object? created = null,
  }) {
    return _then(_$CredentialPresentationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verifiableCredentials: null == verifiableCredentials
          ? _value._verifiableCredentials
          : verifiableCredentials // ignore: cast_nullable_to_non_nullable
              as List<Credential>,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String?,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      revealedAttributes: null == revealedAttributes
          ? _value._revealedAttributes
          : revealedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      proof: null == proof
          ? _value._proof
          : proof // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialPresentationImpl
    with DiagnosticableTreeMixin
    implements _CredentialPresentation {
  const _$CredentialPresentationImpl(
      {required this.id,
      required final List<String> type,
      required final List<Credential> verifiableCredentials,
      this.challenge,
      this.domain,
      required final Map<String, List<String>> revealedAttributes,
      required final Map<String, dynamic> proof,
      required this.created})
      : _type = type,
        _verifiableCredentials = verifiableCredentials,
        _revealedAttributes = revealedAttributes,
        _proof = proof;

  factory _$CredentialPresentationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialPresentationImplFromJson(json);

  /// A unique identifier for the presentation (URI). OPTIONAL in the W3C standard.
  /// Note: Kept required here for compatibility with generated code.
  @override
  final String id;

  /// One or more URIs identifying the type(s) of the presentation. REQUIRED.
  /// The first type MUST be `VerifiablePresentation`.
  /// Corresponds to the `type` property in the W3C VP Data Model.
  final List<String> _type;

  /// One or more URIs identifying the type(s) of the presentation. REQUIRED.
  /// The first type MUST be `VerifiablePresentation`.
  /// Corresponds to the `type` property in the W3C VP Data Model.
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  /// The list of Verifiable Credentials being presented. REQUIRED, but can be empty.
  /// These can be embedded VCs or references (URIs) to VCs.
  /// Corresponds to the `verifiableCredential` property in the W3C VP Data Model.
  final List<Credential> _verifiableCredentials;

  /// The list of Verifiable Credentials being presented. REQUIRED, but can be empty.
  /// These can be embedded VCs or references (URIs) to VCs.
  /// Corresponds to the `verifiableCredential` property in the W3C VP Data Model.
  @override
  List<Credential> get verifiableCredentials {
    if (_verifiableCredentials is EqualUnmodifiableListView)
      return _verifiableCredentials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verifiableCredentials);
  }

// W3C allows VCs or URIs
// /// The entity that created and signed the presentation, typically the holder of the VCs. REQUIRED by W3C.
// /// Usually a DID URI.
// /// Corresponds to the `holder` property in the W3C VP Data Model.
// required String holder, // Temporarily commented out for compatibility
  /// A cryptographic challenge provided by the verifier to prevent replay attacks. OPTIONAL.
  /// Included in the `proof` options when generating the VP proof.
  /// Corresponds to the `challenge` property within the `proof` options in W3C VP.
  @override
  final String? challenge;
// Part of proof options
  /// The intended domain (audience) for the presentation. OPTIONAL.
  /// Included in the `proof` options when generating the VP proof.
  /// Corresponds to the `domain` property within the `proof` options in W3C VP.
  @override
  final String? domain;
// Part of proof options
  /// **NON-STANDARD:** Specifies which attributes are revealed for each credential.
  /// Key: Credential ID, Value: List of revealed attribute names/paths.
  /// Used for selective disclosure implementations. Not part of W3C VP standard.
  /// Note: Kept required here for compatibility with generated code.
  final Map<String, List<String>> _revealedAttributes;
// Part of proof options
  /// **NON-STANDARD:** Specifies which attributes are revealed for each credential.
  /// Key: Credential ID, Value: List of revealed attribute names/paths.
  /// Used for selective disclosure implementations. Not part of W3C VP standard.
  /// Note: Kept required here for compatibility with generated code.
  @override
  Map<String, List<String>> get revealedAttributes {
    if (_revealedAttributes is EqualUnmodifiableMapView)
      return _revealedAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_revealedAttributes);
  }

// Application-specific
  /// One or more cryptographic proofs verifying the presentation's integrity and holder. REQUIRED.
  /// Binds the VCs to the holder for this specific transaction (challenge/domain).
  /// Corresponds to the `proof` property in the W3C VP Data Model.
  final Map<String, dynamic> _proof;
// Application-specific
  /// One or more cryptographic proofs verifying the presentation's integrity and holder. REQUIRED.
  /// Binds the VCs to the holder for this specific transaction (challenge/domain).
  /// Corresponds to the `proof` property in the W3C VP Data Model.
  @override
  Map<String, dynamic> get proof {
    if (_proof is EqualUnmodifiableMapView) return _proof;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_proof);
  }

// W3C allows object or array
  /// **NON-STANDARD:** The date and time when the presentation was created.
  /// The standard practice is to include the creation timestamp within the `proof` (`created` property).
  /// Note: Kept required here for compatibility with generated code.
  @override
  final DateTime created;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CredentialPresentation(id: $id, type: $type, verifiableCredentials: $verifiableCredentials, challenge: $challenge, domain: $domain, revealedAttributes: $revealedAttributes, proof: $proof, created: $created)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CredentialPresentation'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('verifiableCredentials', verifiableCredentials))
      ..add(DiagnosticsProperty('challenge', challenge))
      ..add(DiagnosticsProperty('domain', domain))
      ..add(DiagnosticsProperty('revealedAttributes', revealedAttributes))
      ..add(DiagnosticsProperty('proof', proof))
      ..add(DiagnosticsProperty('created', created));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialPresentationImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            const DeepCollectionEquality()
                .equals(other._verifiableCredentials, _verifiableCredentials) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            const DeepCollectionEquality()
                .equals(other._revealedAttributes, _revealedAttributes) &&
            const DeepCollectionEquality().equals(other._proof, _proof) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_type),
      const DeepCollectionEquality().hash(_verifiableCredentials),
      challenge,
      domain,
      const DeepCollectionEquality().hash(_revealedAttributes),
      const DeepCollectionEquality().hash(_proof),
      created);

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialPresentationImplCopyWith<_$CredentialPresentationImpl>
      get copyWith => __$$CredentialPresentationImplCopyWithImpl<
          _$CredentialPresentationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialPresentationImplToJson(
      this,
    );
  }
}

abstract class _CredentialPresentation implements CredentialPresentation {
  const factory _CredentialPresentation(
      {required final String id,
      required final List<String> type,
      required final List<Credential> verifiableCredentials,
      final String? challenge,
      final String? domain,
      required final Map<String, List<String>> revealedAttributes,
      required final Map<String, dynamic> proof,
      required final DateTime created}) = _$CredentialPresentationImpl;

  factory _CredentialPresentation.fromJson(Map<String, dynamic> json) =
      _$CredentialPresentationImpl.fromJson;

  /// A unique identifier for the presentation (URI). OPTIONAL in the W3C standard.
  /// Note: Kept required here for compatibility with generated code.
  @override
  String get id;

  /// One or more URIs identifying the type(s) of the presentation. REQUIRED.
  /// The first type MUST be `VerifiablePresentation`.
  /// Corresponds to the `type` property in the W3C VP Data Model.
  @override
  List<String> get type;

  /// The list of Verifiable Credentials being presented. REQUIRED, but can be empty.
  /// These can be embedded VCs or references (URIs) to VCs.
  /// Corresponds to the `verifiableCredential` property in the W3C VP Data Model.
  @override
  List<Credential> get verifiableCredentials; // W3C allows VCs or URIs
// /// The entity that created and signed the presentation, typically the holder of the VCs. REQUIRED by W3C.
// /// Usually a DID URI.
// /// Corresponds to the `holder` property in the W3C VP Data Model.
// required String holder, // Temporarily commented out for compatibility
  /// A cryptographic challenge provided by the verifier to prevent replay attacks. OPTIONAL.
  /// Included in the `proof` options when generating the VP proof.
  /// Corresponds to the `challenge` property within the `proof` options in W3C VP.
  @override
  String? get challenge; // Part of proof options
  /// The intended domain (audience) for the presentation. OPTIONAL.
  /// Included in the `proof` options when generating the VP proof.
  /// Corresponds to the `domain` property within the `proof` options in W3C VP.
  @override
  String? get domain; // Part of proof options
  /// **NON-STANDARD:** Specifies which attributes are revealed for each credential.
  /// Key: Credential ID, Value: List of revealed attribute names/paths.
  /// Used for selective disclosure implementations. Not part of W3C VP standard.
  /// Note: Kept required here for compatibility with generated code.
  @override
  Map<String, List<String>> get revealedAttributes; // Application-specific
  /// One or more cryptographic proofs verifying the presentation's integrity and holder. REQUIRED.
  /// Binds the VCs to the holder for this specific transaction (challenge/domain).
  /// Corresponds to the `proof` property in the W3C VP Data Model.
  @override
  Map<String, dynamic> get proof; // W3C allows object or array
  /// **NON-STANDARD:** The date and time when the presentation was created.
  /// The standard practice is to include the creation timestamp within the `proof` (`created` property).
  /// Note: Kept required here for compatibility with generated code.
  @override
  DateTime get created;

  /// Create a copy of CredentialPresentation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialPresentationImplCopyWith<_$CredentialPresentationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CredentialPredicate _$CredentialPredicateFromJson(Map<String, dynamic> json) {
  return _CredentialPredicate.fromJson(json);
}

/// @nodoc
mixin _$CredentialPredicate {
  /// The identifier of the credential to which the predicate applies.
  String get credentialId => throw _privateConstructorUsedError;

  /// The specific attribute (claim) within the credential subject to apply the predicate to.
  /// Can use dot notation for nested attributes (e.g., "address.postalCode").
  String get attribute => throw _privateConstructorUsedError;

  /// A human-readable name for the attribute, potentially used for display purposes during proof request generation.
  String get attributeName => throw _privateConstructorUsedError;

  /// The predicate operator (e.g., ">=", "<=", "=="). Defines the comparison logic.
  String get predicate => throw _privateConstructorUsedError;

  /// The type of the predicate, indicating the ZKP scheme or constraint system used (e.g., range proof, set membership).
  PredicateType get predicateType => throw _privateConstructorUsedError;

  /// The value to compare the attribute against using the predicate operator.
  /// The type of this value should match the type of the credential attribute.
  dynamic get value => throw _privateConstructorUsedError;

  /// Serializes this CredentialPredicate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialPredicateCopyWith<CredentialPredicate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialPredicateCopyWith<$Res> {
  factory $CredentialPredicateCopyWith(
          CredentialPredicate value, $Res Function(CredentialPredicate) then) =
      _$CredentialPredicateCopyWithImpl<$Res, CredentialPredicate>;
  @useResult
  $Res call(
      {String credentialId,
      String attribute,
      String attributeName,
      String predicate,
      PredicateType predicateType,
      dynamic value});
}

/// @nodoc
class _$CredentialPredicateCopyWithImpl<$Res, $Val extends CredentialPredicate>
    implements $CredentialPredicateCopyWith<$Res> {
  _$CredentialPredicateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? attribute = null,
    Object? attributeName = null,
    Object? predicate = null,
    Object? predicateType = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as String,
      attributeName: null == attributeName
          ? _value.attributeName
          : attributeName // ignore: cast_nullable_to_non_nullable
              as String,
      predicate: null == predicate
          ? _value.predicate
          : predicate // ignore: cast_nullable_to_non_nullable
              as String,
      predicateType: null == predicateType
          ? _value.predicateType
          : predicateType // ignore: cast_nullable_to_non_nullable
              as PredicateType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialPredicateImplCopyWith<$Res>
    implements $CredentialPredicateCopyWith<$Res> {
  factory _$$CredentialPredicateImplCopyWith(_$CredentialPredicateImpl value,
          $Res Function(_$CredentialPredicateImpl) then) =
      __$$CredentialPredicateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String credentialId,
      String attribute,
      String attributeName,
      String predicate,
      PredicateType predicateType,
      dynamic value});
}

/// @nodoc
class __$$CredentialPredicateImplCopyWithImpl<$Res>
    extends _$CredentialPredicateCopyWithImpl<$Res, _$CredentialPredicateImpl>
    implements _$$CredentialPredicateImplCopyWith<$Res> {
  __$$CredentialPredicateImplCopyWithImpl(_$CredentialPredicateImpl _value,
      $Res Function(_$CredentialPredicateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentialId = null,
    Object? attribute = null,
    Object? attributeName = null,
    Object? predicate = null,
    Object? predicateType = null,
    Object? value = freezed,
  }) {
    return _then(_$CredentialPredicateImpl(
      credentialId: null == credentialId
          ? _value.credentialId
          : credentialId // ignore: cast_nullable_to_non_nullable
              as String,
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as String,
      attributeName: null == attributeName
          ? _value.attributeName
          : attributeName // ignore: cast_nullable_to_non_nullable
              as String,
      predicate: null == predicate
          ? _value.predicate
          : predicate // ignore: cast_nullable_to_non_nullable
              as String,
      predicateType: null == predicateType
          ? _value.predicateType
          : predicateType // ignore: cast_nullable_to_non_nullable
              as PredicateType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialPredicateImpl
    with DiagnosticableTreeMixin
    implements _CredentialPredicate {
  const _$CredentialPredicateImpl(
      {required this.credentialId,
      required this.attribute,
      required this.attributeName,
      required this.predicate,
      required this.predicateType,
      required this.value});

  factory _$CredentialPredicateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialPredicateImplFromJson(json);

  /// The identifier of the credential to which the predicate applies.
  @override
  final String credentialId;

  /// The specific attribute (claim) within the credential subject to apply the predicate to.
  /// Can use dot notation for nested attributes (e.g., "address.postalCode").
  @override
  final String attribute;

  /// A human-readable name for the attribute, potentially used for display purposes during proof request generation.
  @override
  final String attributeName;

  /// The predicate operator (e.g., ">=", "<=", "=="). Defines the comparison logic.
  @override
  final String predicate;

  /// The type of the predicate, indicating the ZKP scheme or constraint system used (e.g., range proof, set membership).
  @override
  final PredicateType predicateType;

  /// The value to compare the attribute against using the predicate operator.
  /// The type of this value should match the type of the credential attribute.
  @override
  final dynamic value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CredentialPredicate(credentialId: $credentialId, attribute: $attribute, attributeName: $attributeName, predicate: $predicate, predicateType: $predicateType, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CredentialPredicate'))
      ..add(DiagnosticsProperty('credentialId', credentialId))
      ..add(DiagnosticsProperty('attribute', attribute))
      ..add(DiagnosticsProperty('attributeName', attributeName))
      ..add(DiagnosticsProperty('predicate', predicate))
      ..add(DiagnosticsProperty('predicateType', predicateType))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialPredicateImpl &&
            (identical(other.credentialId, credentialId) ||
                other.credentialId == credentialId) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.attributeName, attributeName) ||
                other.attributeName == attributeName) &&
            (identical(other.predicate, predicate) ||
                other.predicate == predicate) &&
            (identical(other.predicateType, predicateType) ||
                other.predicateType == predicateType) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      credentialId,
      attribute,
      attributeName,
      predicate,
      predicateType,
      const DeepCollectionEquality().hash(value));

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialPredicateImplCopyWith<_$CredentialPredicateImpl> get copyWith =>
      __$$CredentialPredicateImplCopyWithImpl<_$CredentialPredicateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialPredicateImplToJson(
      this,
    );
  }
}

abstract class _CredentialPredicate implements CredentialPredicate {
  const factory _CredentialPredicate(
      {required final String credentialId,
      required final String attribute,
      required final String attributeName,
      required final String predicate,
      required final PredicateType predicateType,
      required final dynamic value}) = _$CredentialPredicateImpl;

  factory _CredentialPredicate.fromJson(Map<String, dynamic> json) =
      _$CredentialPredicateImpl.fromJson;

  /// The identifier of the credential to which the predicate applies.
  @override
  String get credentialId;

  /// The specific attribute (claim) within the credential subject to apply the predicate to.
  /// Can use dot notation for nested attributes (e.g., "address.postalCode").
  @override
  String get attribute;

  /// A human-readable name for the attribute, potentially used for display purposes during proof request generation.
  @override
  String get attributeName;

  /// The predicate operator (e.g., ">=", "<=", "=="). Defines the comparison logic.
  @override
  String get predicate;

  /// The type of the predicate, indicating the ZKP scheme or constraint system used (e.g., range proof, set membership).
  @override
  PredicateType get predicateType;

  /// The value to compare the attribute against using the predicate operator.
  /// The type of this value should match the type of the credential attribute.
  @override
  dynamic get value;

  /// Create a copy of CredentialPredicate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialPredicateImplCopyWith<_$CredentialPredicateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Proof _$ProofFromJson(Map<String, dynamic> json) {
  return _Proof.fromJson(json);
}

/// @nodoc
mixin _$Proof {
  /// The type of the cryptographic proof suite used (e.g., "DataIntegrityProof", "Ed25519Signature2020"). REQUIRED.
  /// Identifies the algorithms and protocols used to generate and verify the proof.
  /// Corresponds to the `type` property of the proof.
  String get type => throw _privateConstructorUsedError;

  /// The date and time when the proof was created. REQUIRED.
  /// Must be an XMLSchema dateTime value. Used to check against credential validity and potential replay attacks.
  /// Corresponds to the `created` property of the proof.
  DateTime get created => throw _privateConstructorUsedError;

  /// The purpose of the proof, indicating the relationship between the proof and the controller. REQUIRED.
  /// Examples: "assertionMethod" (for VCs, issuer asserts claims), "authentication" (for VPs, holder authenticates).
  /// Corresponds to the `proofPurpose` property of the proof.
  String get proofPurpose => throw _privateConstructorUsedError;

  /// The identifier (e.g., DID URL with fragment) of the verification method used to create the proof. REQUIRED.
  /// This typically points to the public key required to verify the proof.
  /// Corresponds to the `verificationMethod` property of the proof.
  String get verificationMethod => throw _privateConstructorUsedError;

  /// The value of the cryptographic proof itself (e.g., the digital signature). REQUIRED.
  /// The format depends on the proof `type` (e.g., base64url, multibase).
  /// Corresponds to the `proofValue` property of the proof.
  String get proofValue =>
      throw _privateConstructorUsedError; // Often multibase encoded, e.g., starting with 'z'
  /// The intended domain for which the proof is valid (relevant for VPs). OPTIONAL.
  /// Helps prevent replay attacks across different domains (audiences).
  /// Corresponds to the `domain` property of the proof options.
  String? get domain => throw _privateConstructorUsedError;

  /// The cryptographic challenge provided by the verifier (relevant for VPs). OPTIONAL.
  /// Ensures the proof was created in response to a specific request, preventing replay.
  /// Corresponds to the `challenge` property of the proof options.
  String? get challenge => throw _privateConstructorUsedError;

  /// Serializes this Proof to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Proof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProofCopyWith<Proof> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProofCopyWith<$Res> {
  factory $ProofCopyWith(Proof value, $Res Function(Proof) then) =
      _$ProofCopyWithImpl<$Res, Proof>;
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String proofPurpose,
      String verificationMethod,
      String proofValue,
      String? domain,
      String? challenge});
}

/// @nodoc
class _$ProofCopyWithImpl<$Res, $Val extends Proof>
    implements $ProofCopyWith<$Res> {
  _$ProofCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Proof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? proofPurpose = null,
    Object? verificationMethod = null,
    Object? proofValue = null,
    Object? domain = freezed,
    Object? challenge = freezed,
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
      proofPurpose: null == proofPurpose
          ? _value.proofPurpose
          : proofPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      proofValue: null == proofValue
          ? _value.proofValue
          : proofValue // ignore: cast_nullable_to_non_nullable
              as String,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProofImplCopyWith<$Res> implements $ProofCopyWith<$Res> {
  factory _$$ProofImplCopyWith(
          _$ProofImpl value, $Res Function(_$ProofImpl) then) =
      __$$ProofImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      DateTime created,
      String proofPurpose,
      String verificationMethod,
      String proofValue,
      String? domain,
      String? challenge});
}

/// @nodoc
class __$$ProofImplCopyWithImpl<$Res>
    extends _$ProofCopyWithImpl<$Res, _$ProofImpl>
    implements _$$ProofImplCopyWith<$Res> {
  __$$ProofImplCopyWithImpl(
      _$ProofImpl _value, $Res Function(_$ProofImpl) _then)
      : super(_value, _then);

  /// Create a copy of Proof
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? created = null,
    Object? proofPurpose = null,
    Object? verificationMethod = null,
    Object? proofValue = null,
    Object? domain = freezed,
    Object? challenge = freezed,
  }) {
    return _then(_$ProofImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      proofPurpose: null == proofPurpose
          ? _value.proofPurpose
          : proofPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      proofValue: null == proofValue
          ? _value.proofValue
          : proofValue // ignore: cast_nullable_to_non_nullable
              as String,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String?,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProofImpl with DiagnosticableTreeMixin implements _Proof {
  const _$ProofImpl(
      {required this.type,
      required this.created,
      required this.proofPurpose,
      required this.verificationMethod,
      required this.proofValue,
      this.domain,
      this.challenge});

  factory _$ProofImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProofImplFromJson(json);

  /// The type of the cryptographic proof suite used (e.g., "DataIntegrityProof", "Ed25519Signature2020"). REQUIRED.
  /// Identifies the algorithms and protocols used to generate and verify the proof.
  /// Corresponds to the `type` property of the proof.
  @override
  final String type;

  /// The date and time when the proof was created. REQUIRED.
  /// Must be an XMLSchema dateTime value. Used to check against credential validity and potential replay attacks.
  /// Corresponds to the `created` property of the proof.
  @override
  final DateTime created;

  /// The purpose of the proof, indicating the relationship between the proof and the controller. REQUIRED.
  /// Examples: "assertionMethod" (for VCs, issuer asserts claims), "authentication" (for VPs, holder authenticates).
  /// Corresponds to the `proofPurpose` property of the proof.
  @override
  final String proofPurpose;

  /// The identifier (e.g., DID URL with fragment) of the verification method used to create the proof. REQUIRED.
  /// This typically points to the public key required to verify the proof.
  /// Corresponds to the `verificationMethod` property of the proof.
  @override
  final String verificationMethod;

  /// The value of the cryptographic proof itself (e.g., the digital signature). REQUIRED.
  /// The format depends on the proof `type` (e.g., base64url, multibase).
  /// Corresponds to the `proofValue` property of the proof.
  @override
  final String proofValue;
// Often multibase encoded, e.g., starting with 'z'
  /// The intended domain for which the proof is valid (relevant for VPs). OPTIONAL.
  /// Helps prevent replay attacks across different domains (audiences).
  /// Corresponds to the `domain` property of the proof options.
  @override
  final String? domain;

  /// The cryptographic challenge provided by the verifier (relevant for VPs). OPTIONAL.
  /// Ensures the proof was created in response to a specific request, preventing replay.
  /// Corresponds to the `challenge` property of the proof options.
  @override
  final String? challenge;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Proof(type: $type, created: $created, proofPurpose: $proofPurpose, verificationMethod: $verificationMethod, proofValue: $proofValue, domain: $domain, challenge: $challenge)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Proof'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('created', created))
      ..add(DiagnosticsProperty('proofPurpose', proofPurpose))
      ..add(DiagnosticsProperty('verificationMethod', verificationMethod))
      ..add(DiagnosticsProperty('proofValue', proofValue))
      ..add(DiagnosticsProperty('domain', domain))
      ..add(DiagnosticsProperty('challenge', challenge));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProofImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.proofPurpose, proofPurpose) ||
                other.proofPurpose == proofPurpose) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod) &&
            (identical(other.proofValue, proofValue) ||
                other.proofValue == proofValue) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, created, proofPurpose,
      verificationMethod, proofValue, domain, challenge);

  /// Create a copy of Proof
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProofImplCopyWith<_$ProofImpl> get copyWith =>
      __$$ProofImplCopyWithImpl<_$ProofImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProofImplToJson(
      this,
    );
  }
}

abstract class _Proof implements Proof {
  const factory _Proof(
      {required final String type,
      required final DateTime created,
      required final String proofPurpose,
      required final String verificationMethod,
      required final String proofValue,
      final String? domain,
      final String? challenge}) = _$ProofImpl;

  factory _Proof.fromJson(Map<String, dynamic> json) = _$ProofImpl.fromJson;

  /// The type of the cryptographic proof suite used (e.g., "DataIntegrityProof", "Ed25519Signature2020"). REQUIRED.
  /// Identifies the algorithms and protocols used to generate and verify the proof.
  /// Corresponds to the `type` property of the proof.
  @override
  String get type;

  /// The date and time when the proof was created. REQUIRED.
  /// Must be an XMLSchema dateTime value. Used to check against credential validity and potential replay attacks.
  /// Corresponds to the `created` property of the proof.
  @override
  DateTime get created;

  /// The purpose of the proof, indicating the relationship between the proof and the controller. REQUIRED.
  /// Examples: "assertionMethod" (for VCs, issuer asserts claims), "authentication" (for VPs, holder authenticates).
  /// Corresponds to the `proofPurpose` property of the proof.
  @override
  String get proofPurpose;

  /// The identifier (e.g., DID URL with fragment) of the verification method used to create the proof. REQUIRED.
  /// This typically points to the public key required to verify the proof.
  /// Corresponds to the `verificationMethod` property of the proof.
  @override
  String get verificationMethod;

  /// The value of the cryptographic proof itself (e.g., the digital signature). REQUIRED.
  /// The format depends on the proof `type` (e.g., base64url, multibase).
  /// Corresponds to the `proofValue` property of the proof.
  @override
  String get proofValue; // Often multibase encoded, e.g., starting with 'z'
  /// The intended domain for which the proof is valid (relevant for VPs). OPTIONAL.
  /// Helps prevent replay attacks across different domains (audiences).
  /// Corresponds to the `domain` property of the proof options.
  @override
  String? get domain;

  /// The cryptographic challenge provided by the verifier (relevant for VPs). OPTIONAL.
  /// Ensures the proof was created in response to a specific request, preventing replay.
  /// Corresponds to the `challenge` property of the proof options.
  @override
  String? get challenge;

  /// Create a copy of Proof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProofImplCopyWith<_$ProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CredentialStatus _$CredentialStatusFromJson(Map<String, dynamic> json) {
  return _CredentialStatus.fromJson(json);
}

/// @nodoc
mixin _$CredentialStatus {
  /// The unique identifier of the status entry (URI). REQUIRED.
  String get id => throw _privateConstructorUsedError;

  /// The type of the credential status mechanism (e.g., "StatusList2021Entry"). REQUIRED.
  String get type => throw _privateConstructorUsedError;

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
  $Res call({String id, String type});
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
    Object? id = null,
    Object? type = null,
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
  $Res call({String id, String type});
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
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$CredentialStatusImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialStatusImpl
    with DiagnosticableTreeMixin
    implements _CredentialStatus {
  const _$CredentialStatusImpl({required this.id, required this.type});

  factory _$CredentialStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialStatusImplFromJson(json);

  /// The unique identifier of the status entry (URI). REQUIRED.
  @override
  final String id;

  /// The type of the credential status mechanism (e.g., "StatusList2021Entry"). REQUIRED.
  @override
  final String type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CredentialStatus(id: $id, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CredentialStatus'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialStatusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

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
      {required final String id,
      required final String type}) = _$CredentialStatusImpl;

  factory _CredentialStatus.fromJson(Map<String, dynamic> json) =
      _$CredentialStatusImpl.fromJson;

  /// The unique identifier of the status entry (URI). REQUIRED.
  @override
  String get id;

  /// The type of the credential status mechanism (e.g., "StatusList2021Entry"). REQUIRED.
  @override
  String get type;

  /// Create a copy of CredentialStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialStatusImplCopyWith<_$CredentialStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CredentialSchema _$CredentialSchemaFromJson(Map<String, dynamic> json) {
  return _CredentialSchema.fromJson(json);
}

/// @nodoc
mixin _$CredentialSchema {
  /// The unique identifier of the schema (URI). REQUIRED.
  String get id => throw _privateConstructorUsedError;

  /// The type of the credential schema (e.g., "JsonSchema"). REQUIRED.
  String get type => throw _privateConstructorUsedError;

  /// Serializes this CredentialSchema to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialSchemaCopyWith<CredentialSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialSchemaCopyWith<$Res> {
  factory $CredentialSchemaCopyWith(
          CredentialSchema value, $Res Function(CredentialSchema) then) =
      _$CredentialSchemaCopyWithImpl<$Res, CredentialSchema>;
  @useResult
  $Res call({String id, String type});
}

/// @nodoc
class _$CredentialSchemaCopyWithImpl<$Res, $Val extends CredentialSchema>
    implements $CredentialSchemaCopyWith<$Res> {
  _$CredentialSchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialSchemaImplCopyWith<$Res>
    implements $CredentialSchemaCopyWith<$Res> {
  factory _$$CredentialSchemaImplCopyWith(_$CredentialSchemaImpl value,
          $Res Function(_$CredentialSchemaImpl) then) =
      __$$CredentialSchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String type});
}

/// @nodoc
class __$$CredentialSchemaImplCopyWithImpl<$Res>
    extends _$CredentialSchemaCopyWithImpl<$Res, _$CredentialSchemaImpl>
    implements _$$CredentialSchemaImplCopyWith<$Res> {
  __$$CredentialSchemaImplCopyWithImpl(_$CredentialSchemaImpl _value,
      $Res Function(_$CredentialSchemaImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$CredentialSchemaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialSchemaImpl
    with DiagnosticableTreeMixin
    implements _CredentialSchema {
  const _$CredentialSchemaImpl({required this.id, required this.type});

  factory _$CredentialSchemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialSchemaImplFromJson(json);

  /// The unique identifier of the schema (URI). REQUIRED.
  @override
  final String id;

  /// The type of the credential schema (e.g., "JsonSchema"). REQUIRED.
  @override
  final String type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CredentialSchema(id: $id, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CredentialSchema'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialSchemaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  /// Create a copy of CredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialSchemaImplCopyWith<_$CredentialSchemaImpl> get copyWith =>
      __$$CredentialSchemaImplCopyWithImpl<_$CredentialSchemaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialSchemaImplToJson(
      this,
    );
  }
}

abstract class _CredentialSchema implements CredentialSchema {
  const factory _CredentialSchema(
      {required final String id,
      required final String type}) = _$CredentialSchemaImpl;

  factory _CredentialSchema.fromJson(Map<String, dynamic> json) =
      _$CredentialSchemaImpl.fromJson;

  /// The unique identifier of the schema (URI). REQUIRED.
  @override
  String get id;

  /// The type of the credential schema (e.g., "JsonSchema"). REQUIRED.
  @override
  String get type;

  /// Create a copy of CredentialSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialSchemaImplCopyWith<_$CredentialSchemaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CredentialPredicateValue _$CredentialPredicateValueFromJson(
    Map<String, dynamic> json) {
  return _CredentialPredicateValue.fromJson(json);
}

/// @nodoc
mixin _$CredentialPredicateValue {
  /// Name of the attribute the predicate applies to (e.g., "age", "nationality").
  String get attributeName => throw _privateConstructorUsedError;

  /// The type of comparison to perform. See [PredicateType].
  PredicateType get predicateType => throw _privateConstructorUsedError;

  /// The value to use in the comparison.
  dynamic get value => throw _privateConstructorUsedError;

  /// Serializes this CredentialPredicateValue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialPredicateValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialPredicateValueCopyWith<CredentialPredicateValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialPredicateValueCopyWith<$Res> {
  factory $CredentialPredicateValueCopyWith(CredentialPredicateValue value,
          $Res Function(CredentialPredicateValue) then) =
      _$CredentialPredicateValueCopyWithImpl<$Res, CredentialPredicateValue>;
  @useResult
  $Res call({String attributeName, PredicateType predicateType, dynamic value});
}

/// @nodoc
class _$CredentialPredicateValueCopyWithImpl<$Res,
        $Val extends CredentialPredicateValue>
    implements $CredentialPredicateValueCopyWith<$Res> {
  _$CredentialPredicateValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialPredicateValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributeName = null,
    Object? predicateType = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      attributeName: null == attributeName
          ? _value.attributeName
          : attributeName // ignore: cast_nullable_to_non_nullable
              as String,
      predicateType: null == predicateType
          ? _value.predicateType
          : predicateType // ignore: cast_nullable_to_non_nullable
              as PredicateType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialPredicateValueImplCopyWith<$Res>
    implements $CredentialPredicateValueCopyWith<$Res> {
  factory _$$CredentialPredicateValueImplCopyWith(
          _$CredentialPredicateValueImpl value,
          $Res Function(_$CredentialPredicateValueImpl) then) =
      __$$CredentialPredicateValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String attributeName, PredicateType predicateType, dynamic value});
}

/// @nodoc
class __$$CredentialPredicateValueImplCopyWithImpl<$Res>
    extends _$CredentialPredicateValueCopyWithImpl<$Res,
        _$CredentialPredicateValueImpl>
    implements _$$CredentialPredicateValueImplCopyWith<$Res> {
  __$$CredentialPredicateValueImplCopyWithImpl(
      _$CredentialPredicateValueImpl _value,
      $Res Function(_$CredentialPredicateValueImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialPredicateValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributeName = null,
    Object? predicateType = null,
    Object? value = freezed,
  }) {
    return _then(_$CredentialPredicateValueImpl(
      attributeName: null == attributeName
          ? _value.attributeName
          : attributeName // ignore: cast_nullable_to_non_nullable
              as String,
      predicateType: null == predicateType
          ? _value.predicateType
          : predicateType // ignore: cast_nullable_to_non_nullable
              as PredicateType,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialPredicateValueImpl
    with DiagnosticableTreeMixin
    implements _CredentialPredicateValue {
  const _$CredentialPredicateValueImpl(
      {required this.attributeName,
      required this.predicateType,
      required this.value});

  factory _$CredentialPredicateValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialPredicateValueImplFromJson(json);

  /// Name of the attribute the predicate applies to (e.g., "age", "nationality").
  @override
  final String attributeName;

  /// The type of comparison to perform. See [PredicateType].
  @override
  final PredicateType predicateType;

  /// The value to use in the comparison.
  @override
  final dynamic value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CredentialPredicateValue(attributeName: $attributeName, predicateType: $predicateType, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CredentialPredicateValue'))
      ..add(DiagnosticsProperty('attributeName', attributeName))
      ..add(DiagnosticsProperty('predicateType', predicateType))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialPredicateValueImpl &&
            (identical(other.attributeName, attributeName) ||
                other.attributeName == attributeName) &&
            (identical(other.predicateType, predicateType) ||
                other.predicateType == predicateType) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, attributeName, predicateType,
      const DeepCollectionEquality().hash(value));

  /// Create a copy of CredentialPredicateValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialPredicateValueImplCopyWith<_$CredentialPredicateValueImpl>
      get copyWith => __$$CredentialPredicateValueImplCopyWithImpl<
          _$CredentialPredicateValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialPredicateValueImplToJson(
      this,
    );
  }
}

abstract class _CredentialPredicateValue implements CredentialPredicateValue {
  const factory _CredentialPredicateValue(
      {required final String attributeName,
      required final PredicateType predicateType,
      required final dynamic value}) = _$CredentialPredicateValueImpl;

  factory _CredentialPredicateValue.fromJson(Map<String, dynamic> json) =
      _$CredentialPredicateValueImpl.fromJson;

  /// Name of the attribute the predicate applies to (e.g., "age", "nationality").
  @override
  String get attributeName;

  /// The type of comparison to perform. See [PredicateType].
  @override
  PredicateType get predicateType;

  /// The value to use in the comparison.
  @override
  dynamic get value;

  /// Create a copy of CredentialPredicateValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialPredicateValueImplCopyWith<_$CredentialPredicateValueImpl>
      get copyWith => throw _privateConstructorUsedError;
}
