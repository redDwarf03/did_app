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
  /// Unique identifier for this specific instance of the verification process.
  String get id => throw _privateConstructorUsedError;

  /// The identifier (e.g., DID or blockchain address) of the digital identity
  /// undergoing this verification process.
  String get identityAddress => throw _privateConstructorUsedError;

  /// The overall current status of the verification process. See [VerificationStatus].
  VerificationStatus get status => throw _privateConstructorUsedError;

  /// An ordered list of the individual steps required to complete the verification.
  /// See [VerificationStep].
  List<VerificationStep> get steps => throw _privateConstructorUsedError;

  /// Timestamp indicating when this verification process was initiated.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Timestamp indicating the last time the process state or any of its steps were updated.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// If the status is [VerificationStatus.rejected], this field may contain the reason.
  String? get rejectionReason => throw _privateConstructorUsedError;

  /// Timestamp indicating when the process reached a final state ([completed] or [rejected]).
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// If the process completed successfully ([VerificationStatus.completed]), this may hold
  /// the resulting certificate. See [VerificationCertificate].
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

  /// Unique identifier for this specific instance of the verification process.
  @override
  final String id;

  /// The identifier (e.g., DID or blockchain address) of the digital identity
  /// undergoing this verification process.
  @override
  final String identityAddress;

  /// The overall current status of the verification process. See [VerificationStatus].
  @override
  final VerificationStatus status;

  /// An ordered list of the individual steps required to complete the verification.
  /// See [VerificationStep].
  final List<VerificationStep> _steps;

  /// An ordered list of the individual steps required to complete the verification.
  /// See [VerificationStep].
  @override
  List<VerificationStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Timestamp indicating when this verification process was initiated.
  @override
  final DateTime createdAt;

  /// Timestamp indicating the last time the process state or any of its steps were updated.
  @override
  final DateTime updatedAt;

  /// If the status is [VerificationStatus.rejected], this field may contain the reason.
  @override
  final String? rejectionReason;

  /// Timestamp indicating when the process reached a final state ([completed] or [rejected]).
  @override
  final DateTime? completedAt;

  /// If the process completed successfully ([VerificationStatus.completed]), this may hold
  /// the resulting certificate. See [VerificationCertificate].
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

  /// Unique identifier for this specific instance of the verification process.
  @override
  String get id;

  /// The identifier (e.g., DID or blockchain address) of the digital identity
  /// undergoing this verification process.
  @override
  String get identityAddress;

  /// The overall current status of the verification process. See [VerificationStatus].
  @override
  VerificationStatus get status;

  /// An ordered list of the individual steps required to complete the verification.
  /// See [VerificationStep].
  @override
  List<VerificationStep> get steps;

  /// Timestamp indicating when this verification process was initiated.
  @override
  DateTime get createdAt;

  /// Timestamp indicating the last time the process state or any of its steps were updated.
  @override
  DateTime get updatedAt;

  /// If the status is [VerificationStatus.rejected], this field may contain the reason.
  @override
  String? get rejectionReason;

  /// Timestamp indicating when the process reached a final state ([completed] or [rejected]).
  @override
  DateTime? get completedAt;

  /// If the process completed successfully ([VerificationStatus.completed]), this may hold
  /// the resulting certificate. See [VerificationCertificate].
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
  /// Unique identifier for this specific step instance within the process.
  String get id => throw _privateConstructorUsedError;

  /// The type of verification being performed in this step. See [VerificationStepType].
  VerificationStepType get type => throw _privateConstructorUsedError;

  /// The current status of this individual step. See [VerificationStepStatus].
  VerificationStepStatus get status => throw _privateConstructorUsedError;

  /// The sequential order of this step within the overall [VerificationProcess].
  int get order => throw _privateConstructorUsedError;

  /// A brief description of the purpose or goal of this verification step.
  String get description => throw _privateConstructorUsedError;

  /// Instructions provided to the user on how to complete this step.
  String get instructions => throw _privateConstructorUsedError;

  /// Timestamp indicating the last time the status or data associated with this step was updated.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// If the status is [VerificationStepStatus.rejected], this may contain the reason.
  String? get rejectionReason => throw _privateConstructorUsedError;

  /// Optional list of paths or references to documents uploaded by the user
  /// as evidence for this step (e.g., ID scan, proof of address).
  /// **Note:** Handling these documents must comply with GDPR.
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

  /// Unique identifier for this specific step instance within the process.
  @override
  final String id;

  /// The type of verification being performed in this step. See [VerificationStepType].
  @override
  final VerificationStepType type;

  /// The current status of this individual step. See [VerificationStepStatus].
  @override
  final VerificationStepStatus status;

  /// The sequential order of this step within the overall [VerificationProcess].
  @override
  final int order;

  /// A brief description of the purpose or goal of this verification step.
  @override
  final String description;

  /// Instructions provided to the user on how to complete this step.
  @override
  final String instructions;

  /// Timestamp indicating the last time the status or data associated with this step was updated.
  @override
  final DateTime updatedAt;

  /// If the status is [VerificationStepStatus.rejected], this may contain the reason.
  @override
  final String? rejectionReason;

  /// Optional list of paths or references to documents uploaded by the user
  /// as evidence for this step (e.g., ID scan, proof of address).
  /// **Note:** Handling these documents must comply with GDPR.
  final List<String>? _documentPaths;

  /// Optional list of paths or references to documents uploaded by the user
  /// as evidence for this step (e.g., ID scan, proof of address).
  /// **Note:** Handling these documents must comply with GDPR.
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

  /// Unique identifier for this specific step instance within the process.
  @override
  String get id;

  /// The type of verification being performed in this step. See [VerificationStepType].
  @override
  VerificationStepType get type;

  /// The current status of this individual step. See [VerificationStepStatus].
  @override
  VerificationStepStatus get status;

  /// The sequential order of this step within the overall [VerificationProcess].
  @override
  int get order;

  /// A brief description of the purpose or goal of this verification step.
  @override
  String get description;

  /// Instructions provided to the user on how to complete this step.
  @override
  String get instructions;

  /// Timestamp indicating the last time the status or data associated with this step was updated.
  @override
  DateTime get updatedAt;

  /// If the status is [VerificationStepStatus.rejected], this may contain the reason.
  @override
  String? get rejectionReason;

  /// Optional list of paths or references to documents uploaded by the user
  /// as evidence for this step (e.g., ID scan, proof of address).
  /// **Note:** Handling these documents must comply with GDPR.
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
  /// Unique identifier for this verification certificate.
  String get id => throw _privateConstructorUsedError;

  /// Timestamp indicating when the certificate was issued (i.e., verification completed).
  DateTime get issuedAt => throw _privateConstructorUsedError;

  /// Timestamp indicating when the verification or certificate expires and may need renewal.
  /// (Note: Currently required, but could potentially be made optional depending on use case).
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Identifier of the entity (e.g., verification service provider) that issued the certificate.
  String get issuer => throw _privateConstructorUsedError;

  /// A digital signature from the issuer, ensuring the certificate's authenticity and integrity.
  /// Verification would require the issuer's public key.
  String get signature => throw _privateConstructorUsedError;

  /// The level of assurance achieved through the verification process, aligned with eIDAS standards.
  /// See [EidasLevel] for definitions (Low, Substantial, High).
  /// See: Regulation (EU) No 910/2014.
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

  /// Unique identifier for this verification certificate.
  @override
  final String id;

  /// Timestamp indicating when the certificate was issued (i.e., verification completed).
  @override
  final DateTime issuedAt;

  /// Timestamp indicating when the verification or certificate expires and may need renewal.
  /// (Note: Currently required, but could potentially be made optional depending on use case).
  @override
  final DateTime expiresAt;

  /// Identifier of the entity (e.g., verification service provider) that issued the certificate.
  @override
  final String issuer;

  /// A digital signature from the issuer, ensuring the certificate's authenticity and integrity.
  /// Verification would require the issuer's public key.
  @override
  final String signature;

  /// The level of assurance achieved through the verification process, aligned with eIDAS standards.
  /// See [EidasLevel] for definitions (Low, Substantial, High).
  /// See: Regulation (EU) No 910/2014.
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

  /// Unique identifier for this verification certificate.
  @override
  String get id;

  /// Timestamp indicating when the certificate was issued (i.e., verification completed).
  @override
  DateTime get issuedAt;

  /// Timestamp indicating when the verification or certificate expires and may need renewal.
  /// (Note: Currently required, but could potentially be made optional depending on use case).
  @override
  DateTime get expiresAt;

  /// Identifier of the entity (e.g., verification service provider) that issued the certificate.
  @override
  String get issuer;

  /// A digital signature from the issuer, ensuring the certificate's authenticity and integrity.
  /// Verification would require the issuer's public key.
  @override
  String get signature;

  /// The level of assurance achieved through the verification process, aligned with eIDAS standards.
  /// See [EidasLevel] for definitions (Low, Substantial, High).
  /// See: Regulation (EU) No 910/2014.
  @override
  EidasLevel get eidasLevel;

  /// Create a copy of VerificationCertificate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationCertificateImplCopyWith<_$VerificationCertificateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
