// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_process.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerificationProcess _$VerificationProcessFromJson(Map<String, dynamic> json) {
  return _VerificationProcess.fromJson(json);
}

/// @nodoc
mixin _$VerificationProcess {
  /// Unique identifier for the verification process
  String get id => throw _privateConstructorUsedError;

  /// Address of the identity being verified
  String get identityAddress => throw _privateConstructorUsedError;

  /// Current status of the verification
  VerificationStatus get status => throw _privateConstructorUsedError;

  /// List of verification steps required
  List<VerificationStep> get steps => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Rejection reason if the verification was rejected
  String? get rejectionReason => throw _privateConstructorUsedError;

  /// Timestamp when the verification was completed
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Certificate data if fully verified
  VerificationCertificate? get certificate =>
      throw _privateConstructorUsedError;

  /// Serializes this VerificationProcess to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerificationProcess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationProcessCopyWith<VerificationProcess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationProcessCopyWith<$Res> {
  factory $VerificationProcessCopyWith(
          VerificationProcess value, $Res Function(VerificationProcess) then) =
      _$VerificationProcessCopyWithImpl<$Res, VerificationProcess>;
  @useResult
  $Res call(
      {String id,
      String identityAddress,
      VerificationStatus status,
      List<VerificationStep> steps,
      DateTime createdAt,
      DateTime updatedAt,
      String? rejectionReason,
      DateTime? completedAt,
      VerificationCertificate? certificate});

  $VerificationCertificateCopyWith<$Res>? get certificate;
}

/// @nodoc
class _$VerificationProcessCopyWithImpl<$Res, $Val extends VerificationProcess>
    implements $VerificationProcessCopyWith<$Res> {
  _$VerificationProcessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationProcess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? identityAddress = null,
    Object? status = null,
    Object? steps = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? rejectionReason = freezed,
    Object? completedAt = freezed,
    Object? certificate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      identityAddress: null == identityAddress
          ? _value.identityAddress
          : identityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<VerificationStep>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      certificate: freezed == certificate
          ? _value.certificate
          : certificate // ignore: cast_nullable_to_non_nullable
              as VerificationCertificate?,
    ) as $Val);
  }

  /// Create a copy of VerificationProcess
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerificationCertificateCopyWith<$Res>? get certificate {
    if (_value.certificate == null) {
      return null;
    }

    return $VerificationCertificateCopyWith<$Res>(_value.certificate!, (value) {
      return _then(_value.copyWith(certificate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerificationProcessImplCopyWith<$Res>
    implements $VerificationProcessCopyWith<$Res> {
  factory _$$VerificationProcessImplCopyWith(_$VerificationProcessImpl value,
          $Res Function(_$VerificationProcessImpl) then) =
      __$$VerificationProcessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String identityAddress,
      VerificationStatus status,
      List<VerificationStep> steps,
      DateTime createdAt,
      DateTime updatedAt,
      String? rejectionReason,
      DateTime? completedAt,
      VerificationCertificate? certificate});

  @override
  $VerificationCertificateCopyWith<$Res>? get certificate;
}

/// @nodoc
class __$$VerificationProcessImplCopyWithImpl<$Res>
    extends _$VerificationProcessCopyWithImpl<$Res, _$VerificationProcessImpl>
    implements _$$VerificationProcessImplCopyWith<$Res> {
  __$$VerificationProcessImplCopyWithImpl(_$VerificationProcessImpl _value,
      $Res Function(_$VerificationProcessImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationProcess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? identityAddress = null,
    Object? status = null,
    Object? steps = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? rejectionReason = freezed,
    Object? completedAt = freezed,
    Object? certificate = freezed,
  }) {
    return _then(_$VerificationProcessImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      identityAddress: null == identityAddress
          ? _value.identityAddress
          : identityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<VerificationStep>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      certificate: freezed == certificate
          ? _value.certificate
          : certificate // ignore: cast_nullable_to_non_nullable
              as VerificationCertificate?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationProcessImpl implements _VerificationProcess {
  const _$VerificationProcessImpl(
      {required this.id,
      required this.identityAddress,
      required this.status,
      required final List<VerificationStep> steps,
      required this.createdAt,
      required this.updatedAt,
      this.rejectionReason,
      this.completedAt,
      this.certificate})
      : _steps = steps;

  factory _$VerificationProcessImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationProcessImplFromJson(json);

  /// Unique identifier for the verification process
  @override
  final String id;

  /// Address of the identity being verified
  @override
  final String identityAddress;

  /// Current status of the verification
  @override
  final VerificationStatus status;

  /// List of verification steps required
  final List<VerificationStep> _steps;

  /// List of verification steps required
  @override
  List<VerificationStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Creation timestamp
  @override
  final DateTime createdAt;

  /// Last update timestamp
  @override
  final DateTime updatedAt;

  /// Rejection reason if the verification was rejected
  @override
  final String? rejectionReason;

  /// Timestamp when the verification was completed
  @override
  final DateTime? completedAt;

  /// Certificate data if fully verified
  @override
  final VerificationCertificate? certificate;

  @override
  String toString() {
    return 'VerificationProcess(id: $id, identityAddress: $identityAddress, status: $status, steps: $steps, createdAt: $createdAt, updatedAt: $updatedAt, rejectionReason: $rejectionReason, completedAt: $completedAt, certificate: $certificate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationProcessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.identityAddress, identityAddress) ||
                other.identityAddress == identityAddress) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.certificate, certificate) ||
                other.certificate == certificate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      identityAddress,
      status,
      const DeepCollectionEquality().hash(_steps),
      createdAt,
      updatedAt,
      rejectionReason,
      completedAt,
      certificate);

  /// Create a copy of VerificationProcess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationProcessImplCopyWith<_$VerificationProcessImpl> get copyWith =>
      __$$VerificationProcessImplCopyWithImpl<_$VerificationProcessImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationProcessImplToJson(
      this,
    );
  }
}

abstract class _VerificationProcess implements VerificationProcess {
  const factory _VerificationProcess(
      {required final String id,
      required final String identityAddress,
      required final VerificationStatus status,
      required final List<VerificationStep> steps,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? rejectionReason,
      final DateTime? completedAt,
      final VerificationCertificate? certificate}) = _$VerificationProcessImpl;

  factory _VerificationProcess.fromJson(Map<String, dynamic> json) =
      _$VerificationProcessImpl.fromJson;

  /// Unique identifier for the verification process
  @override
  String get id;

  /// Address of the identity being verified
  @override
  String get identityAddress;

  /// Current status of the verification
  @override
  VerificationStatus get status;

  /// List of verification steps required
  @override
  List<VerificationStep> get steps;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Last update timestamp
  @override
  DateTime get updatedAt;

  /// Rejection reason if the verification was rejected
  @override
  String? get rejectionReason;

  /// Timestamp when the verification was completed
  @override
  DateTime? get completedAt;

  /// Certificate data if fully verified
  @override
  VerificationCertificate? get certificate;

  /// Create a copy of VerificationProcess
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationProcessImplCopyWith<_$VerificationProcessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerificationStep _$VerificationStepFromJson(Map<String, dynamic> json) {
  return _VerificationStep.fromJson(json);
}

/// @nodoc
mixin _$VerificationStep {
  /// Unique identifier for this step
  String get id => throw _privateConstructorUsedError;

  /// Type of verification step
  VerificationStepType get type => throw _privateConstructorUsedError;

  /// Current status of this step
  VerificationStepStatus get status => throw _privateConstructorUsedError;

  /// Order of this step in the verification process
  int get order => throw _privateConstructorUsedError;

  /// Description of what this step verifies
  String get description => throw _privateConstructorUsedError;

  /// Instructions for the user
  String get instructions => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Rejection reason if this step was rejected
  String? get rejectionReason => throw _privateConstructorUsedError;

  /// Paths to uploaded documents or proofs if applicable
  List<String>? get documentPaths => throw _privateConstructorUsedError;

  /// Serializes this VerificationStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerificationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationStepCopyWith<VerificationStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStepCopyWith<$Res> {
  factory $VerificationStepCopyWith(
          VerificationStep value, $Res Function(VerificationStep) then) =
      _$VerificationStepCopyWithImpl<$Res, VerificationStep>;
  @useResult
  $Res call(
      {String id,
      VerificationStepType type,
      VerificationStepStatus status,
      int order,
      String description,
      String instructions,
      DateTime updatedAt,
      String? rejectionReason,
      List<String>? documentPaths});
}

/// @nodoc
class _$VerificationStepCopyWithImpl<$Res, $Val extends VerificationStep>
    implements $VerificationStepCopyWith<$Res> {
  _$VerificationStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? order = null,
    Object? description = null,
    Object? instructions = null,
    Object? updatedAt = null,
    Object? rejectionReason = freezed,
    Object? documentPaths = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VerificationStepType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationStepStatus,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      documentPaths: freezed == documentPaths
          ? _value.documentPaths
          : documentPaths // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationStepImplCopyWith<$Res>
    implements $VerificationStepCopyWith<$Res> {
  factory _$$VerificationStepImplCopyWith(_$VerificationStepImpl value,
          $Res Function(_$VerificationStepImpl) then) =
      __$$VerificationStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      VerificationStepType type,
      VerificationStepStatus status,
      int order,
      String description,
      String instructions,
      DateTime updatedAt,
      String? rejectionReason,
      List<String>? documentPaths});
}

/// @nodoc
class __$$VerificationStepImplCopyWithImpl<$Res>
    extends _$VerificationStepCopyWithImpl<$Res, _$VerificationStepImpl>
    implements _$$VerificationStepImplCopyWith<$Res> {
  __$$VerificationStepImplCopyWithImpl(_$VerificationStepImpl _value,
      $Res Function(_$VerificationStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? order = null,
    Object? description = null,
    Object? instructions = null,
    Object? updatedAt = null,
    Object? rejectionReason = freezed,
    Object? documentPaths = freezed,
  }) {
    return _then(_$VerificationStepImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VerificationStepType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationStepStatus,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      documentPaths: freezed == documentPaths
          ? _value._documentPaths
          : documentPaths // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationStepImpl implements _VerificationStep {
  const _$VerificationStepImpl(
      {required this.id,
      required this.type,
      required this.status,
      required this.order,
      required this.description,
      required this.instructions,
      required this.updatedAt,
      this.rejectionReason,
      final List<String>? documentPaths})
      : _documentPaths = documentPaths;

  factory _$VerificationStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationStepImplFromJson(json);

  /// Unique identifier for this step
  @override
  final String id;

  /// Type of verification step
  @override
  final VerificationStepType type;

  /// Current status of this step
  @override
  final VerificationStepStatus status;

  /// Order of this step in the verification process
  @override
  final int order;

  /// Description of what this step verifies
  @override
  final String description;

  /// Instructions for the user
  @override
  final String instructions;

  /// Last update timestamp
  @override
  final DateTime updatedAt;

  /// Rejection reason if this step was rejected
  @override
  final String? rejectionReason;

  /// Paths to uploaded documents or proofs if applicable
  final List<String>? _documentPaths;

  /// Paths to uploaded documents or proofs if applicable
  @override
  List<String>? get documentPaths {
    final value = _documentPaths;
    if (value == null) return null;
    if (_documentPaths is EqualUnmodifiableListView) return _documentPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'VerificationStep(id: $id, type: $type, status: $status, order: $order, description: $description, instructions: $instructions, updatedAt: $updatedAt, rejectionReason: $rejectionReason, documentPaths: $documentPaths)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            const DeepCollectionEquality()
                .equals(other._documentPaths, _documentPaths));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      status,
      order,
      description,
      instructions,
      updatedAt,
      rejectionReason,
      const DeepCollectionEquality().hash(_documentPaths));

  /// Create a copy of VerificationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationStepImplCopyWith<_$VerificationStepImpl> get copyWith =>
      __$$VerificationStepImplCopyWithImpl<_$VerificationStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationStepImplToJson(
      this,
    );
  }
}

abstract class _VerificationStep implements VerificationStep {
  const factory _VerificationStep(
      {required final String id,
      required final VerificationStepType type,
      required final VerificationStepStatus status,
      required final int order,
      required final String description,
      required final String instructions,
      required final DateTime updatedAt,
      final String? rejectionReason,
      final List<String>? documentPaths}) = _$VerificationStepImpl;

  factory _VerificationStep.fromJson(Map<String, dynamic> json) =
      _$VerificationStepImpl.fromJson;

  /// Unique identifier for this step
  @override
  String get id;

  /// Type of verification step
  @override
  VerificationStepType get type;

  /// Current status of this step
  @override
  VerificationStepStatus get status;

  /// Order of this step in the verification process
  @override
  int get order;

  /// Description of what this step verifies
  @override
  String get description;

  /// Instructions for the user
  @override
  String get instructions;

  /// Last update timestamp
  @override
  DateTime get updatedAt;

  /// Rejection reason if this step was rejected
  @override
  String? get rejectionReason;

  /// Paths to uploaded documents or proofs if applicable
  @override
  List<String>? get documentPaths;

  /// Create a copy of VerificationStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationStepImplCopyWith<_$VerificationStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerificationCertificate _$VerificationCertificateFromJson(
    Map<String, dynamic> json) {
  return _VerificationCertificate.fromJson(json);
}

/// @nodoc
mixin _$VerificationCertificate {
  /// Unique identifier for this certificate
  String get id => throw _privateConstructorUsedError;

  /// Timestamp when the certificate was issued
  DateTime get issuedAt => throw _privateConstructorUsedError;

  /// Timestamp when the certificate expires
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Issuer of the certificate
  String get issuer => throw _privateConstructorUsedError;

  /// Digital signature of the issuer
  String get signature => throw _privateConstructorUsedError;

  /// eIDAS compliance level
  EidasLevel get eidasLevel => throw _privateConstructorUsedError;

  /// Serializes this VerificationCertificate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerificationCertificate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationCertificateCopyWith<VerificationCertificate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationCertificateCopyWith<$Res> {
  factory $VerificationCertificateCopyWith(VerificationCertificate value,
          $Res Function(VerificationCertificate) then) =
      _$VerificationCertificateCopyWithImpl<$Res, VerificationCertificate>;
  @useResult
  $Res call(
      {String id,
      DateTime issuedAt,
      DateTime expiresAt,
      String issuer,
      String signature,
      EidasLevel eidasLevel});
}

/// @nodoc
class _$VerificationCertificateCopyWithImpl<$Res,
        $Val extends VerificationCertificate>
    implements $VerificationCertificateCopyWith<$Res> {
  _$VerificationCertificateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationCertificate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? issuedAt = null,
    Object? expiresAt = null,
    Object? issuer = null,
    Object? signature = null,
    Object? eidasLevel = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      eidasLevel: null == eidasLevel
          ? _value.eidasLevel
          : eidasLevel // ignore: cast_nullable_to_non_nullable
              as EidasLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationCertificateImplCopyWith<$Res>
    implements $VerificationCertificateCopyWith<$Res> {
  factory _$$VerificationCertificateImplCopyWith(
          _$VerificationCertificateImpl value,
          $Res Function(_$VerificationCertificateImpl) then) =
      __$$VerificationCertificateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime issuedAt,
      DateTime expiresAt,
      String issuer,
      String signature,
      EidasLevel eidasLevel});
}

/// @nodoc
class __$$VerificationCertificateImplCopyWithImpl<$Res>
    extends _$VerificationCertificateCopyWithImpl<$Res,
        _$VerificationCertificateImpl>
    implements _$$VerificationCertificateImplCopyWith<$Res> {
  __$$VerificationCertificateImplCopyWithImpl(
      _$VerificationCertificateImpl _value,
      $Res Function(_$VerificationCertificateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationCertificate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? issuedAt = null,
    Object? expiresAt = null,
    Object? issuer = null,
    Object? signature = null,
    Object? eidasLevel = null,
  }) {
    return _then(_$VerificationCertificateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      issuer: null == issuer
          ? _value.issuer
          : issuer // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      eidasLevel: null == eidasLevel
          ? _value.eidasLevel
          : eidasLevel // ignore: cast_nullable_to_non_nullable
              as EidasLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationCertificateImpl implements _VerificationCertificate {
  const _$VerificationCertificateImpl(
      {required this.id,
      required this.issuedAt,
      required this.expiresAt,
      required this.issuer,
      required this.signature,
      this.eidasLevel = EidasLevel.low});

  factory _$VerificationCertificateImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationCertificateImplFromJson(json);

  /// Unique identifier for this certificate
  @override
  final String id;

  /// Timestamp when the certificate was issued
  @override
  final DateTime issuedAt;

  /// Timestamp when the certificate expires
  @override
  final DateTime expiresAt;

  /// Issuer of the certificate
  @override
  final String issuer;

  /// Digital signature of the issuer
  @override
  final String signature;

  /// eIDAS compliance level
  @override
  @JsonKey()
  final EidasLevel eidasLevel;

  @override
  String toString() {
    return 'VerificationCertificate(id: $id, issuedAt: $issuedAt, expiresAt: $expiresAt, issuer: $issuer, signature: $signature, eidasLevel: $eidasLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationCertificateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.eidasLevel, eidasLevel) ||
                other.eidasLevel == eidasLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, issuedAt, expiresAt, issuer, signature, eidasLevel);

  /// Create a copy of VerificationCertificate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationCertificateImplCopyWith<_$VerificationCertificateImpl>
      get copyWith => __$$VerificationCertificateImplCopyWithImpl<
          _$VerificationCertificateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationCertificateImplToJson(
      this,
    );
  }
}

abstract class _VerificationCertificate implements VerificationCertificate {
  const factory _VerificationCertificate(
      {required final String id,
      required final DateTime issuedAt,
      required final DateTime expiresAt,
      required final String issuer,
      required final String signature,
      final EidasLevel eidasLevel}) = _$VerificationCertificateImpl;

  factory _VerificationCertificate.fromJson(Map<String, dynamic> json) =
      _$VerificationCertificateImpl.fromJson;

  /// Unique identifier for this certificate
  @override
  String get id;

  /// Timestamp when the certificate was issued
  @override
  DateTime get issuedAt;

  /// Timestamp when the certificate expires
  @override
  DateTime get expiresAt;

  /// Issuer of the certificate
  @override
  String get issuer;

  /// Digital signature of the issuer
  @override
  String get signature;

  /// eIDAS compliance level
  @override
  EidasLevel get eidasLevel;

  /// Create a copy of VerificationCertificate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationCertificateImplCopyWith<_$VerificationCertificateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
