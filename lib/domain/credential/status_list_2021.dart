import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_list_2021.freezed.dart';
part 'status_list_2021.g.dart';

/// StatusList2021Credential est une attestation vérifiable qui contient une liste de statut
/// pour vérifier le statut de révocation d'autres attestations.
@freezed
class StatusList2021Credential with _$StatusList2021Credential {
  const factory StatusList2021Credential({
    /// Identifiant unique de la liste de statut
    required String id,

    /// Contexte de l'attestation
    @JsonKey(name: '@context') required List<String> context,

    /// Type de l'attestation
    required List<String> type,

    /// Émetteur de la liste de statut
    required String issuer,

    /// Date d'émission
    required DateTime issuanceDate,

    /// Date d'expiration
    DateTime? expirationDate,

    /// Description de la liste
    String? description,

    /// Sujet de l'attestation (contient les données de la liste)
    required StatusList2021Subject credentialSubject,

    /// Preuve cryptographique
    required StatusList2021Proof proof,
  }) = _StatusList2021Credential;

  factory StatusList2021Credential.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021CredentialFromJson(json);
}

/// Sujet de l'attestation StatusList2021
@freezed
class StatusList2021Subject with _$StatusList2021Subject {
  const factory StatusList2021Subject({
    /// ID du sujet
    required String id,

    /// Type de la liste de statut
    required String type,

    /// But de la liste (révocation, suspension, etc.)
    required StatusPurpose statusPurpose,

    /// Encodage utilisé (par défaut base64url)
    @Default('base64url') String encoding,

    /// Liste encodée des statuts
    required String encodedList,

    /// Validité dans le temps
    StatusList2021Validity? validFrom,

    /// Taille de la liste
    @Default(100000) int statusListSize,
  }) = _StatusList2021Subject;

  factory StatusList2021Subject.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021SubjectFromJson(json);
}

/// Preuve cryptographique pour StatusList2021
@freezed
class StatusList2021Proof with _$StatusList2021Proof {
  const factory StatusList2021Proof({
    /// Type de preuve
    required String type,

    /// Date de création
    required DateTime created,

    /// Finalité de la vérification
    required String verificationMethod,

    /// Finalité de la preuve
    required String proofPurpose,

    /// Valeur de la preuve (signature)
    required String proofValue,
  }) = _StatusList2021Proof;

  factory StatusList2021Proof.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021ProofFromJson(json);
}

/// Validité temporelle d'une liste de statut
@freezed
class StatusList2021Validity with _$StatusList2021Validity {
  const factory StatusList2021Validity({
    /// Date de début de validité
    required DateTime validFrom,

    /// Date de fin de validité
    DateTime? validUntil,
  }) = _StatusList2021Validity;

  factory StatusList2021Validity.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021ValidityFromJson(json);
}

/// Finalité d'une liste de statut
enum StatusPurpose {
  /// Révocation d'attestations
  @JsonValue('revocation')
  revocation,

  /// Suspension temporaire
  @JsonValue('suspension')
  suspension,
}

/// Entrée de référence de statut pour une attestation vérifiable
@freezed
class StatusList2021Entry with _$StatusList2021Entry {
  const factory StatusList2021Entry({
    /// ID de l'entrée
    required String id,

    /// Type de l'entrée
    @Default('StatusList2021Entry') String type,

    /// But du statut
    required StatusPurpose statusPurpose,

    /// URL de la liste de statut
    required String statusListCredential,

    /// Index dans la liste
    required int statusListIndex,
  }) = _StatusList2021Entry;

  factory StatusList2021Entry.fromJson(Map<String, dynamic> json) =>
      _$StatusList2021EntryFromJson(json);
}
