import 'dart:convert';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';

/// Service pour gérer les attestations eIDAS et l'intégration avec l'EUDI Wallet
class EidasCredentialService {
  /// Importe une attestation depuis un fichier JSON compatible eIDAS 2.0
  Future<Credential?> importFromJson(String jsonString) async {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Vérifier que c'est bien un document eIDAS
      final context = jsonData['@context'] as List<dynamic>?;
      if (context == null ||
          !context.any((e) => e.toString().contains('eidas'))) {
        throw const FormatException("Le document n'est pas au format eIDAS");
      }

      final eidasCredential = EidasCredential.fromJson(jsonData);
      return eidasCredential.toCredential();
    } catch (e) {
      print("Erreur lors de l'import: $e");
      return null;
    }
  }

  /// Exporte une attestation au format JSON compatible eIDAS 2.0
  Future<String> exportToJson(Credential credential) async {
    final eidasCredential = EidasCredential.fromCredential(credential);
    return jsonEncode(eidasCredential.toJson());
  }

  /// Vérifie si une attestation est compatible avec la norme eIDAS 2.0
  bool isEidasCompatible(Credential credential) {
    if (credential.context.any((e) => e.contains('eidas'))) {
      return true;
    }

    // Types d'attestations compatibles avec eIDAS
    const eidasTypes = [
      'IdentityCredential',
      'VerifiableId',
      'VerifiableAttestation',
      'VerifiableDiploma',
      'VerifiableAuthorisation',
    ];

    return credential.type
        .any((type) => eidasTypes.any((eidasType) => type.contains(eidasType)));
  }

  /// Convertit une attestation pour la rendre compatible eIDAS
  Future<Credential> makeEidasCompatible(Credential credential) async {
    if (isEidasCompatible(credential)) {
      return credential;
    }

    // Ajouter les contextes eIDAS
    final newContext = List<String>.from(credential.context);
    if (!newContext
        .contains('https://ec.europa.eu/2023/credentials/eidas/v1')) {
      newContext.add('https://ec.europa.eu/2023/credentials/eidas/v1');
    }

    // Adapter le type si nécessaire
    final newType = List<String>.from(credential.type);
    if (credential.type.contains('IdentityCredential')) {
      if (!newType.contains('VerifiableId')) {
        newType.add('VerifiableId');
      }
    } else if (newType.contains('UniversityDegreeCredential')) {
      if (!newType.contains('VerifiableDiploma')) {
        newType.add('VerifiableDiploma');
      }
    } else if (!newType.contains('VerifiableAttestation')) {
      newType.add('VerifiableAttestation');
    }

    return credential.copyWith(
      context: newContext,
      type: newType,
    );
  }

  /// Partage une attestation avec l'EUDI Wallet
  Future<bool> shareWithEudiWallet(Credential credential) async {
    try {
      // Rendre l'attestation compatible eIDAS
      final eidasCredential = await makeEidasCompatible(credential);

      // Exporter au format JSON
      final jsonString = await exportToJson(eidasCredential);

      // Dans une implémentation réelle, on utiliserait les API du système
      // pour partager avec l'application EUDI Wallet
      // Ici on simule juste un succès

      return true;
    } catch (e) {
      print('Erreur lors du partage avec EUDI Wallet: $e');
      return false;
    }
  }

  /// Importe une attestation depuis l'EUDI Wallet
  /// Cette fonction est simulée car l'interface réelle dépend des API natives
  Future<Credential?> importFromEudiWallet() async {
    try {
      // Dans une implémentation réelle, on lancerait une intent/activité
      // pour demander à l'EUDI Wallet de partager une attestation

      // Simulation: charger un exemple de credential eIDAS
      final jsonString = await _loadSampleEidasCredential();

      return importFromJson(jsonString);
    } catch (e) {
      print("Erreur lors de l'import depuis EUDI Wallet: $e");
      return null;
    }
  }

  /// Charge un exemple d'attestation eIDAS depuis les assets (pour la démo)
  Future<String> _loadSampleEidasCredential() async {
    // Dans une application réelle, cela viendrait de l'EUDI Wallet
    return '''
    {
      "@context": [
        "https://www.w3.org/2018/credentials/v1",
        "https://ec.europa.eu/2023/credentials/eidas/v1"
      ],
      "id": "https://example.com/credentials/3732",
      "type": ["VerifiableCredential", "VerifiableId"],
      "issuer": {
        "id": "did:example:28394728934792387",
        "name": "Ministère de l'Intérieur",
        "organizationType": "Government"
      },
      "issuanceDate": "2023-06-15T16:30:00Z",
      "expirationDate": "2028-06-15T16:30:00Z",
      "credentialSubject": {
        "id": "did:example:3456345634563456",
        "firstName": "Jean",
        "lastName": "Dupont",
        "dateOfBirth": "1990-01-01",
        "placeOfBirth": "Paris, France",
        "currentAddress": {
          "streetAddress": "123 Rue Exemple",
          "postalCode": "75001",
          "locality": "Paris",
          "countryName": "France"
        },
        "gender": "M",
        "nationality": "FR"
      },
      "credentialSchema": {
        "id": "https://ec.europa.eu/schemas/eidas/pid/2023/v1",
        "type": "JsonSchema"
      },
      "evidence": [
        {
          "type": "DocumentVerification",
          "verifier": "did:example:government-verification-service",
          "evidenceDocument": ["Passport"],
          "subjectPresence": "Physical",
          "documentPresence": "Physical",
          "time": "2023-06-15T12:00:00Z"
        }
      ],
      "proof": {
        "type": "Ed25519Signature2020",
        "created": "2023-06-15T16:30:00Z",
        "verificationMethod": "did:example:28394728934792387#key-1",
        "proofPurpose": "assertionMethod",
        "proofValue": "z58DAdFfa9SkqZMVPxAQpic7ndSayn1PzZs6ZjWp1CktyGesjuTdwCBZf5DZXd3rSJ3YV72id3w5zdjEzv74xnGx"
      }
    }
    ''';
  }

  /// Vérifie la signature cryptographique d'une attestation eIDAS
  Future<VerificationResult> verifyEidasCredential(
      EidasCredential credential,) async {
    try {
      // Vérifier que le document contient une preuve
      if (credential.proof == null) {
        return VerificationResult(
          isValid: false,
          message: "L'attestation ne contient pas de preuve cryptographique",
        );
      }

      // Vérifier la date d'expiration
      final now = DateTime.now();
      if (credential.expirationDate != null &&
          credential.expirationDate!.isBefore(now)) {
        return VerificationResult(
          isValid: false,
          message:
              "L'attestation a expiré le ${_formatDate(credential.expirationDate)}",
        );
      }

      // Dans une implémentation réelle, cette fonction :
      // 1. Extrairait la clé publique de l'émetteur à partir de son DID
      // 2. Vérifierait la signature numérique avec cette clé
      // 3. Validerait le statut de révocation de l'attestation

      // Pour cette démo, on simule une vérification réussie
      await Future.delayed(
          const Duration(seconds: 1),); // Simuler le temps de vérification

      return VerificationResult(
        isValid: true,
        message: 'Attestation vérifiée avec succès',
        details: {
          'issuer': credential.issuer.id,
          'issuanceDate': _formatDate(credential.issuanceDate),
          'verificationMethod': credential.proof?.verificationMethod,
          'proofType': credential.proof?.type,
        },
      );
    } catch (e) {
      return VerificationResult(
        isValid: false,
        message: 'Erreur lors de la vérification: $e',
      );
    }
  }

  /// Vérifie le statut de révocation d'une attestation eIDAS
  Future<RevocationStatus> checkRevocationStatus(
      EidasCredential credential,) async {
    try {
      // Vérifier que le document contient un statut
      if (credential.credentialStatus == null) {
        return RevocationStatus(
          isRevoked: false,
          message: 'Aucune information de statut disponible',
          lastChecked: DateTime.now(),
        );
      }

      // Dans une implémentation réelle, cette fonction :
      // 1. Extrairait l'URL du service de statut
      // 2. Interrogerait ce service pour vérifier si l'attestation a été révoquée
      // 3. Analyserait la réponse pour déterminer le statut

      // Pour cette démo, on simule une vérification réussie (non révoquée)
      await Future.delayed(const Duration(
          milliseconds: 800,),); // Simuler le temps de vérification

      return RevocationStatus(
        isRevoked: false,
        message: 'Attestation non révoquée',
        lastChecked: DateTime.now(),
        details: {
          'statusType': credential.credentialStatus?.type,
          'statusId': credential.credentialStatus?.id,
        },
      );
    } catch (e) {
      return RevocationStatus(
        isRevoked: true,
        message: 'Erreur lors de la vérification du statut: $e',
        lastChecked: DateTime.now(),
      );
    }
  }

  /// Génère une signature eIDAS pour une attestation
  Future<EidasProof> generateEidasSignature(
      Map<String, dynamic> credentialData,) async {
    // Dans une implémentation réelle, on utiliserait une cryptographie conforme à eIDAS
    // comme Ed25519Signature2020 ou EcdsaSecp256k1Signature2019

    final now = DateTime.now();

    return EidasProof(
      type: 'Ed25519Signature2020',
      created: now,
      verificationMethod: 'did:example:app-wallet#key-1',
      proofPurpose: 'assertionMethod',
      proofValue: 'z${_generateRandomSignature(64)}',
    );
  }

  /// Génère une valeur aléatoire simulant une signature (pour la démo)
  String _generateRandomSignature(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    final buffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      final index = (random + i) % chars.length;
      buffer.write(chars[index]);
    }

    return buffer.toString();
  }

  /// Formate une date pour l'affichage
  String _formatDate(DateTime? date) {
    if (date == null) return 'Non spécifiée';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

/// Modèle de résultat de vérification
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

/// Modèle de statut de révocation
class RevocationStatus {

  RevocationStatus({
    required this.isRevoked,
    required this.message,
    required this.lastChecked,
    this.details,
  });
  final bool isRevoked;
  final String message;
  final DateTime lastChecked;
  final Map<String, dynamic>? details;
}
