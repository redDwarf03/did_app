// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eidas_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EidasState _$EidasStateFromJson(Map<String, dynamic> json) {
  return _EidasState.fromJson(json);
}

/// @nodoc
mixin _$EidasState {
  /// Indicates if an eIDAS-related operation is currently in progress.
  bool get isLoading => throw _privateConstructorUsedError;

  /// Holds a potential error message from the last eIDAS operation.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Indicates if the EUDI Wallet application is detected as available on the device.
  /// (Currently simulated).
  bool get isEudiWalletAvailable => throw _privateConstructorUsedError;

  /// Stores the result of the last eIDAS credential verification attempt.
  /// Uses the domain VerificationResult model.
  VerificationResult? get verificationResult =>
      throw _privateConstructorUsedError;

  /// Stores the revocation status checked during the last verification.
  /// Uses the local RevocationStatus from the infrastructure service, accessed via prefix.
  RevocationStatus? get revocationStatus => throw _privateConstructorUsedError;

  /// Timestamp of the last successful synchronization with the EU Trust Registry.
  DateTime? get lastSyncDate => throw _privateConstructorUsedError;

  /// A report summarizing the current state of the local Trust List cache.
  Map<String, dynamic>? get trustListReport =>
      throw _privateConstructorUsedError;

  /// A report summarizing interoperability status based on the Trust List.
  Map<String, dynamic>? get interoperabilityReport =>
      throw _privateConstructorUsedError;

  /// The current list of trusted issuers, potentially filtered by country or trust level.
  List<TrustedIssuer> get trustedIssuers => throw _privateConstructorUsedError;

  /// The trust level currently selected for filtering issuers (e.g., Qualified).
  TrustLevel? get selectedTrustLevel => throw _privateConstructorUsedError;

  /// The country code currently selected for filtering issuers (e.g., 'FR', 'DE').
  String? get selectedCountry => throw _privateConstructorUsedError;

  /// Serializes this EidasState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EidasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EidasStateCopyWith<EidasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EidasStateCopyWith<$Res> {
  factory $EidasStateCopyWith(
          EidasState value, $Res Function(EidasState) then) =
      _$EidasStateCopyWithImpl<$Res, EidasState>;
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      bool isEudiWalletAvailable,
      VerificationResult? verificationResult,
      RevocationStatus? revocationStatus,
      DateTime? lastSyncDate,
      Map<String, dynamic>? trustListReport,
      Map<String, dynamic>? interoperabilityReport,
      List<TrustedIssuer> trustedIssuers,
      TrustLevel? selectedTrustLevel,
      String? selectedCountry});

  $VerificationResultCopyWith<$Res>? get verificationResult;
  $RevocationStatusCopyWith<$Res>? get revocationStatus;
}

/// @nodoc
class _$EidasStateCopyWithImpl<$Res, $Val extends EidasState>
    implements $EidasStateCopyWith<$Res> {
  _$EidasStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EidasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isEudiWalletAvailable = null,
    Object? verificationResult = freezed,
    Object? revocationStatus = freezed,
    Object? lastSyncDate = freezed,
    Object? trustListReport = freezed,
    Object? interoperabilityReport = freezed,
    Object? trustedIssuers = null,
    Object? selectedTrustLevel = freezed,
    Object? selectedCountry = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isEudiWalletAvailable: null == isEudiWalletAvailable
          ? _value.isEudiWalletAvailable
          : isEudiWalletAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationResult: freezed == verificationResult
          ? _value.verificationResult
          : verificationResult // ignore: cast_nullable_to_non_nullable
              as VerificationResult?,
      revocationStatus: freezed == revocationStatus
          ? _value.revocationStatus
          : revocationStatus // ignore: cast_nullable_to_non_nullable
              as RevocationStatus?,
      lastSyncDate: freezed == lastSyncDate
          ? _value.lastSyncDate
          : lastSyncDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trustListReport: freezed == trustListReport
          ? _value.trustListReport
          : trustListReport // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      interoperabilityReport: freezed == interoperabilityReport
          ? _value.interoperabilityReport
          : interoperabilityReport // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      trustedIssuers: null == trustedIssuers
          ? _value.trustedIssuers
          : trustedIssuers // ignore: cast_nullable_to_non_nullable
              as List<TrustedIssuer>,
      selectedTrustLevel: freezed == selectedTrustLevel
          ? _value.selectedTrustLevel
          : selectedTrustLevel // ignore: cast_nullable_to_non_nullable
              as TrustLevel?,
      selectedCountry: freezed == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of EidasState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerificationResultCopyWith<$Res>? get verificationResult {
    if (_value.verificationResult == null) {
      return null;
    }

    return $VerificationResultCopyWith<$Res>(_value.verificationResult!,
        (value) {
      return _then(_value.copyWith(verificationResult: value) as $Val);
    });
  }

  /// Create a copy of EidasState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RevocationStatusCopyWith<$Res>? get revocationStatus {
    if (_value.revocationStatus == null) {
      return null;
    }

    return $RevocationStatusCopyWith<$Res>(_value.revocationStatus!, (value) {
      return _then(_value.copyWith(revocationStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EidasStateImplCopyWith<$Res>
    implements $EidasStateCopyWith<$Res> {
  factory _$$EidasStateImplCopyWith(
          _$EidasStateImpl value, $Res Function(_$EidasStateImpl) then) =
      __$$EidasStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      bool isEudiWalletAvailable,
      VerificationResult? verificationResult,
      RevocationStatus? revocationStatus,
      DateTime? lastSyncDate,
      Map<String, dynamic>? trustListReport,
      Map<String, dynamic>? interoperabilityReport,
      List<TrustedIssuer> trustedIssuers,
      TrustLevel? selectedTrustLevel,
      String? selectedCountry});

  @override
  $VerificationResultCopyWith<$Res>? get verificationResult;
  @override
  $RevocationStatusCopyWith<$Res>? get revocationStatus;
}

/// @nodoc
class __$$EidasStateImplCopyWithImpl<$Res>
    extends _$EidasStateCopyWithImpl<$Res, _$EidasStateImpl>
    implements _$$EidasStateImplCopyWith<$Res> {
  __$$EidasStateImplCopyWithImpl(
      _$EidasStateImpl _value, $Res Function(_$EidasStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EidasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isEudiWalletAvailable = null,
    Object? verificationResult = freezed,
    Object? revocationStatus = freezed,
    Object? lastSyncDate = freezed,
    Object? trustListReport = freezed,
    Object? interoperabilityReport = freezed,
    Object? trustedIssuers = null,
    Object? selectedTrustLevel = freezed,
    Object? selectedCountry = freezed,
  }) {
    return _then(_$EidasStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isEudiWalletAvailable: null == isEudiWalletAvailable
          ? _value.isEudiWalletAvailable
          : isEudiWalletAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationResult: freezed == verificationResult
          ? _value.verificationResult
          : verificationResult // ignore: cast_nullable_to_non_nullable
              as VerificationResult?,
      revocationStatus: freezed == revocationStatus
          ? _value.revocationStatus
          : revocationStatus // ignore: cast_nullable_to_non_nullable
              as RevocationStatus?,
      lastSyncDate: freezed == lastSyncDate
          ? _value.lastSyncDate
          : lastSyncDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trustListReport: freezed == trustListReport
          ? _value._trustListReport
          : trustListReport // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      interoperabilityReport: freezed == interoperabilityReport
          ? _value._interoperabilityReport
          : interoperabilityReport // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      trustedIssuers: null == trustedIssuers
          ? _value._trustedIssuers
          : trustedIssuers // ignore: cast_nullable_to_non_nullable
              as List<TrustedIssuer>,
      selectedTrustLevel: freezed == selectedTrustLevel
          ? _value.selectedTrustLevel
          : selectedTrustLevel // ignore: cast_nullable_to_non_nullable
              as TrustLevel?,
      selectedCountry: freezed == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EidasStateImpl extends _EidasState {
  const _$EidasStateImpl(
      {this.isLoading = false,
      this.errorMessage,
      this.isEudiWalletAvailable = false,
      this.verificationResult,
      this.revocationStatus,
      this.lastSyncDate,
      final Map<String, dynamic>? trustListReport,
      final Map<String, dynamic>? interoperabilityReport,
      final List<TrustedIssuer> trustedIssuers = const [],
      this.selectedTrustLevel,
      this.selectedCountry})
      : _trustListReport = trustListReport,
        _interoperabilityReport = interoperabilityReport,
        _trustedIssuers = trustedIssuers,
        super._();

  factory _$EidasStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EidasStateImplFromJson(json);

  /// Indicates if an eIDAS-related operation is currently in progress.
  @override
  @JsonKey()
  final bool isLoading;

  /// Holds a potential error message from the last eIDAS operation.
  @override
  final String? errorMessage;

  /// Indicates if the EUDI Wallet application is detected as available on the device.
  /// (Currently simulated).
  @override
  @JsonKey()
  final bool isEudiWalletAvailable;

  /// Stores the result of the last eIDAS credential verification attempt.
  /// Uses the domain VerificationResult model.
  @override
  final VerificationResult? verificationResult;

  /// Stores the revocation status checked during the last verification.
  /// Uses the local RevocationStatus from the infrastructure service, accessed via prefix.
  @override
  final RevocationStatus? revocationStatus;

  /// Timestamp of the last successful synchronization with the EU Trust Registry.
  @override
  final DateTime? lastSyncDate;

  /// A report summarizing the current state of the local Trust List cache.
  final Map<String, dynamic>? _trustListReport;

  /// A report summarizing the current state of the local Trust List cache.
  @override
  Map<String, dynamic>? get trustListReport {
    final value = _trustListReport;
    if (value == null) return null;
    if (_trustListReport is EqualUnmodifiableMapView) return _trustListReport;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// A report summarizing interoperability status based on the Trust List.
  final Map<String, dynamic>? _interoperabilityReport;

  /// A report summarizing interoperability status based on the Trust List.
  @override
  Map<String, dynamic>? get interoperabilityReport {
    final value = _interoperabilityReport;
    if (value == null) return null;
    if (_interoperabilityReport is EqualUnmodifiableMapView)
      return _interoperabilityReport;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// The current list of trusted issuers, potentially filtered by country or trust level.
  final List<TrustedIssuer> _trustedIssuers;

  /// The current list of trusted issuers, potentially filtered by country or trust level.
  @override
  @JsonKey()
  List<TrustedIssuer> get trustedIssuers {
    if (_trustedIssuers is EqualUnmodifiableListView) return _trustedIssuers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trustedIssuers);
  }

  /// The trust level currently selected for filtering issuers (e.g., Qualified).
  @override
  final TrustLevel? selectedTrustLevel;

  /// The country code currently selected for filtering issuers (e.g., 'FR', 'DE').
  @override
  final String? selectedCountry;

  @override
  String toString() {
    return 'EidasState(isLoading: $isLoading, errorMessage: $errorMessage, isEudiWalletAvailable: $isEudiWalletAvailable, verificationResult: $verificationResult, revocationStatus: $revocationStatus, lastSyncDate: $lastSyncDate, trustListReport: $trustListReport, interoperabilityReport: $interoperabilityReport, trustedIssuers: $trustedIssuers, selectedTrustLevel: $selectedTrustLevel, selectedCountry: $selectedCountry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EidasStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isEudiWalletAvailable, isEudiWalletAvailable) ||
                other.isEudiWalletAvailable == isEudiWalletAvailable) &&
            (identical(other.verificationResult, verificationResult) ||
                other.verificationResult == verificationResult) &&
            (identical(other.revocationStatus, revocationStatus) ||
                other.revocationStatus == revocationStatus) &&
            (identical(other.lastSyncDate, lastSyncDate) ||
                other.lastSyncDate == lastSyncDate) &&
            const DeepCollectionEquality()
                .equals(other._trustListReport, _trustListReport) &&
            const DeepCollectionEquality().equals(
                other._interoperabilityReport, _interoperabilityReport) &&
            const DeepCollectionEquality()
                .equals(other._trustedIssuers, _trustedIssuers) &&
            (identical(other.selectedTrustLevel, selectedTrustLevel) ||
                other.selectedTrustLevel == selectedTrustLevel) &&
            (identical(other.selectedCountry, selectedCountry) ||
                other.selectedCountry == selectedCountry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      errorMessage,
      isEudiWalletAvailable,
      verificationResult,
      revocationStatus,
      lastSyncDate,
      const DeepCollectionEquality().hash(_trustListReport),
      const DeepCollectionEquality().hash(_interoperabilityReport),
      const DeepCollectionEquality().hash(_trustedIssuers),
      selectedTrustLevel,
      selectedCountry);

  /// Create a copy of EidasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EidasStateImplCopyWith<_$EidasStateImpl> get copyWith =>
      __$$EidasStateImplCopyWithImpl<_$EidasStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EidasStateImplToJson(
      this,
    );
  }
}

abstract class _EidasState extends EidasState {
  const factory _EidasState(
      {final bool isLoading,
      final String? errorMessage,
      final bool isEudiWalletAvailable,
      final VerificationResult? verificationResult,
      final RevocationStatus? revocationStatus,
      final DateTime? lastSyncDate,
      final Map<String, dynamic>? trustListReport,
      final Map<String, dynamic>? interoperabilityReport,
      final List<TrustedIssuer> trustedIssuers,
      final TrustLevel? selectedTrustLevel,
      final String? selectedCountry}) = _$EidasStateImpl;
  const _EidasState._() : super._();

  factory _EidasState.fromJson(Map<String, dynamic> json) =
      _$EidasStateImpl.fromJson;

  /// Indicates if an eIDAS-related operation is currently in progress.
  @override
  bool get isLoading;

  /// Holds a potential error message from the last eIDAS operation.
  @override
  String? get errorMessage;

  /// Indicates if the EUDI Wallet application is detected as available on the device.
  /// (Currently simulated).
  @override
  bool get isEudiWalletAvailable;

  /// Stores the result of the last eIDAS credential verification attempt.
  /// Uses the domain VerificationResult model.
  @override
  VerificationResult? get verificationResult;

  /// Stores the revocation status checked during the last verification.
  /// Uses the local RevocationStatus from the infrastructure service, accessed via prefix.
  @override
  RevocationStatus? get revocationStatus;

  /// Timestamp of the last successful synchronization with the EU Trust Registry.
  @override
  DateTime? get lastSyncDate;

  /// A report summarizing the current state of the local Trust List cache.
  @override
  Map<String, dynamic>? get trustListReport;

  /// A report summarizing interoperability status based on the Trust List.
  @override
  Map<String, dynamic>? get interoperabilityReport;

  /// The current list of trusted issuers, potentially filtered by country or trust level.
  @override
  List<TrustedIssuer> get trustedIssuers;

  /// The trust level currently selected for filtering issuers (e.g., Qualified).
  @override
  TrustLevel? get selectedTrustLevel;

  /// The country code currently selected for filtering issuers (e.g., 'FR', 'DE').
  @override
  String? get selectedCountry;

  /// Create a copy of EidasState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EidasStateImplCopyWith<_$EidasStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
