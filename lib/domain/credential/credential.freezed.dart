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
  /// Identifiant unique de l'attestation
  String get id => throw _privateConstructorUsedError;

  /// Type de l'attestation
  List<String> get type => throw _privateConstructorUsedError;

  /// Émetteur de l'attestation
  String get issuer => throw _privateConstructorUsedError;

  /// Nom de l'attestation
  String? get name => throw _privateConstructorUsedError;

  /// Description de l'attestation
  String? get description => throw _privateConstructorUsedError;

  /// Sujet de l'attestation (pour la comptabilité avec les URIs DID)
  String? get subject => throw _privateConstructorUsedError;

  /// Date d'émission
  DateTime get issuanceDate => throw _privateConstructorUsedError;

  /// Date d'expiration
  DateTime? get expirationDate => throw _privateConstructorUsedError;

  /// URL de la liste de statut
  String? get statusListUrl => throw _privateConstructorUsedError;

  /// Index dans la liste de statut
  int? get statusListIndex => throw _privateConstructorUsedError;

  /// Statut de l'attestation
  VerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;

  /// Schéma de l'attestation
  Map<String, dynamic>? get credentialSchema =>
      throw _privateConstructorUsedError;

  /// Statut de l'attestation
  Map<String, dynamic>? get status => throw _privateConstructorUsedError;

  /// Indique si l'attestation supporte les preuves à divulgation nulle
  bool get supportsZkp => throw _privateConstructorUsedError;

  /// Sujet de l'attestation (claims)
  Map<String, dynamic> get credentialSubject =>
      throw _privateConstructorUsedError;

  /// Contexte JSON-LD
  @JsonKey(name: '@context')
  List<String> get context => throw _privateConstructorUsedError;

  /// Preuve cryptographique
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
      String? statusListUrl,
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
      String? statusListUrl,
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
      this.statusListUrl,
      this.statusListIndex,
      this.verificationStatus = VerificationStatus.unverified,
      final Map<String, dynamic>? credentialSchema,
      final Map<String, dynamic>? status,
      this.supportsZkp = false,
      required final Map<String, dynamic> credentialSubject,
      @JsonKey(name: '@context') final List<String> context = const [],
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

  /// Identifiant unique de l'attestation
  @override
  final String id;

  /// Type de l'attestation
  final List<String> _type;

  /// Type de l'attestation
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  /// Émetteur de l'attestation
  @override
  final String issuer;

  /// Nom de l'attestation
  @override
  final String? name;

  /// Description de l'attestation
  @override
  final String? description;

  /// Sujet de l'attestation (pour la comptabilité avec les URIs DID)
  @override
  final String? subject;

  /// Date d'émission
  @override
  final DateTime issuanceDate;

  /// Date d'expiration
  @override
  final DateTime? expirationDate;

  /// URL de la liste de statut
  @override
  final String? statusListUrl;

  /// Index dans la liste de statut
  @override
  final int? statusListIndex;

  /// Statut de l'attestation
  @override
  @JsonKey()
  final VerificationStatus verificationStatus;

  /// Schéma de l'attestation
  final Map<String, dynamic>? _credentialSchema;

  /// Schéma de l'attestation
  @override
  Map<String, dynamic>? get credentialSchema {
    final value = _credentialSchema;
    if (value == null) return null;
    if (_credentialSchema is EqualUnmodifiableMapView) return _credentialSchema;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Statut de l'attestation
  final Map<String, dynamic>? _status;

  /// Statut de l'attestation
  @override
  Map<String, dynamic>? get status {
    final value = _status;
    if (value == null) return null;
    if (_status is EqualUnmodifiableMapView) return _status;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Indique si l'attestation supporte les preuves à divulgation nulle
  @override
  @JsonKey()
  final bool supportsZkp;

  /// Sujet de l'attestation (claims)
  final Map<String, dynamic> _credentialSubject;

  /// Sujet de l'attestation (claims)
  @override
  Map<String, dynamic> get credentialSubject {
    if (_credentialSubject is EqualUnmodifiableMapView)
      return _credentialSubject;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_credentialSubject);
  }

  /// Contexte JSON-LD
  final List<String> _context;

  /// Contexte JSON-LD
  @override
  @JsonKey(name: '@context')
  List<String> get context {
    if (_context is EqualUnmodifiableListView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_context);
  }

  /// Preuve cryptographique
  final Map<String, dynamic> _proof;

  /// Preuve cryptographique
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
      final String? statusListUrl,
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

  /// Identifiant unique de l'attestation
  @override
  String get id;

  /// Type de l'attestation
  @override
  List<String> get type;

  /// Émetteur de l'attestation
  @override
  String get issuer;

  /// Nom de l'attestation
  @override
  String? get name;

  /// Description de l'attestation
  @override
  String? get description;

  /// Sujet de l'attestation (pour la comptabilité avec les URIs DID)
  @override
  String? get subject;

  /// Date d'émission
  @override
  DateTime get issuanceDate;

  /// Date d'expiration
  @override
  DateTime? get expirationDate;

  /// URL de la liste de statut
  @override
  String? get statusListUrl;

  /// Index dans la liste de statut
  @override
  int? get statusListIndex;

  /// Statut de l'attestation
  @override
  VerificationStatus get verificationStatus;

  /// Schéma de l'attestation
  @override
  Map<String, dynamic>? get credentialSchema;

  /// Statut de l'attestation
  @override
  Map<String, dynamic>? get status;

  /// Indique si l'attestation supporte les preuves à divulgation nulle
  @override
  bool get supportsZkp;

  /// Sujet de l'attestation (claims)
  @override
  Map<String, dynamic> get credentialSubject;

  /// Contexte JSON-LD
  @override
  @JsonKey(name: '@context')
  List<String> get context;

  /// Preuve cryptographique
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
  /// Identifiant unique de la présentation
  String get id => throw _privateConstructorUsedError;

  /// Type de la présentation
  List<String> get type => throw _privateConstructorUsedError;

  /// Liste des attestations incluses
  List<Credential> get verifiableCredentials =>
      throw _privateConstructorUsedError;

  /// Challenge utilisé pour la vérification
  String? get challenge => throw _privateConstructorUsedError;

  /// Domaine pour lequel la présentation est générée
  String? get domain => throw _privateConstructorUsedError;

  /// Attributs révélés par attestation
  Map<String, List<String>> get revealedAttributes =>
      throw _privateConstructorUsedError;

  /// Preuve de la présentation
  Map<String, dynamic> get proof => throw _privateConstructorUsedError;

  /// Date de création
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

  /// Identifiant unique de la présentation
  @override
  final String id;

  /// Type de la présentation
  final List<String> _type;

  /// Type de la présentation
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  /// Liste des attestations incluses
  final List<Credential> _verifiableCredentials;

  /// Liste des attestations incluses
  @override
  List<Credential> get verifiableCredentials {
    if (_verifiableCredentials is EqualUnmodifiableListView)
      return _verifiableCredentials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verifiableCredentials);
  }

  /// Challenge utilisé pour la vérification
  @override
  final String? challenge;

  /// Domaine pour lequel la présentation est générée
  @override
  final String? domain;

  /// Attributs révélés par attestation
  final Map<String, List<String>> _revealedAttributes;

  /// Attributs révélés par attestation
  @override
  Map<String, List<String>> get revealedAttributes {
    if (_revealedAttributes is EqualUnmodifiableMapView)
      return _revealedAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_revealedAttributes);
  }

  /// Preuve de la présentation
  final Map<String, dynamic> _proof;

  /// Preuve de la présentation
  @override
  Map<String, dynamic> get proof {
    if (_proof is EqualUnmodifiableMapView) return _proof;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_proof);
  }

  /// Date de création
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

  /// Identifiant unique de la présentation
  @override
  String get id;

  /// Type de la présentation
  @override
  List<String> get type;

  /// Liste des attestations incluses
  @override
  List<Credential> get verifiableCredentials;

  /// Challenge utilisé pour la vérification
  @override
  String? get challenge;

  /// Domaine pour lequel la présentation est générée
  @override
  String? get domain;

  /// Attributs révélés par attestation
  @override
  Map<String, List<String>> get revealedAttributes;

  /// Preuve de la présentation
  @override
  Map<String, dynamic> get proof;

  /// Date de création
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
  /// Identifiant de l'attestation
  String get credentialId => throw _privateConstructorUsedError;

  /// Attribut sur lequel appliquer le prédicat
  String get attribute => throw _privateConstructorUsedError;

  /// Nom de l'attribut (pour l'affichage)
  String get attributeName => throw _privateConstructorUsedError;

  /// Prédicat (>=, <=, ==, etc.)
  String get predicate => throw _privateConstructorUsedError;

  /// Type de prédicat
  PredicateType get predicateType => throw _privateConstructorUsedError;

  /// Valeur à comparer
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

  /// Identifiant de l'attestation
  @override
  final String credentialId;

  /// Attribut sur lequel appliquer le prédicat
  @override
  final String attribute;

  /// Nom de l'attribut (pour l'affichage)
  @override
  final String attributeName;

  /// Prédicat (>=, <=, ==, etc.)
  @override
  final String predicate;

  /// Type de prédicat
  @override
  final PredicateType predicateType;

  /// Valeur à comparer
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

  /// Identifiant de l'attestation
  @override
  String get credentialId;

  /// Attribut sur lequel appliquer le prédicat
  @override
  String get attribute;

  /// Nom de l'attribut (pour l'affichage)
  @override
  String get attributeName;

  /// Prédicat (>=, <=, ==, etc.)
  @override
  String get predicate;

  /// Type de prédicat
  @override
  PredicateType get predicateType;

  /// Valeur à comparer
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
  /// Type de preuve
  String get type => throw _privateConstructorUsedError;

  /// Date de création
  DateTime get created => throw _privateConstructorUsedError;

  /// Méthode de vérification
  String get verificationMethod => throw _privateConstructorUsedError;

  /// Signature de la preuve
  String get proofValue => throw _privateConstructorUsedError;

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
      String verificationMethod,
      String proofValue});
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
    Object? verificationMethod = null,
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
      proofValue: null == proofValue
          ? _value.proofValue
          : proofValue // ignore: cast_nullable_to_non_nullable
              as String,
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
      String verificationMethod,
      String proofValue});
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
    Object? verificationMethod = null,
    Object? proofValue = null,
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
      verificationMethod: null == verificationMethod
          ? _value.verificationMethod
          : verificationMethod // ignore: cast_nullable_to_non_nullable
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
class _$ProofImpl with DiagnosticableTreeMixin implements _Proof {
  const _$ProofImpl(
      {required this.type,
      required this.created,
      required this.verificationMethod,
      required this.proofValue});

  factory _$ProofImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProofImplFromJson(json);

  /// Type de preuve
  @override
  final String type;

  /// Date de création
  @override
  final DateTime created;

  /// Méthode de vérification
  @override
  final String verificationMethod;

  /// Signature de la preuve
  @override
  final String proofValue;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Proof(type: $type, created: $created, verificationMethod: $verificationMethod, proofValue: $proofValue)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Proof'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('created', created))
      ..add(DiagnosticsProperty('verificationMethod', verificationMethod))
      ..add(DiagnosticsProperty('proofValue', proofValue));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProofImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.verificationMethod, verificationMethod) ||
                other.verificationMethod == verificationMethod) &&
            (identical(other.proofValue, proofValue) ||
                other.proofValue == proofValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, created, verificationMethod, proofValue);

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
      required final String verificationMethod,
      required final String proofValue}) = _$ProofImpl;

  factory _Proof.fromJson(Map<String, dynamic> json) = _$ProofImpl.fromJson;

  /// Type de preuve
  @override
  String get type;

  /// Date de création
  @override
  DateTime get created;

  /// Méthode de vérification
  @override
  String get verificationMethod;

  /// Signature de la preuve
  @override
  String get proofValue;

  /// Create a copy of Proof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProofImplCopyWith<_$ProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
