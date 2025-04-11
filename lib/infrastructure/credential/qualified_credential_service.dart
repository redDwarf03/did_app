import 'dart:async';
import 'dart:convert';

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/qualified_credential.dart';
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:http/http.dart' as http;

/// Résultat de la vérification d'une attestation
class VerificationResult {

  VerificationResult({
    required this.isValid,
    required this.message,
    this.details,
  });
  final bool isValid;
  final String message;
  final Map<String, dynamic>? details;
}

/// Statut d'un émetteur dans le registre de confiance
class IssuerStatus {
  const IssuerStatus({
    required this.isQualified,
    this.assuranceLevel,
    this.validityPeriod,
  });

  factory IssuerStatus.fromJson(Map<String, dynamic> json) {
    return IssuerStatus(
      isQualified: json['isQualified'] as bool,
      assuranceLevel: json['assuranceLevel'] as String?,
      validityPeriod: json['validityPeriod'] != null
          ? DateTimeRange.fromJson(json['validityPeriod'])
          : null,
    );
  }

  final bool isQualified;
  final String? assuranceLevel;
  final DateTimeRange? validityPeriod;
}

/// Période de validité
class DateTimeRange {
  const DateTimeRange({
    required this.start,
    required this.end,
  });

  factory DateTimeRange.fromJson(Map<String, dynamic> json) {
    return DateTimeRange(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );
  }

  final DateTime start;
  final DateTime end;
}

/// Service pour gérer les attestations qualifiées selon eIDAS 2.0
class QualifiedCredentialService {

  QualifiedCredentialService({
    http.Client? httpClient,
    String? trustRegistryUrl,
    EidasTrustList? trustList,
  })  : _httpClient = httpClient ?? http.Client(),
        _trustRegistryUrl =
            trustRegistryUrl ?? 'https://eu-trust-registry.europa.eu/api/v1',
        _trustList = trustList ?? EidasTrustList.instance;
  final http.Client _httpClient;
  final String _trustRegistryUrl;
  final EidasTrustList _trustList;

  // Cache des vérifications pour améliorer les performances
  final Map<String, IssuerStatus> _issuerStatusCache = {};
  final Map<String, QualifiedTrustService> _trustServiceCache = {};

  /// Vérifie si une attestation est qualifiée selon eIDAS 2.0
  Future<bool> isQualified(Credential credential) async {
    try {
      // 1. Vérifier si l'attestation contient une preuve
      if (credential.proof.isEmpty) return false;

      // 2. Vérifier si l'émetteur est dans le registre de confiance qualifié
      final issuerStatus = await _checkIssuerStatus(credential.issuer);
      if (!issuerStatus.isQualified) return false;

      // 3. Vérifier la validité de la signature
      final signatureValid = await _verifySignature(credential);
      if (!signatureValid) return false;

      // 4. Vérifier si le schéma est conforme aux normes eIDAS
      final schemaValid = _validateEidasSchema(credential);
      if (!schemaValid) return false;

      return true;
    } catch (e) {
      // En cas d'exception, l'attestation n'est pas considérée comme qualifiée
      return false;
    }
  }

  /// Détermine le niveau d'assurance (LoA) d'une attestation qualifiée
  Future<AssuranceLevel> determineAssuranceLevel(Credential credential) async {
    // Si l'attestation n'est pas qualifiée, retourner le niveau bas par défaut
    if (!await isQualified(credential)) {
      return AssuranceLevel.low;
    }

    // Récupérer les informations du service de confiance
    final trustService = await _getTrustService(credential.issuer);
    if (trustService == null) {
      return AssuranceLevel.low;
    }

    // Vérifier si des attributs spécifiques au niveau élevé sont présents
    final hasHighLevelAttributes = _checkHighLevelAttributes(credential);
    if (trustService.assuranceLevel == AssuranceLevel.high &&
        hasHighLevelAttributes) {
      return AssuranceLevel.high;
    }

    // Vérifier les attributs de niveau substantiel
    final hasSubstantialAttributes = _checkSubstantialAttributes(credential);
    if ((trustService.assuranceLevel == AssuranceLevel.high ||
            trustService.assuranceLevel == AssuranceLevel.substantial) &&
        hasSubstantialAttributes) {
      return AssuranceLevel.substantial;
    }

    // Par défaut, retourner le niveau d'assurance du service de confiance
    return trustService.assuranceLevel;
  }

  /// Convertit une attestation en attestation qualifiée
  Future<QualifiedCredential?> qualifyCredential(Credential credential) async {
    // Vérifier si l'attestation peut être qualifiée
    if (!await isQualified(credential)) return null;

    // Récupérer les informations du service de confiance qualifié
    final trustService = await _getTrustService(credential.issuer);
    if (trustService == null) return null;

    // Déterminer le niveau d'assurance réel
    final actualAssuranceLevel = await determineAssuranceLevel(credential);

    return QualifiedCredential(
      credential: credential,
      assuranceLevel: actualAssuranceLevel,
      signatureType: _determineSignatureType(credential),
      qualifiedTrustServiceProviderId: trustService.id,
      certificationDate: trustService.startDate,
      certificationExpiryDate: trustService.endDate,
      certificationCountry: trustService.country,
      qualifiedTrustRegistryUrl: _trustRegistryUrl,
      qualifiedCertificateId: trustService.qualifiedCertificates.isNotEmpty
          ? trustService.qualifiedCertificates.first
          : '',
      qualifiedAttributes: _extractQualifiedAttributes(credential),
      qualifiedProof: credential.proof['proofValue'] as String? ?? '',
    );
  }

  /// Vérifie la conformité d'une attestation qualifiée
  Future<VerificationResult> verifyQualifiedCredential(
      QualifiedCredential qualifiedCredential,) async {
    try {
      // 1. Vérifier l'attestation de base
      final isValidBase = await isQualified(qualifiedCredential.credential);
      if (!isValidBase) {
        return VerificationResult(
          isValid: false,
          message:
              "L'attestation ne répond pas aux critères de qualification eIDAS",
        );
      }

      // 2. Vérifier la validité du certificat qualifié
      final isCertificateValid = await _verifyQualifiedCertificate(
        qualifiedCredential.qualifiedCertificateId,
        qualifiedCredential.qualifiedTrustServiceProviderId,
      );

      if (!isCertificateValid) {
        return VerificationResult(
          isValid: false,
          message: "Le certificat qualifié n'est pas valide ou a expiré",
        );
      }

      // 3. Vérifier la signature qualifiée
      final isSignatureValid = await _verifyQualifiedSignature(
        qualifiedCredential.credential,
        qualifiedCredential.qualifiedProof,
        qualifiedCredential.signatureType,
      );

      if (!isSignatureValid) {
        return VerificationResult(
          isValid: false,
          message: "La signature qualifiée n'est pas valide",
        );
      }

      // 4. Vérifier la période de validité de la certification
      final now = DateTime.now();
      if (now.isAfter(qualifiedCredential.certificationExpiryDate)) {
        return VerificationResult(
          isValid: false,
          message:
              'La certification a expiré le ${_formatDate(qualifiedCredential.certificationExpiryDate)}',
        );
      }

      // 5. Vérifier que la certification n'est pas révoquée
      final isRevoked = await _checkCertificationRevocation(
        qualifiedCredential.qualifiedCertificateId,
      );

      if (isRevoked) {
        return VerificationResult(
          isValid: false,
          message: 'La certification a été révoquée',
        );
      }

      // Tout est valide
      return VerificationResult(
        isValid: true,
        message: 'Attestation qualifiée vérifiée avec succès',
        details: {
          'assuranceLevel': qualifiedCredential.assuranceLevel.toString(),
          'signatureType': qualifiedCredential.signatureType.toString(),
          'country': qualifiedCredential.certificationCountry,
          'provider': qualifiedCredential.qualifiedTrustServiceProviderId,
        },
      );
    } catch (e) {
      return VerificationResult(
        isValid: false,
        message: 'Erreur lors de la vérification: $e',
      );
    }
  }

  /// Synchronise avec le registre européen de services de confiance
  Future<bool> synchronizeTrustList() async {
    try {
      // Effacer les caches
      _issuerStatusCache.clear();
      _trustServiceCache.clear();

      // Synchroniser manuellement avec le registre européen
      final response = await _httpClient.get(
        Uri.parse('$_trustRegistryUrl/trust-list/sync'),
        headers: {'Accept': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Vérifie le statut d'un émetteur dans le registre de confiance
  Future<IssuerStatus> _checkIssuerStatus(String issuer) async {
    // Vérifier le cache
    if (_issuerStatusCache.containsKey(issuer)) {
      return _issuerStatusCache[issuer]!;
    }

    try {
      // Vérifier d'abord dans la liste de confiance locale
      final isTrusted = await _trustList.isIssuerTrusted(issuer);

      if (isTrusted) {
        // Si l'émetteur est de confiance, récupérer les détails
        final response = await _httpClient.get(
          Uri.parse('$_trustRegistryUrl/issuers/$issuer'),
          headers: {'Accept': 'application/json'},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final status = IssuerStatus.fromJson(data);

          // Mettre en cache
          _issuerStatusCache[issuer] = status;
          return status;
        }
      }
    } catch (e) {
      // Loguer l'erreur
    }

    // En cas d'erreur ou si l'émetteur n'est pas trouvé, retourner non qualifié
    const defaultStatus = IssuerStatus(isQualified: false);
    _issuerStatusCache[issuer] = defaultStatus;
    return defaultStatus;
  }

  /// Récupère les informations d'un service de confiance
  Future<QualifiedTrustService?> _getTrustService(String issuer) async {
    // Vérifier le cache
    if (_trustServiceCache.containsKey(issuer)) {
      return _trustServiceCache[issuer]!;
    }

    try {
      // Vérifier d'abord dans la liste de confiance locale
      final isTrusted = await _trustList.isIssuerTrusted(issuer);

      if (isTrusted) {
        // Si l'émetteur est de confiance, récupérer les détails du service
        final response = await _httpClient.get(
          Uri.parse('$_trustRegistryUrl/services/$issuer'),
          headers: {'Accept': 'application/json'},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final service = QualifiedTrustService.fromJson(data);

          // Mettre en cache
          _trustServiceCache[issuer] = service;
          return service;
        }

        // Essayer de construire un service à partir des données disponibles
        try {
          // Récupérer des informations basiques sur l'émetteur
          final issuerResponse = await _httpClient.get(
            Uri.parse('$_trustRegistryUrl/issuers/$issuer'),
            headers: {'Accept': 'application/json'},
          );

          if (issuerResponse.statusCode == 200) {
            final data = json.decode(issuerResponse.body);
            final service = _buildTrustServiceFromBasicData(data, issuer);

            // Mettre en cache
            _trustServiceCache[issuer] = service;
            return service;
          }
        } catch (e) {
          // Ignorer cette erreur et passer à l'approche par défaut
        }

        // Approche par défaut : construire un service avec des valeurs minimales
        final service = _buildDefaultTrustService(issuer);
        _trustServiceCache[issuer] = service;
        return service;
      }
    } catch (e) {
      // Loguer l'erreur
    }

    return null;
  }

  /// Construit un service de confiance à partir des données de base
  QualifiedTrustService _buildTrustServiceFromBasicData(
      Map<String, dynamic> data, String issuerId,) {
    // Déterminer le niveau d'assurance
    var level = AssuranceLevel.low;
    if (data['assuranceLevel'] == 'substantial') {
      level = AssuranceLevel.substantial;
    } else if (data['assuranceLevel'] == 'high') {
      level = AssuranceLevel.high;
    }

    return QualifiedTrustService(
      id: issuerId,
      name: data['name'] ?? 'Unknown Service',
      type: data['type'] ?? 'Unknown Type',
      country: data['country'] ?? 'EU',
      status: data['status'] ?? 'granted',
      startDate: data['startDate'] != null
          ? DateTime.parse(data['startDate'])
          : DateTime.now().subtract(const Duration(days: 365)),
      endDate: data['endDate'] != null
          ? DateTime.parse(data['endDate'])
          : DateTime.now().add(const Duration(days: 365)),
      serviceUrl: data['serviceUrl'] ?? '',
      qualifiedCertificates: data['certificates'] != null
          ? List<String>.from(data['certificates'])
          : [],
      assuranceLevel: level,
    );
  }

  /// Construit un service de confiance par défaut quand aucune donnée n'est disponible
  QualifiedTrustService _buildDefaultTrustService(String issuerId) {
    return QualifiedTrustService(
      id: issuerId,
      name: 'Trust Service for $issuerId',
      type: 'Unknown Type',
      country: 'EU',
      status: 'granted',
      startDate: DateTime.now().subtract(const Duration(days: 365)),
      endDate: DateTime.now().add(const Duration(days: 365)),
      serviceUrl: '',
      qualifiedCertificates: [],
      assuranceLevel: AssuranceLevel.low,
    );
  }

  /// Vérifie la signature d'une attestation
  Future<bool> _verifySignature(Credential credential) async {
    // Vérifier si la preuve existe
    if (credential.proof.isEmpty) return false;

    // Extraire les éléments de la preuve
    final proofType = credential.proof['type'] as String?;
    final proofValue = credential.proof['proofValue'] as String?;
    final verificationMethod =
        credential.proof['verificationMethod'] as String?;

    if (proofType == null || proofValue == null || verificationMethod == null) {
      return false;
    }

    // Vérifier si le type de preuve est conforme à eIDAS
    if (!_isEidasCompliantProofType(proofType)) {
      return false;
    }

    // Dans une implémentation réelle, on vérifierait la signature avec une bibliothèque
    // cryptographique adaptée au type de preuve et à la méthode de vérification
    // Pour cette démo, on simule une vérification réussie

    return true;
  }

  /// Vérifie si le type de preuve est conforme à eIDAS
  bool _isEidasCompliantProofType(String proofType) {
    // Types de preuves reconnus par eIDAS 2.0
    const eidasProofTypes = [
      'EidasSignature2023',
      'EidasSeal2023',
      'Ed25519Signature2020',
      'JsonWebSignature2020',
      'BbsBlsSignature2020', // Signatures ZKP
    ];

    return eidasProofTypes.contains(proofType);
  }

  /// Valide si le schéma de l'attestation est conforme à eIDAS
  bool _validateEidasSchema(Credential credential) {
    // Vérifier si les contextes eIDAS sont présents
    final hasEidasContext = credential.context
        .any((ctx) => ctx.contains('eidas') || ctx.contains('ec.europa.eu'));

    if (!hasEidasContext) return false;

    // Vérifier si les types sont conformes
    const validEidasTypes = [
      'VerifiableCredential',
      'VerifiableId',
      'VerifiableAttestation',
      'VerifiableDiploma',
      'VerifiableAuthorisation',
      'EuropeanIdentityCredential',
    ];

    final hasValidType =
        credential.type.any((type) => validEidasTypes.contains(type));

    if (!hasValidType) return false;

    // Vérifier le schéma si présent
    if (credential.credentialSchema != null) {
      final schemaId = credential.credentialSchema!['id'] as String?;
      final schemaType = credential.credentialSchema!['type'] as String?;

      if (schemaId == null || schemaType == null) {
        return false;
      }

      // Vérifier si le schéma est un schéma reconnu par eIDAS
      final isEuRecognizedSchema = schemaId.contains('ec.europa.eu') ||
          schemaId.contains('eidas') ||
          schemaId.contains('europa.eu');

      if (!isEuRecognizedSchema) {
        return false;
      }
    }

    return true;
  }

  /// Vérifie si une attestation contient des attributs de niveau élevé
  bool _checkHighLevelAttributes(Credential credential) {
    // Attributs nécessaires pour le niveau élevé selon eIDAS
    const highLevelAttributes = [
      'evidenceDocument',
      'subjectPresence',
      'documentPresence',
    ];

    // Vérifier si des preuves d'identité de haut niveau sont présents
    final hasEvidence = credential.credentialSubject.containsKey('evidence');

    if (!hasEvidence) return false;

    // Vérifier si les attributs de preuve de niveau élevé sont présents
    final evidence = credential.credentialSubject['evidence'];

    if (evidence is List && evidence.isNotEmpty && evidence.first is Map) {
      final evidenceMap = evidence.first as Map;

      // Tous les attributs de niveau élevé doivent être présents
      return highLevelAttributes.every(evidenceMap.containsKey);
    }

    return false;
  }

  /// Vérifie si une attestation contient des attributs de niveau substantiel
  bool _checkSubstantialAttributes(Credential credential) {
    // Un minimum d'attributs identifiants sont requis pour le niveau substantiel
    const substantialAttributes = [
      'firstName',
      'lastName',
      'dateOfBirth',
    ];

    // Pour le niveau substantiel, un certain nombre d'attributs doivent être présents
    var attributesFound = 0;

    for (final attr in substantialAttributes) {
      if (credential.credentialSubject.containsKey(attr)) {
        attributesFound++;
      }
    }

    // Au moins 2 attributs identifiants pour le niveau substantiel
    return attributesFound >= 2;
  }

  /// Détermine le type de signature qualifiée
  QualifiedSignatureType _determineSignatureType(Credential credential) {
    final proofType = credential.proof['type'] as String?;

    if (proofType == null) return QualifiedSignatureType.qes;

    if (proofType.contains('Seal')) {
      return QualifiedSignatureType.qeseal;
    } else if (proofType.contains('Wac') || proofType.contains('Web')) {
      return QualifiedSignatureType.qwac;
    }

    return QualifiedSignatureType.qes;
  }

  /// Extrait les attributs qualifiés d'une attestation
  Map<String, dynamic> _extractQualifiedAttributes(Credential credential) {
    final result = <String, dynamic>{};

    // Attributs d'identité de base
    final identityAttributes = [
      'firstName',
      'lastName',
      'dateOfBirth',
      'placeOfBirth',
      'currentAddress',
      'gender',
      'nationality',
    ];

    for (final attr in identityAttributes) {
      if (credential.credentialSubject.containsKey(attr)) {
        result[attr] = credential.credentialSubject[attr];
      }
    }

    // Ajouter les attributs d'évidence si présents
    if (credential.credentialSubject.containsKey('evidence')) {
      result['evidence'] = credential.credentialSubject['evidence'];
    }

    return result;
  }

  /// Vérifie la validité d'un certificat qualifié
  Future<bool> _verifyQualifiedCertificate(
      String certificateId, String providerId,) async {
    try {
      // Vérifier dans le registre de confiance
      final response = await _httpClient.get(
        Uri.parse('$_trustRegistryUrl/certificates/$certificateId'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Vérifier si le certificat appartient au bon prestataire
        if (data['providerId'] != providerId) {
          return false;
        }

        // Vérifier la validité
        final isValid = data['isValid'] as bool? ?? false;
        final isRevoked = data['isRevoked'] as bool? ?? false;

        // Vérifier les dates de validité
        final notBefore = data['notBefore'] != null
            ? DateTime.parse(data['notBefore'])
            : null;
        final notAfter =
            data['notAfter'] != null ? DateTime.parse(data['notAfter']) : null;

        final now = DateTime.now();

        if (notBefore != null && now.isBefore(notBefore)) {
          return false;
        }

        if (notAfter != null && now.isAfter(notAfter)) {
          return false;
        }

        return isValid && !isRevoked;
      }
    } catch (e) {
      // Loguer l'erreur
    }

    // Par défaut, considérer le certificat comme non vérifié
    return false;
  }

  /// Vérifie une signature qualifiée
  Future<bool> _verifyQualifiedSignature(Credential credential,
      String qualifiedProof, QualifiedSignatureType signatureType,) async {
    // Dans une implémentation réelle, on vérifierait la signature avec le bon algorithme
    // selon le type de signature qualifiée (QES, QESeal, QWAC)

    // Pour cette démo, on simule une vérification réussie
    return true;
  }

  /// Vérifie si un certificat a été révoqué
  Future<bool> _checkCertificationRevocation(String certificateId) async {
    try {
      // Vérifier dans le service de révocation
      final response = await _httpClient.get(
        Uri.parse('$_trustRegistryUrl/revocation/$certificateId'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['isRevoked'] as bool? ?? false;
      }
    } catch (e) {
      // Loguer l'erreur
    }

    // En cas d'erreur, considérer que le certificat n'est pas révoqué
    return false;
  }

  /// Formate une date en chaîne lisible
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
