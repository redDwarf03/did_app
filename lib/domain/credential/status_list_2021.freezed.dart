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
  /// Identifiant unique de la liste de statut
  String get id => throw _privateConstructorUsedError;

  /// Contexte de l'attestation
  @JsonKey(name: '@context')
  List<String> get context => throw _privateConstructorUsedError;

  /// Type de l'attestation
  List<String> get type => throw _privateConstructorUsedError;

  /// Émetteur de la liste de statut
  String get issuer => throw _privateConstructorUsedError;

  /// Date d'émission
  DateTime get issuanceDate => throw _privateConstructorUsedError;

  /// Date d'expiration
  DateTime? get expirationDate => throw _privateConstructorUsedError;

  /// Description de la liste
  String? get description => throw _privateConstructorUsedError;

  /// Sujet de l'attestation (contient les données de la liste)
  StatusList2021Subject get credentialSubject =>
      throw _privateConstructorUsedError;

  /// Preuve cryptographique
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

  /// Identifiant unique de la liste de statut
  @override
  final String id;

  /// Contexte de l'attestation
  final List<String> _context;

  /// Contexte de l'attestation
  @override
  @JsonKey(name: '@context')
  List<String> get context {
    if (_context is EqualUnmodifiableListView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_context);
  }

  /// Type de l'attestation
  final List<String> _type;

  /// Type de l'attestation
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  /// Émetteur de la liste de statut
  @override
  final String issuer;

  /// Date d'émission
  @override
  final DateTime issuanceDate;

  /// Date d'expiration
  @override
  final DateTime? expirationDate;

  /// Description de la liste
  @override
  final String? description;

  /// Sujet de l'attestation (contient les données de la liste)
  @override
  final StatusList2021Subject credentialSubject;

  /// Preuve cryptographique
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

  /// Identifiant unique de la liste de statut
  @override
  String get id;

  /// Contexte de l'attestation
  @override
  @JsonKey(name: '@context')
  List<String> get context;

  /// Type de l'attestation
  @override
  List<String> get type;

  /// Émetteur de la liste de statut
  @override
  String get issuer;

  /// Date d'émission
  @override
  DateTime get issuanceDate;

  /// Date d'expiration
  @override
  DateTime? get expirationDate;

  /// Description de la liste
  @override
  String? get description;

  /// Sujet de l'attestation (contient les données de la liste)
  @override
  StatusList2021Subject get credentialSubject;

  /// Preuve cryptographique
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
  /// ID du sujet
  String get id => throw _privateConstructorUsedError;

  /// Type de la liste de statut
  String get type => throw _privateConstructorUsedError;

  /// But de la liste (révocation, suspension, etc.)
  StatusPurpose get statusPurpose => throw _privateConstructorUsedError;

  /// Encodage utilisé (par défaut base64url)
  String get encoding => throw _privateConstructorUsedError;

  /// Liste encodée des statuts
  String get encodedList => throw _privateConstructorUsedError;

  /// Validité dans le temps
  StatusList2021Validity? get validFrom => throw _privateConstructorUsedError;

  /// Taille de la liste
  int get statusListSize => throw _privateConstructorUsedError;

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
      String encodedList,
      StatusList2021Validity? validFrom,
      int statusListSize});

  $StatusList2021ValidityCopyWith<$Res>? get validFrom;
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
    Object? validFrom = freezed,
    Object? statusListSize = null,
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
      validFrom: freezed == validFrom
          ? _value.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as StatusList2021Validity?,
      statusListSize: null == statusListSize
          ? _value.statusListSize
          : statusListSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of StatusList2021Subject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusList2021ValidityCopyWith<$Res>? get validFrom {
    if (_value.validFrom == null) {
      return null;
    }

    return $StatusList2021ValidityCopyWith<$Res>(_value.validFrom!, (value) {
      return _then(_value.copyWith(validFrom: value) as $Val);
    });
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
      String encodedList,
      StatusList2021Validity? validFrom,
      int statusListSize});

  @override
  $StatusList2021ValidityCopyWith<$Res>? get validFrom;
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
    Object? validFrom = freezed,
    Object? statusListSize = null,
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
      validFrom: freezed == validFrom
          ? _value.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as StatusList2021Validity?,
      statusListSize: null == statusListSize
          ? _value.statusListSize
          : statusListSize // ignore: cast_nullable_to_non_nullable
              as int,
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
      required this.encodedList,
      this.validFrom,
      this.statusListSize = 100000});

  factory _$StatusList2021SubjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusList2021SubjectImplFromJson(json);

  /// ID du sujet
  @override
  final String id;

  /// Type de la liste de statut
  @override
  final String type;

  /// But de la liste (révocation, suspension, etc.)
  @override
  final StatusPurpose statusPurpose;

  /// Encodage utilisé (par défaut base64url)
  @override
  @JsonKey()
  final String encoding;

  /// Liste encodée des statuts
  @override
  final String encodedList;

  /// Validité dans le temps
  @override
  final StatusList2021Validity? validFrom;

  /// Taille de la liste
  @override
  @JsonKey()
  final int statusListSize;

  @override
  String toString() {
    return 'StatusList2021Subject(id: $id, type: $type, statusPurpose: $statusPurpose, encoding: $encoding, encodedList: $encodedList, validFrom: $validFrom, statusListSize: $statusListSize)';
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
                other.encodedList == encodedList) &&
            (identical(other.validFrom, validFrom) ||
                other.validFrom == validFrom) &&
            (identical(other.statusListSize, statusListSize) ||
                other.statusListSize == statusListSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, statusPurpose,
      encoding, encodedList, validFrom, statusListSize);

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
      required final String encodedList,
      final StatusList2021Validity? validFrom,
      final int statusListSize}) = _$StatusList2021SubjectImpl;

  factory _StatusList2021Subject.fromJson(Map<String, dynamic> json) =
      _$StatusList2021SubjectImpl.fromJson;

  /// ID du sujet
  @override
  String get id;

  /// Type de la liste de statut
  @override
  String get type;

  /// But de la liste (révocation, suspension, etc.)
  @override
  StatusPurpose get statusPurpose;

  /// Encodage utilisé (par défaut base64url)
  @override
  String get encoding;

  /// Liste encodée des statuts
  @override
  String get encodedList;

  /// Validité dans le temps
  @override
  StatusList2021Validity? get validFrom;

  /// Taille de la liste
  @override
  int get statusListSize;

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
  /// Type de preuve
  String get type => throw _privateConstructorUsedError;

  /// Date de création
  DateTime get created => throw _privateConstructorUsedError;

  /// Finalité de la vérification
  String get verificationMethod => throw _privateConstructorUsedError;

  /// Finalité de la preuve
  String get proofPurpose => throw _privateConstructorUsedError;

  /// Valeur de la preuve (signature)
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

  /// Type de preuve
  @override
  final String type;

  /// Date de création
  @override
  final DateTime created;

  /// Finalité de la vérification
  @override
  final String verificationMethod;

  /// Finalité de la preuve
  @override
  final String proofPurpose;

  /// Valeur de la preuve (signature)
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

  /// Type de preuve
  @override
  String get type;

  /// Date de création
  @override
  DateTime get created;

  /// Finalité de la vérification
  @override
  String get verificationMethod;

  /// Finalité de la preuve
  @override
  String get proofPurpose;

  /// Valeur de la preuve (signature)
  @override
  String get proofValue;

  /// Create a copy of StatusList2021Proof
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusList2021ProofImplCopyWith<_$StatusList2021ProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusList2021Validity _$StatusList2021ValidityFromJson(
    Map<String, dynamic> json) {
  return _StatusList2021Validity.fromJson(json);
}

/// @nodoc
mixin _$StatusList2021Validity {
  /// Date de début de validité
  DateTime get validFrom => throw _privateConstructorUsedError;

  /// Date de fin de validité
  DateTime? get validUntil => throw _privateConstructorUsedError;

  /// Serializes this StatusList2021Validity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusList2021Validity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusList2021ValidityCopyWith<StatusList2021Validity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusList2021ValidityCopyWith<$Res> {
  factory $StatusList2021ValidityCopyWith(StatusList2021Validity value,
          $Res Function(StatusList2021Validity) then) =
      _$StatusList2021ValidityCopyWithImpl<$Res, StatusList2021Validity>;
  @useResult
  $Res call({DateTime validFrom, DateTime? validUntil});
}

/// @nodoc
class _$StatusList2021ValidityCopyWithImpl<$Res,
        $Val extends StatusList2021Validity>
    implements $StatusList2021ValidityCopyWith<$Res> {
  _$StatusList2021ValidityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusList2021Validity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validFrom = null,
    Object? validUntil = freezed,
  }) {
    return _then(_value.copyWith(
      validFrom: null == validFrom
          ? _value.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusList2021ValidityImplCopyWith<$Res>
    implements $StatusList2021ValidityCopyWith<$Res> {
  factory _$$StatusList2021ValidityImplCopyWith(
          _$StatusList2021ValidityImpl value,
          $Res Function(_$StatusList2021ValidityImpl) then) =
      __$$StatusList2021ValidityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime validFrom, DateTime? validUntil});
}

/// @nodoc
class __$$StatusList2021ValidityImplCopyWithImpl<$Res>
    extends _$StatusList2021ValidityCopyWithImpl<$Res,
        _$StatusList2021ValidityImpl>
    implements _$$StatusList2021ValidityImplCopyWith<$Res> {
  __$$StatusList2021ValidityImplCopyWithImpl(
      _$StatusList2021ValidityImpl _value,
      $Res Function(_$StatusList2021ValidityImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusList2021Validity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validFrom = null,
    Object? validUntil = freezed,
  }) {
    return _then(_$StatusList2021ValidityImpl(
      validFrom: null == validFrom
          ? _value.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusList2021ValidityImpl implements _StatusList2021Validity {
  const _$StatusList2021ValidityImpl(
      {required this.validFrom, this.validUntil});

  factory _$StatusList2021ValidityImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusList2021ValidityImplFromJson(json);

  /// Date de début de validité
  @override
  final DateTime validFrom;

  /// Date de fin de validité
  @override
  final DateTime? validUntil;

  @override
  String toString() {
    return 'StatusList2021Validity(validFrom: $validFrom, validUntil: $validUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusList2021ValidityImpl &&
            (identical(other.validFrom, validFrom) ||
                other.validFrom == validFrom) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, validFrom, validUntil);

  /// Create a copy of StatusList2021Validity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusList2021ValidityImplCopyWith<_$StatusList2021ValidityImpl>
      get copyWith => __$$StatusList2021ValidityImplCopyWithImpl<
          _$StatusList2021ValidityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusList2021ValidityImplToJson(
      this,
    );
  }
}

abstract class _StatusList2021Validity implements StatusList2021Validity {
  const factory _StatusList2021Validity(
      {required final DateTime validFrom,
      final DateTime? validUntil}) = _$StatusList2021ValidityImpl;

  factory _StatusList2021Validity.fromJson(Map<String, dynamic> json) =
      _$StatusList2021ValidityImpl.fromJson;

  /// Date de début de validité
  @override
  DateTime get validFrom;

  /// Date de fin de validité
  @override
  DateTime? get validUntil;

  /// Create a copy of StatusList2021Validity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusList2021ValidityImplCopyWith<_$StatusList2021ValidityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StatusList2021Entry _$StatusList2021EntryFromJson(Map<String, dynamic> json) {
  return _StatusList2021Entry.fromJson(json);
}

/// @nodoc
mixin _$StatusList2021Entry {
  /// ID de l'entrée
  String get id => throw _privateConstructorUsedError;

  /// Type de l'entrée
  String get type => throw _privateConstructorUsedError;

  /// But du statut
  StatusPurpose get statusPurpose => throw _privateConstructorUsedError;

  /// URL de la liste de statut
  String get statusListCredential => throw _privateConstructorUsedError;

  /// Index dans la liste
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
      this.type = 'StatusList2021Entry',
      required this.statusPurpose,
      required this.statusListCredential,
      required this.statusListIndex});

  factory _$StatusList2021EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusList2021EntryImplFromJson(json);

  /// ID de l'entrée
  @override
  final String id;

  /// Type de l'entrée
  @override
  @JsonKey()
  final String type;

  /// But du statut
  @override
  final StatusPurpose statusPurpose;

  /// URL de la liste de statut
  @override
  final String statusListCredential;

  /// Index dans la liste
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

  /// ID de l'entrée
  @override
  String get id;

  /// Type de l'entrée
  @override
  String get type;

  /// But du statut
  @override
  StatusPurpose get statusPurpose;

  /// URL de la liste de statut
  @override
  String get statusListCredential;

  /// Index dans la liste
  @override
  int get statusListIndex;

  /// Create a copy of StatusList2021Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusList2021EntryImplCopyWith<_$StatusList2021EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
