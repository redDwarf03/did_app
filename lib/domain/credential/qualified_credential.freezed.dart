// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qualified_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QualifiedCredential _$QualifiedCredentialFromJson(Map<String, dynamic> json) {
  return _QualifiedCredential.fromJson(json);
}

/// @nodoc
mixin _$QualifiedCredential {
  /// Attestation de base
  Credential get credential => throw _privateConstructorUsedError;

  /// Niveau d'assurance
  AssuranceLevel get assuranceLevel => throw _privateConstructorUsedError;

  /// Type de signature qualifiée
  QualifiedSignatureType get signatureType =>
      throw _privateConstructorUsedError;

  /// Identifiant de l'autorité de certification qualifiée
  String get qualifiedTrustServiceProviderId =>
      throw _privateConstructorUsedError;

  /// Date de certification
  DateTime get certificationDate => throw _privateConstructorUsedError;

  /// Date d'expiration de la certification
  DateTime get certificationExpiryDate => throw _privateConstructorUsedError;

  /// Pays de l'autorité de certification
  String get certificationCountry => throw _privateConstructorUsedError;

  /// URL du registre de confiance qualifié
  String get qualifiedTrustRegistryUrl => throw _privateConstructorUsedError;

  /// Identifiant du certificat qualifié
  String get qualifiedCertificateId => throw _privateConstructorUsedError;

  /// Liste des attributs qualifiés
  Map<String, dynamic> get qualifiedAttributes =>
      throw _privateConstructorUsedError;

  /// Preuve de certification qualifiée
  String get qualifiedProof => throw _privateConstructorUsedError;

  /// Serializes this QualifiedCredential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QualifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QualifiedCredentialCopyWith<QualifiedCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QualifiedCredentialCopyWith<$Res> {
  factory $QualifiedCredentialCopyWith(
          QualifiedCredential value, $Res Function(QualifiedCredential) then) =
      _$QualifiedCredentialCopyWithImpl<$Res, QualifiedCredential>;
  @useResult
  $Res call(
      {Credential credential,
      AssuranceLevel assuranceLevel,
      QualifiedSignatureType signatureType,
      String qualifiedTrustServiceProviderId,
      DateTime certificationDate,
      DateTime certificationExpiryDate,
      String certificationCountry,
      String qualifiedTrustRegistryUrl,
      String qualifiedCertificateId,
      Map<String, dynamic> qualifiedAttributes,
      String qualifiedProof});

  $CredentialCopyWith<$Res> get credential;
}

/// @nodoc
class _$QualifiedCredentialCopyWithImpl<$Res, $Val extends QualifiedCredential>
    implements $QualifiedCredentialCopyWith<$Res> {
  _$QualifiedCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QualifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credential = null,
    Object? assuranceLevel = null,
    Object? signatureType = null,
    Object? qualifiedTrustServiceProviderId = null,
    Object? certificationDate = null,
    Object? certificationExpiryDate = null,
    Object? certificationCountry = null,
    Object? qualifiedTrustRegistryUrl = null,
    Object? qualifiedCertificateId = null,
    Object? qualifiedAttributes = null,
    Object? qualifiedProof = null,
  }) {
    return _then(_value.copyWith(
      credential: null == credential
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as Credential,
      assuranceLevel: null == assuranceLevel
          ? _value.assuranceLevel
          : assuranceLevel // ignore: cast_nullable_to_non_nullable
              as AssuranceLevel,
      signatureType: null == signatureType
          ? _value.signatureType
          : signatureType // ignore: cast_nullable_to_non_nullable
              as QualifiedSignatureType,
      qualifiedTrustServiceProviderId: null == qualifiedTrustServiceProviderId
          ? _value.qualifiedTrustServiceProviderId
          : qualifiedTrustServiceProviderId // ignore: cast_nullable_to_non_nullable
              as String,
      certificationDate: null == certificationDate
          ? _value.certificationDate
          : certificationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      certificationExpiryDate: null == certificationExpiryDate
          ? _value.certificationExpiryDate
          : certificationExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      certificationCountry: null == certificationCountry
          ? _value.certificationCountry
          : certificationCountry // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedTrustRegistryUrl: null == qualifiedTrustRegistryUrl
          ? _value.qualifiedTrustRegistryUrl
          : qualifiedTrustRegistryUrl // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedCertificateId: null == qualifiedCertificateId
          ? _value.qualifiedCertificateId
          : qualifiedCertificateId // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedAttributes: null == qualifiedAttributes
          ? _value.qualifiedAttributes
          : qualifiedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      qualifiedProof: null == qualifiedProof
          ? _value.qualifiedProof
          : qualifiedProof // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of QualifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CredentialCopyWith<$Res> get credential {
    return $CredentialCopyWith<$Res>(_value.credential, (value) {
      return _then(_value.copyWith(credential: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QualifiedCredentialImplCopyWith<$Res>
    implements $QualifiedCredentialCopyWith<$Res> {
  factory _$$QualifiedCredentialImplCopyWith(_$QualifiedCredentialImpl value,
          $Res Function(_$QualifiedCredentialImpl) then) =
      __$$QualifiedCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Credential credential,
      AssuranceLevel assuranceLevel,
      QualifiedSignatureType signatureType,
      String qualifiedTrustServiceProviderId,
      DateTime certificationDate,
      DateTime certificationExpiryDate,
      String certificationCountry,
      String qualifiedTrustRegistryUrl,
      String qualifiedCertificateId,
      Map<String, dynamic> qualifiedAttributes,
      String qualifiedProof});

  @override
  $CredentialCopyWith<$Res> get credential;
}

/// @nodoc
class __$$QualifiedCredentialImplCopyWithImpl<$Res>
    extends _$QualifiedCredentialCopyWithImpl<$Res, _$QualifiedCredentialImpl>
    implements _$$QualifiedCredentialImplCopyWith<$Res> {
  __$$QualifiedCredentialImplCopyWithImpl(_$QualifiedCredentialImpl _value,
      $Res Function(_$QualifiedCredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of QualifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credential = null,
    Object? assuranceLevel = null,
    Object? signatureType = null,
    Object? qualifiedTrustServiceProviderId = null,
    Object? certificationDate = null,
    Object? certificationExpiryDate = null,
    Object? certificationCountry = null,
    Object? qualifiedTrustRegistryUrl = null,
    Object? qualifiedCertificateId = null,
    Object? qualifiedAttributes = null,
    Object? qualifiedProof = null,
  }) {
    return _then(_$QualifiedCredentialImpl(
      credential: null == credential
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as Credential,
      assuranceLevel: null == assuranceLevel
          ? _value.assuranceLevel
          : assuranceLevel // ignore: cast_nullable_to_non_nullable
              as AssuranceLevel,
      signatureType: null == signatureType
          ? _value.signatureType
          : signatureType // ignore: cast_nullable_to_non_nullable
              as QualifiedSignatureType,
      qualifiedTrustServiceProviderId: null == qualifiedTrustServiceProviderId
          ? _value.qualifiedTrustServiceProviderId
          : qualifiedTrustServiceProviderId // ignore: cast_nullable_to_non_nullable
              as String,
      certificationDate: null == certificationDate
          ? _value.certificationDate
          : certificationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      certificationExpiryDate: null == certificationExpiryDate
          ? _value.certificationExpiryDate
          : certificationExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      certificationCountry: null == certificationCountry
          ? _value.certificationCountry
          : certificationCountry // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedTrustRegistryUrl: null == qualifiedTrustRegistryUrl
          ? _value.qualifiedTrustRegistryUrl
          : qualifiedTrustRegistryUrl // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedCertificateId: null == qualifiedCertificateId
          ? _value.qualifiedCertificateId
          : qualifiedCertificateId // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedAttributes: null == qualifiedAttributes
          ? _value._qualifiedAttributes
          : qualifiedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      qualifiedProof: null == qualifiedProof
          ? _value.qualifiedProof
          : qualifiedProof // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QualifiedCredentialImpl implements _QualifiedCredential {
  const _$QualifiedCredentialImpl(
      {required this.credential,
      required this.assuranceLevel,
      required this.signatureType,
      required this.qualifiedTrustServiceProviderId,
      required this.certificationDate,
      required this.certificationExpiryDate,
      required this.certificationCountry,
      required this.qualifiedTrustRegistryUrl,
      required this.qualifiedCertificateId,
      required final Map<String, dynamic> qualifiedAttributes,
      required this.qualifiedProof})
      : _qualifiedAttributes = qualifiedAttributes;

  factory _$QualifiedCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$QualifiedCredentialImplFromJson(json);

  /// Attestation de base
  @override
  final Credential credential;

  /// Niveau d'assurance
  @override
  final AssuranceLevel assuranceLevel;

  /// Type de signature qualifiée
  @override
  final QualifiedSignatureType signatureType;

  /// Identifiant de l'autorité de certification qualifiée
  @override
  final String qualifiedTrustServiceProviderId;

  /// Date de certification
  @override
  final DateTime certificationDate;

  /// Date d'expiration de la certification
  @override
  final DateTime certificationExpiryDate;

  /// Pays de l'autorité de certification
  @override
  final String certificationCountry;

  /// URL du registre de confiance qualifié
  @override
  final String qualifiedTrustRegistryUrl;

  /// Identifiant du certificat qualifié
  @override
  final String qualifiedCertificateId;

  /// Liste des attributs qualifiés
  final Map<String, dynamic> _qualifiedAttributes;

  /// Liste des attributs qualifiés
  @override
  Map<String, dynamic> get qualifiedAttributes {
    if (_qualifiedAttributes is EqualUnmodifiableMapView)
      return _qualifiedAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_qualifiedAttributes);
  }

  /// Preuve de certification qualifiée
  @override
  final String qualifiedProof;

  @override
  String toString() {
    return 'QualifiedCredential(credential: $credential, assuranceLevel: $assuranceLevel, signatureType: $signatureType, qualifiedTrustServiceProviderId: $qualifiedTrustServiceProviderId, certificationDate: $certificationDate, certificationExpiryDate: $certificationExpiryDate, certificationCountry: $certificationCountry, qualifiedTrustRegistryUrl: $qualifiedTrustRegistryUrl, qualifiedCertificateId: $qualifiedCertificateId, qualifiedAttributes: $qualifiedAttributes, qualifiedProof: $qualifiedProof)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualifiedCredentialImpl &&
            (identical(other.credential, credential) ||
                other.credential == credential) &&
            (identical(other.assuranceLevel, assuranceLevel) ||
                other.assuranceLevel == assuranceLevel) &&
            (identical(other.signatureType, signatureType) ||
                other.signatureType == signatureType) &&
            (identical(other.qualifiedTrustServiceProviderId,
                    qualifiedTrustServiceProviderId) ||
                other.qualifiedTrustServiceProviderId ==
                    qualifiedTrustServiceProviderId) &&
            (identical(other.certificationDate, certificationDate) ||
                other.certificationDate == certificationDate) &&
            (identical(
                    other.certificationExpiryDate, certificationExpiryDate) ||
                other.certificationExpiryDate == certificationExpiryDate) &&
            (identical(other.certificationCountry, certificationCountry) ||
                other.certificationCountry == certificationCountry) &&
            (identical(other.qualifiedTrustRegistryUrl,
                    qualifiedTrustRegistryUrl) ||
                other.qualifiedTrustRegistryUrl == qualifiedTrustRegistryUrl) &&
            (identical(other.qualifiedCertificateId, qualifiedCertificateId) ||
                other.qualifiedCertificateId == qualifiedCertificateId) &&
            const DeepCollectionEquality()
                .equals(other._qualifiedAttributes, _qualifiedAttributes) &&
            (identical(other.qualifiedProof, qualifiedProof) ||
                other.qualifiedProof == qualifiedProof));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      credential,
      assuranceLevel,
      signatureType,
      qualifiedTrustServiceProviderId,
      certificationDate,
      certificationExpiryDate,
      certificationCountry,
      qualifiedTrustRegistryUrl,
      qualifiedCertificateId,
      const DeepCollectionEquality().hash(_qualifiedAttributes),
      qualifiedProof);

  /// Create a copy of QualifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QualifiedCredentialImplCopyWith<_$QualifiedCredentialImpl> get copyWith =>
      __$$QualifiedCredentialImplCopyWithImpl<_$QualifiedCredentialImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QualifiedCredentialImplToJson(
      this,
    );
  }
}

abstract class _QualifiedCredential implements QualifiedCredential {
  const factory _QualifiedCredential(
      {required final Credential credential,
      required final AssuranceLevel assuranceLevel,
      required final QualifiedSignatureType signatureType,
      required final String qualifiedTrustServiceProviderId,
      required final DateTime certificationDate,
      required final DateTime certificationExpiryDate,
      required final String certificationCountry,
      required final String qualifiedTrustRegistryUrl,
      required final String qualifiedCertificateId,
      required final Map<String, dynamic> qualifiedAttributes,
      required final String qualifiedProof}) = _$QualifiedCredentialImpl;

  factory _QualifiedCredential.fromJson(Map<String, dynamic> json) =
      _$QualifiedCredentialImpl.fromJson;

  /// Attestation de base
  @override
  Credential get credential;

  /// Niveau d'assurance
  @override
  AssuranceLevel get assuranceLevel;

  /// Type de signature qualifiée
  @override
  QualifiedSignatureType get signatureType;

  /// Identifiant de l'autorité de certification qualifiée
  @override
  String get qualifiedTrustServiceProviderId;

  /// Date de certification
  @override
  DateTime get certificationDate;

  /// Date d'expiration de la certification
  @override
  DateTime get certificationExpiryDate;

  /// Pays de l'autorité de certification
  @override
  String get certificationCountry;

  /// URL du registre de confiance qualifié
  @override
  String get qualifiedTrustRegistryUrl;

  /// Identifiant du certificat qualifié
  @override
  String get qualifiedCertificateId;

  /// Liste des attributs qualifiés
  @override
  Map<String, dynamic> get qualifiedAttributes;

  /// Preuve de certification qualifiée
  @override
  String get qualifiedProof;

  /// Create a copy of QualifiedCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QualifiedCredentialImplCopyWith<_$QualifiedCredentialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QualifiedTrustService _$QualifiedTrustServiceFromJson(
    Map<String, dynamic> json) {
  return _QualifiedTrustService.fromJson(json);
}

/// @nodoc
mixin _$QualifiedTrustService {
  /// Identifiant unique du service
  String get id => throw _privateConstructorUsedError;

  /// Nom du service
  String get name => throw _privateConstructorUsedError;

  /// Type de service
  String get type => throw _privateConstructorUsedError;

  /// Pays du service
  String get country => throw _privateConstructorUsedError;

  /// Statut du service
  String get status => throw _privateConstructorUsedError;

  /// Date de début de validité
  DateTime get startDate => throw _privateConstructorUsedError;

  /// Date de fin de validité
  DateTime get endDate => throw _privateConstructorUsedError;

  /// URL du service
  String get serviceUrl => throw _privateConstructorUsedError;

  /// Liste des certificats qualifiés
  List<String> get qualifiedCertificates => throw _privateConstructorUsedError;

  /// Niveau d'assurance
  AssuranceLevel get assuranceLevel => throw _privateConstructorUsedError;

  /// Serializes this QualifiedTrustService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QualifiedTrustService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QualifiedTrustServiceCopyWith<QualifiedTrustService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QualifiedTrustServiceCopyWith<$Res> {
  factory $QualifiedTrustServiceCopyWith(QualifiedTrustService value,
          $Res Function(QualifiedTrustService) then) =
      _$QualifiedTrustServiceCopyWithImpl<$Res, QualifiedTrustService>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String country,
      String status,
      DateTime startDate,
      DateTime endDate,
      String serviceUrl,
      List<String> qualifiedCertificates,
      AssuranceLevel assuranceLevel});
}

/// @nodoc
class _$QualifiedTrustServiceCopyWithImpl<$Res,
        $Val extends QualifiedTrustService>
    implements $QualifiedTrustServiceCopyWith<$Res> {
  _$QualifiedTrustServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QualifiedTrustService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? country = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? serviceUrl = null,
    Object? qualifiedCertificates = null,
    Object? assuranceLevel = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serviceUrl: null == serviceUrl
          ? _value.serviceUrl
          : serviceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedCertificates: null == qualifiedCertificates
          ? _value.qualifiedCertificates
          : qualifiedCertificates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assuranceLevel: null == assuranceLevel
          ? _value.assuranceLevel
          : assuranceLevel // ignore: cast_nullable_to_non_nullable
              as AssuranceLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QualifiedTrustServiceImplCopyWith<$Res>
    implements $QualifiedTrustServiceCopyWith<$Res> {
  factory _$$QualifiedTrustServiceImplCopyWith(
          _$QualifiedTrustServiceImpl value,
          $Res Function(_$QualifiedTrustServiceImpl) then) =
      __$$QualifiedTrustServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String country,
      String status,
      DateTime startDate,
      DateTime endDate,
      String serviceUrl,
      List<String> qualifiedCertificates,
      AssuranceLevel assuranceLevel});
}

/// @nodoc
class __$$QualifiedTrustServiceImplCopyWithImpl<$Res>
    extends _$QualifiedTrustServiceCopyWithImpl<$Res,
        _$QualifiedTrustServiceImpl>
    implements _$$QualifiedTrustServiceImplCopyWith<$Res> {
  __$$QualifiedTrustServiceImplCopyWithImpl(_$QualifiedTrustServiceImpl _value,
      $Res Function(_$QualifiedTrustServiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of QualifiedTrustService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? country = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? serviceUrl = null,
    Object? qualifiedCertificates = null,
    Object? assuranceLevel = null,
  }) {
    return _then(_$QualifiedTrustServiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serviceUrl: null == serviceUrl
          ? _value.serviceUrl
          : serviceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedCertificates: null == qualifiedCertificates
          ? _value._qualifiedCertificates
          : qualifiedCertificates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assuranceLevel: null == assuranceLevel
          ? _value.assuranceLevel
          : assuranceLevel // ignore: cast_nullable_to_non_nullable
              as AssuranceLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QualifiedTrustServiceImpl implements _QualifiedTrustService {
  const _$QualifiedTrustServiceImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.country,
      required this.status,
      required this.startDate,
      required this.endDate,
      required this.serviceUrl,
      required final List<String> qualifiedCertificates,
      required this.assuranceLevel})
      : _qualifiedCertificates = qualifiedCertificates;

  factory _$QualifiedTrustServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$QualifiedTrustServiceImplFromJson(json);

  /// Identifiant unique du service
  @override
  final String id;

  /// Nom du service
  @override
  final String name;

  /// Type de service
  @override
  final String type;

  /// Pays du service
  @override
  final String country;

  /// Statut du service
  @override
  final String status;

  /// Date de début de validité
  @override
  final DateTime startDate;

  /// Date de fin de validité
  @override
  final DateTime endDate;

  /// URL du service
  @override
  final String serviceUrl;

  /// Liste des certificats qualifiés
  final List<String> _qualifiedCertificates;

  /// Liste des certificats qualifiés
  @override
  List<String> get qualifiedCertificates {
    if (_qualifiedCertificates is EqualUnmodifiableListView)
      return _qualifiedCertificates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualifiedCertificates);
  }

  /// Niveau d'assurance
  @override
  final AssuranceLevel assuranceLevel;

  @override
  String toString() {
    return 'QualifiedTrustService(id: $id, name: $name, type: $type, country: $country, status: $status, startDate: $startDate, endDate: $endDate, serviceUrl: $serviceUrl, qualifiedCertificates: $qualifiedCertificates, assuranceLevel: $assuranceLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualifiedTrustServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.serviceUrl, serviceUrl) ||
                other.serviceUrl == serviceUrl) &&
            const DeepCollectionEquality()
                .equals(other._qualifiedCertificates, _qualifiedCertificates) &&
            (identical(other.assuranceLevel, assuranceLevel) ||
                other.assuranceLevel == assuranceLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      country,
      status,
      startDate,
      endDate,
      serviceUrl,
      const DeepCollectionEquality().hash(_qualifiedCertificates),
      assuranceLevel);

  /// Create a copy of QualifiedTrustService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QualifiedTrustServiceImplCopyWith<_$QualifiedTrustServiceImpl>
      get copyWith => __$$QualifiedTrustServiceImplCopyWithImpl<
          _$QualifiedTrustServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QualifiedTrustServiceImplToJson(
      this,
    );
  }
}

abstract class _QualifiedTrustService implements QualifiedTrustService {
  const factory _QualifiedTrustService(
          {required final String id,
          required final String name,
          required final String type,
          required final String country,
          required final String status,
          required final DateTime startDate,
          required final DateTime endDate,
          required final String serviceUrl,
          required final List<String> qualifiedCertificates,
          required final AssuranceLevel assuranceLevel}) =
      _$QualifiedTrustServiceImpl;

  factory _QualifiedTrustService.fromJson(Map<String, dynamic> json) =
      _$QualifiedTrustServiceImpl.fromJson;

  /// Identifiant unique du service
  @override
  String get id;

  /// Nom du service
  @override
  String get name;

  /// Type de service
  @override
  String get type;

  /// Pays du service
  @override
  String get country;

  /// Statut du service
  @override
  String get status;

  /// Date de début de validité
  @override
  DateTime get startDate;

  /// Date de fin de validité
  @override
  DateTime get endDate;

  /// URL du service
  @override
  String get serviceUrl;

  /// Liste des certificats qualifiés
  @override
  List<String> get qualifiedCertificates;

  /// Niveau d'assurance
  @override
  AssuranceLevel get assuranceLevel;

  /// Create a copy of QualifiedTrustService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QualifiedTrustServiceImplCopyWith<_$QualifiedTrustServiceImpl>
      get copyWith => throw _privateConstructorUsedError;
}
