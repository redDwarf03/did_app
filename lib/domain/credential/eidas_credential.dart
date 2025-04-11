import 'package:did_app/domain/credential/credential.dart';

/// Format de données pour les attestations conformes à eIDAS 2.0
class EidasCredential {
  EidasCredential({
    required this.id,
    required this.type,
    required this.issuer,
    required this.issuanceDate,
    required this.credentialSubject,
    this.expirationDate,
    this.credentialSchema,
    this.credentialStatus,
    this.proof,
    this.evidence,
  });

  /// Identifiant unique de l'attestation
  final String id;

  /// Type de l'attestation selon eIDAS 2.0
  final List<String> type;

  /// Émetteur de l'attestation (conforme à la norme eIDAS)
  final EidasIssuer issuer;

  /// Date d'émission
  final DateTime issuanceDate;

  /// Date d'expiration
  final DateTime? expirationDate;

  /// Sujet de l'attestation
  final Map<String, dynamic> credentialSubject;

  /// Schéma de l'attestation
  final EidasCredentialSchema? credentialSchema;

  /// Statut de l'attestation (révocation)
  final EidasCredentialStatus? credentialStatus;

  /// Preuve cryptographique
  final EidasProof? proof;

  /// Preuves d'identité utilisées pour délivrer l'attestation
  final List<EidasEvidence>? evidence;

  /// Convertit l'attestation eIDAS en attestation standard de l'application
  Credential toCredential() {
    return Credential(
      id: id,
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://ec.europa.eu/2023/credentials/eidas/v1'
      ],
      type: type,
      issuanceDate: issuanceDate,
      issuer: issuer.id,
      subject: credentialSubject['id'] as String? ?? '',
      credentialSubject: credentialSubject,
      expirationDate: expirationDate,
      proof: proof?.toCredentialProof(),
      status: credentialStatus?.toCredentialStatus(),
      credentialSchema: credentialSchema?.toCredentialSchema(),
      name: _getReadableName(),
      claims: credentialSubject,
      supportsZkp:
          true, // Les attestations eIDAS 2.0 supportent nativement les ZKP
    );
  }

  /// Crée une attestation eIDAS à partir d'une attestation standard
  static EidasCredential fromCredential(Credential credential) {
    return EidasCredential(
      id: credential.id,
      type: credential.type,
      issuer: EidasIssuer(
        id: credential.issuer,
        name: '', // À remplir si disponible
        image: '', // À remplir si disponible
      ),
      issuanceDate: credential.issuanceDate,
      expirationDate: credential.expirationDate,
      credentialSubject: credential.credentialSubject,
      credentialSchema: credential.credentialSchema != null
          ? EidasCredentialSchema.fromCredentialSchema(
              credential.credentialSchema!)
          : null,
      credentialStatus: credential.status != null
          ? EidasCredentialStatus.fromCredentialStatus(credential.status!)
          : null,
      proof: credential.proof != null
          ? EidasProof.fromCredentialProof(credential.proof!)
          : null,
    );
  }

  /// Retourne un nom lisible pour l'attestation
  String _getReadableName() {
    if (type.contains('VerifiableId')) {
      return 'Identité numérique eIDAS';
    } else if (type.contains('VerifiableAttestation')) {
      return 'Attestation vérifiable eIDAS';
    } else if (type.contains('VerifiableDiploma')) {
      return 'Diplôme vérifiable';
    } else if (type.contains('VerifiableAuthorisation')) {
      return 'Autorisation eIDAS';
    }
    return type.join(', ');
  }

  /// Convertit l'attestation eIDAS en JSON
  Map<String, dynamic> toJson() {
    return {
      '@context': [
        'https://www.w3.org/2018/credentials/v1',
        'https://ec.europa.eu/2023/credentials/eidas/v1'
      ],
      'id': id,
      'type': type,
      'issuer': issuer.toJson(),
      'issuanceDate': issuanceDate.toIso8601String(),
      if (expirationDate != null)
        'expirationDate': expirationDate!.toIso8601String(),
      'credentialSubject': credentialSubject,
      if (credentialSchema != null)
        'credentialSchema': credentialSchema!.toJson(),
      if (credentialStatus != null)
        'credentialStatus': credentialStatus!.toJson(),
      if (proof != null) 'proof': proof!.toJson(),
      if (evidence != null)
        'evidence': evidence!.map((e) => e.toJson()).toList(),
    };
  }

  /// Crée une attestation eIDAS à partir d'un JSON
  factory EidasCredential.fromJson(Map<String, dynamic> json) {
    return EidasCredential(
      id: json['id'] as String,
      type: (json['type'] as List).map((e) => e as String).toList(),
      issuer: EidasIssuer.fromJson(json['issuer']),
      issuanceDate: DateTime.parse(json['issuanceDate'] as String),
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'] as String)
          : null,
      credentialSubject: json['credentialSubject'] as Map<String, dynamic>,
      credentialSchema: json['credentialSchema'] != null
          ? EidasCredentialSchema.fromJson(
              json['credentialSchema'] as Map<String, dynamic>)
          : null,
      credentialStatus: json['credentialStatus'] != null
          ? EidasCredentialStatus.fromJson(
              json['credentialStatus'] as Map<String, dynamic>)
          : null,
      proof: json['proof'] != null
          ? EidasProof.fromJson(json['proof'] as Map<String, dynamic>)
          : null,
      evidence: json['evidence'] != null
          ? (json['evidence'] as List)
              .map((e) => EidasEvidence.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

/// Représente l'émetteur d'une attestation eIDAS
class EidasIssuer {
  EidasIssuer({
    required this.id,
    this.name,
    this.image,
    this.url,
    this.organizationType,
    this.registrationNumber,
    this.address,
  });

  /// Identifiant de l'émetteur (DID)
  final String id;

  /// Nom de l'émetteur
  final String? name;

  /// URL vers l'image/logo de l'émetteur
  final String? image;

  /// Site web de l'émetteur
  final String? url;

  /// Type d'organisation (gouvernement, entreprise, etc.)
  final String? organizationType;

  /// Numéro d'enregistrement de l'organisation
  final String? registrationNumber;

  /// Adresse de l'émetteur
  final Map<String, dynamic>? address;

  /// Convertit l'émetteur en JSON
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'id': id,
    };

    if (name != null) result['name'] = name;
    if (image != null) result['image'] = image;
    if (url != null) result['url'] = url;
    if (organizationType != null) result['organizationType'] = organizationType;
    if (registrationNumber != null)
      result['registrationNumber'] = registrationNumber;
    if (address != null) result['address'] = address;

    return result;
  }

  /// Crée un émetteur à partir d'un JSON
  factory EidasIssuer.fromJson(dynamic json) {
    if (json is String) {
      return EidasIssuer(id: json);
    }

    if (json is Map<String, dynamic>) {
      return EidasIssuer(
        id: json['id'] as String,
        name: json['name'] as String?,
        image: json['image'] as String?,
        url: json['url'] as String?,
        organizationType: json['organizationType'] as String?,
        registrationNumber: json['registrationNumber'] as String?,
        address: json['address'] as Map<String, dynamic>?,
      );
    }

    throw FormatException('Format d\'émetteur non pris en charge: $json');
  }
}

/// Représente le schéma d'une attestation eIDAS
class EidasCredentialSchema {
  EidasCredentialSchema({
    required this.id,
    required this.type,
  });

  /// Identifiant du schéma
  final String id;

  /// Type de schéma
  final String type;

  /// Convertit le schéma en CredentialSchema
  CredentialSchema toCredentialSchema() {
    return CredentialSchema(
      id: id,
      type: type,
    );
  }

  /// Crée un schéma eIDAS à partir d'un CredentialSchema
  static EidasCredentialSchema fromCredentialSchema(CredentialSchema schema) {
    return EidasCredentialSchema(
      id: schema.id,
      type: schema.type,
    );
  }

  /// Convertit le schéma en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }

  /// Crée un schéma à partir d'un JSON
  factory EidasCredentialSchema.fromJson(Map<String, dynamic> json) {
    return EidasCredentialSchema(
      id: json['id'] as String,
      type: json['type'] as String,
    );
  }
}

/// Représente le statut d'une attestation eIDAS
class EidasCredentialStatus {
  EidasCredentialStatus({
    required this.id,
    required this.type,
    this.statusPurpose,
    this.statusListIndex,
    this.statusListCredential,
  });

  /// Identifiant du statut
  final String id;

  /// Type de statut
  final String type;

  /// Objectif du statut (ex: revocation)
  final String? statusPurpose;

  /// Index dans la liste de statuts
  final int? statusListIndex;

  /// Attestation contenant la liste de statuts
  final String? statusListCredential;

  /// Convertit le statut en CredentialStatus
  CredentialStatus toCredentialStatus() {
    return CredentialStatus(
      id: id,
      type: type,
      revoked: statusPurpose == 'revocation',
    );
  }

  /// Crée un statut eIDAS à partir d'un CredentialStatus
  static EidasCredentialStatus fromCredentialStatus(CredentialStatus status) {
    return EidasCredentialStatus(
      id: status.id,
      type: status.type,
      statusPurpose: status.revoked ? 'revocation' : null,
    );
  }

  /// Convertit le statut en JSON
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'id': id,
      'type': type,
    };

    if (statusPurpose != null) result['statusPurpose'] = statusPurpose;
    if (statusListIndex != null) result['statusListIndex'] = statusListIndex;
    if (statusListCredential != null)
      result['statusListCredential'] = statusListCredential;

    return result;
  }

  /// Crée un statut à partir d'un JSON
  factory EidasCredentialStatus.fromJson(Map<String, dynamic> json) {
    return EidasCredentialStatus(
      id: json['id'] as String,
      type: json['type'] as String,
      statusPurpose: json['statusPurpose'] as String?,
      statusListIndex: json['statusListIndex'] as int?,
      statusListCredential: json['statusListCredential'] as String?,
    );
  }
}

/// Représente une preuve cryptographique eIDAS
class EidasProof {
  EidasProof({
    required this.type,
    required this.created,
    required this.verificationMethod,
    required this.proofPurpose,
    required this.proofValue,
    this.challenge,
    this.domain,
    this.jws,
  });

  /// Type de preuve
  final String type;

  /// Date de création
  final DateTime created;

  /// Méthode de vérification
  final String verificationMethod;

  /// Objectif de la preuve
  final String proofPurpose;

  /// Valeur de la preuve (signature)
  final String proofValue;

  /// Challenge pour la preuve
  final String? challenge;

  /// Domaine de la preuve
  final String? domain;

  /// Signature au format JWS
  final String? jws;

  /// Convertit la preuve en CredentialProof
  CredentialProof toCredentialProof() {
    return CredentialProof(
      type: type,
      created: created,
      verificationMethod: verificationMethod,
      proofPurpose: proofPurpose,
      proofValue: proofValue,
      challenge: challenge,
      domain: domain,
    );
  }

  /// Crée une preuve eIDAS à partir d'une CredentialProof
  static EidasProof fromCredentialProof(CredentialProof proof) {
    return EidasProof(
      type: proof.type,
      created: proof.created,
      verificationMethod: proof.verificationMethod,
      proofPurpose: proof.proofPurpose,
      proofValue: proof.proofValue,
      challenge: proof.challenge,
      domain: proof.domain,
    );
  }

  /// Convertit la preuve en JSON
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'type': type,
      'created': created.toIso8601String(),
      'verificationMethod': verificationMethod,
      'proofPurpose': proofPurpose,
      'proofValue': proofValue,
    };

    if (challenge != null) result['challenge'] = challenge;
    if (domain != null) result['domain'] = domain;
    if (jws != null) result['jws'] = jws;

    return result;
  }

  /// Crée une preuve à partir d'un JSON
  factory EidasProof.fromJson(Map<String, dynamic> json) {
    return EidasProof(
      type: json['type'] as String,
      created: DateTime.parse(json['created'] as String),
      verificationMethod: json['verificationMethod'] as String,
      proofPurpose: json['proofPurpose'] as String,
      proofValue: json['proofValue'] as String,
      challenge: json['challenge'] as String?,
      domain: json['domain'] as String?,
      jws: json['jws'] as String?,
    );
  }
}

/// Représente une preuve d'identité utilisée pour délivrer l'attestation
class EidasEvidence {
  EidasEvidence({
    required this.type,
    required this.verifier,
    this.evidenceDocument,
    this.subjectPresence,
    this.documentPresence,
    this.time,
  });

  /// Type de preuve d'identité
  final String type;

  /// Vérificateur de l'identité
  final String verifier;

  /// Document utilisé comme preuve
  final List<String>? evidenceDocument;

  /// Type de présence du sujet (physique, à distance)
  final String? subjectPresence;

  /// Type de présence du document (physique, numérique)
  final String? documentPresence;

  /// Date de vérification
  final DateTime? time;

  /// Convertit la preuve d'identité en JSON
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'type': type,
      'verifier': verifier,
    };

    if (evidenceDocument != null) result['evidenceDocument'] = evidenceDocument;
    if (subjectPresence != null) result['subjectPresence'] = subjectPresence;
    if (documentPresence != null) result['documentPresence'] = documentPresence;
    if (time != null) result['time'] = time!.toIso8601String();

    return result;
  }

  /// Crée une preuve d'identité à partir d'un JSON
  factory EidasEvidence.fromJson(Map<String, dynamic> json) {
    return EidasEvidence(
      type: json['type'] as String,
      verifier: json['verifier'] as String,
      evidenceDocument: json['evidenceDocument'] != null
          ? (json['evidenceDocument'] as List).map((e) => e as String).toList()
          : null,
      subjectPresence: json['subjectPresence'] as String?,
      documentPresence: json['documentPresence'] as String?,
      time:
          json['time'] != null ? DateTime.parse(json['time'] as String) : null,
    );
  }
}
