import 'dart:convert';
import 'dart:typed_data';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:flutter/services.dart';

/// Service pour gérer les attestations eIDAS et l'intégration avec l'EUDI Wallet
class EidasCredentialService {
  /// Importe une attestation depuis un fichier JSON compatible eIDAS 2.0
  Future<Credential?> importFromJson(String jsonString) async {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Vérifier que c'est bien un document eIDAS
      final List<dynamic>? context = jsonData['@context'] as List<dynamic>?;
      if (context == null ||
          !context.any((e) => e.toString().contains('eidas'))) {
        throw FormatException('Le document n\'est pas au format eIDAS');
      }

      final eidasCredential = EidasCredential.fromJson(jsonData);
      return eidasCredential.toCredential();
    } catch (e) {
      print('Erreur lors de l\'import: $e');
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
    List<String> newContext = List.from(credential.context);
    if (!newContext
        .contains('https://ec.europa.eu/2023/credentials/eidas/v1')) {
      newContext.add('https://ec.europa.eu/2023/credentials/eidas/v1');
    }

    // Adapter le type si nécessaire
    List<String> newType = List.from(credential.type);
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
      final String jsonString = await _loadSampleEidasCredential();

      return importFromJson(jsonString);
    } catch (e) {
      print('Erreur lors de l\'import depuis EUDI Wallet: $e');
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
}
