import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_repository.dart';
import 'package:flutter/foundation.dart';

/// Implémentation simulée du repository pour les attestations vérifiables
///
/// Cette classe simule la gestion d'attestations vérifiables pour le développement et les tests.
/// Elle sera remplacée par une implémentation réelle utilisant la blockchain Archethic.
class MockCredentialRepository implements CredentialRepository {
  final Map<String, Credential> _storage = {};
  final _credentialsController = StreamController<List<Credential>>.broadcast();

  // Génère des attestations de test
  MockCredentialRepository() {
    _initMockCredentials();
  }

  void _initMockCredentials() {
    final identityCredential = Credential(
      id: '1234-5678-9012-3456',
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://www.w3.org/2018/credentials/identity/v1'
      ],
      type: ['VerifiableCredential', 'IdentityCredential'],
      issuanceDate: DateTime.now().subtract(const Duration(days: 15)),
      issuer: 'did:archethic:government_authority',
      subject: 'did:archethic:user123',
      credentialSubject: {
        'id': 'did:archethic:user123',
        'firstName': 'Jean',
        'lastName': 'Dupont',
        'dateOfBirth': '1980-01-15',
        'nationality': 'France',
        'documentNumber': 'FR12345678',
      },
      expirationDate: DateTime.now().add(const Duration(days: 365 * 5)),
      proof: CredentialProof(
        type: 'ArchethicSignature2023',
        created: DateTime.now().subtract(const Duration(days: 15)),
        verificationMethod: 'did:archethic:government_authority#key-1',
        proofPurpose: 'assertionMethod',
        proofValue:
            'z3JyoALNdX5BoQYJAjZqEJC2Qka1aLxmz2B4c59VX7rFXU9nwxXpQe5jdUfEpyHT5eEnESbQaFMB5zXdJNKQPMiB',
      ),
      status: CredentialStatus(
        id: 'https://example.gov/status/24',
        type: 'CredentialStatusList2021',
      ),
      credentialSchema: CredentialSchema(
        id: 'https://example.gov/schemas/identity/1.0',
        type: 'JsonSchema',
      ),
    );

    final diplomaCredential = Credential(
      id: '2345-6789-0123-4567',
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://www.w3.org/2018/credentials/examples/v1'
      ],
      type: ['VerifiableCredential', 'UniversityDegreeCredential'],
      issuanceDate: DateTime.now().subtract(const Duration(days: 120)),
      issuer: 'did:archethic:university_of_paris',
      subject: 'did:archethic:user123',
      credentialSubject: {
        'id': 'did:archethic:user123',
        'degree': {
          'type': 'Master',
          'name': 'Master of Science',
          'field': 'Computer Science',
        },
        'graduationDate': '2023-06-15',
        'gpa': '3.8',
      },
      expirationDate: null, // Un diplôme n'expire pas
      proof: CredentialProof(
        type: 'ArchethicSignature2023',
        created: DateTime.now().subtract(const Duration(days: 120)),
        verificationMethod: 'did:archethic:university_of_paris#key-1',
        proofPurpose: 'assertionMethod',
        proofValue:
            'z4WYiRBZHZMqf7LuTpLsYU3jnvBVn6Dri6u2yQZV8HB1bU4edXyndjiCFrFvJNpqKTRxzsdJWzdZvnKXJ1rU5VH',
      ),
      status: CredentialStatus(
        id: 'https://university.edu/status/24',
        type: 'CredentialStatusList2021',
      ),
      credentialSchema: CredentialSchema(
        id: 'https://university.edu/schemas/degree/1.0',
        type: 'JsonSchema',
      ),
    );

    final healthCredential = Credential(
      id: '3456-7890-1234-5678',
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://www.w3.org/2018/credentials/health/v1'
      ],
      type: ['VerifiableCredential', 'HealthInsuranceCredential'],
      issuanceDate: DateTime.now().subtract(const Duration(days: 60)),
      issuer: 'did:archethic:national_health_insurance',
      subject: 'did:archethic:user123',
      credentialSubject: {
        'id': 'did:archethic:user123',
        'policyNumber': 'HEALTH123456789',
        'coverageStart':
            DateTime.now().subtract(const Duration(days: 60)).toIso8601String(),
        'coverageEnd':
            DateTime.now().add(const Duration(days: 305)).toIso8601String(),
        'coverageType': 'Full',
        'insuranceProvider': 'National Health System',
      },
      expirationDate: DateTime.now().add(const Duration(days: 305)),
      proof: CredentialProof(
        type: 'ArchethicSignature2023',
        created: DateTime.now().subtract(const Duration(days: 60)),
        verificationMethod: 'did:archethic:national_health_insurance#key-1',
        proofPurpose: 'assertionMethod',
        proofValue:
            'z2W6QkPQSnBnZNXHbKaA9tcXBmwXwCt8HJyXwQKTmZyQnD1UJMU4xYh6NaQjMEttHqbCGKqKrZmxwY5GBe3JQMd',
      ),
      status: CredentialStatus(
        id: 'https://health.gov/status/24',
        type: 'CredentialStatusList2021',
      ),
      credentialSchema: CredentialSchema(
        id: 'https://health.gov/schemas/insurance/1.0',
        type: 'JsonSchema',
      ),
    );

    _storage[identityCredential.id] = identityCredential;
    _storage[diplomaCredential.id] = diplomaCredential;
    _storage[healthCredential.id] = healthCredential;

    _notifyListeners();
  }

  void _notifyListeners() {
    _credentialsController.add(_storage.values.toList());
  }

  @override
  Future<List<Credential>> getCredentials() async {
    // Simule un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));
    return _storage.values.toList();
  }

  @override
  Future<Credential?> getCredentialById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _storage[id];
  }

  @override
  Future<void> saveCredential(Credential credential) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _storage[credential.id] = credential;
    _notifyListeners();
  }

  @override
  Future<void> deleteCredential(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _storage.remove(id);
    _notifyListeners();
  }

  @override
  Future<bool> verifyCredential(Credential credential) async {
    await Future.delayed(const Duration(seconds: 1));

    // Mock de vérification - vérifie la date d'expiration
    if (credential.expirationDate != null &&
        credential.expirationDate!.isBefore(DateTime.now())) {
      return false;
    }

    // Dans un cas réel, on vérifierait la signature cryptographique
    // Mock: 95% de chance que la vérification réussisse
    return Random().nextDouble() <= 0.95;
  }

  @override
  Future<CredentialPresentation> createPresentation({
    required List<Credential> credentials,
    required Map<String, List<String>> selectiveDisclosure,
    String? challenge,
    String? domain,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final disclosedCredentials = <Credential>[];

    for (final credential in credentials) {
      // Crée une nouvelle version de l'attestation avec seulement les attributs demandés
      final disclosedSubject = <String, dynamic>{
        'id': credential.credentialSubject['id'],
      };

      final attributes = selectiveDisclosure[credential.id] ?? [];

      for (final attr in attributes) {
        if (credential.credentialSubject.containsKey(attr)) {
          disclosedSubject[attr] = credential.credentialSubject[attr];
        }
      }

      final disclosedCredential = credential.copyWith(
        credentialSubject: disclosedSubject,
      );

      disclosedCredentials.add(disclosedCredential);
    }

    return CredentialPresentation(
      id: 'presentation-${DateTime.now().millisecondsSinceEpoch}',
      context: ['https://www.w3.org/2018/credentials/v1'],
      type: ['VerifiablePresentation'],
      verifiableCredentials: disclosedCredentials,
      holder: 'did:archethic:user123',
      proof: CredentialProof(
        type: 'ArchethicSignature2023',
        created: DateTime.now(),
        verificationMethod: 'did:archethic:user123#key-1',
        proofPurpose: 'authentication',
        proofValue:
            'z${base64Encode(utf8.encode('mock_signature_for_presentation'))}',
        challenge: challenge,
        domain: domain,
      ),
    );
  }

  @override
  Future<bool> verifyPresentation(CredentialPresentation presentation) async {
    await Future.delayed(const Duration(seconds: 1));

    // Vérification de chaque attestation dans la présentation
    for (final credential in presentation.verifiableCredentials) {
      final isValid = await verifyCredential(credential);
      if (!isValid) return false;
    }

    // Dans un cas réel, on vérifierait la signature de la présentation
    // Mock: 90% de chance que la vérification réussisse
    return Random().nextDouble() <= 0.90;
  }

  @override
  Future<String> sharePresentation(CredentialPresentation presentation) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Dans un cas réel, on génèrerait un QR code ou un lien
    // Mock: retourne une URI encodée en base64
    final presentationJson = jsonEncode({
      'presentation': presentation,
      'timestamp': DateTime.now().toIso8601String(),
    });

    return 'archethic://presentation/${base64Encode(utf8.encode(presentationJson))}';
  }

  @override
  Future<Credential> receiveCredential(String uri) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!uri.startsWith('archethic://credential/')) {
      throw Exception('URI invalide');
    }

    // Simule la réception d'une attestation d'emploi
    final employmentCredential = Credential(
      id: '9876-5432-1098-7654',
      context: [
        'https://www.w3.org/2018/credentials/v1',
        'https://www.w3.org/2018/credentials/examples/v1'
      ],
      type: ['VerifiableCredential', 'EmploymentCredential'],
      issuanceDate: DateTime.now(),
      issuer: 'did:archethic:acme_corporation',
      subject: 'did:archethic:user123',
      credentialSubject: {
        'id': 'did:archethic:user123',
        'employeeId': 'EMP123456',
        'position': 'Senior Developer',
        'department': 'Engineering',
        'startDate': DateTime.now()
            .subtract(const Duration(days: 365))
            .toIso8601String(),
        'employer': {
          'name': 'ACME Corporation',
          'address': '123 Business Street, Paris',
          'registrationNumber': 'REG987654321',
        },
      },
      expirationDate: DateTime.now().add(const Duration(days: 365)),
      proof: CredentialProof(
        type: 'ArchethicSignature2023',
        created: DateTime.now(),
        verificationMethod: 'did:archethic:acme_corporation#key-1',
        proofPurpose: 'assertionMethod',
        proofValue:
            'z3JpoWrt9LhkTZMyBsQkQUqD8TPPoEAKmuRhRQbP4QpN7A4NGtbcLPDF9NT6ugMMwFKrVzrWDF5cNwxhXTbSx4XX',
      ),
      status: CredentialStatus(
        id: 'https://acme.com/status/24',
        type: 'CredentialStatusList2021',
      ),
      credentialSchema: CredentialSchema(
        id: 'https://acme.com/schemas/employment/1.0',
        type: 'JsonSchema',
      ),
    );

    // Ajoute l'attestation reçue au stockage
    _storage[employmentCredential.id] = employmentCredential;
    _notifyListeners();

    return employmentCredential;
  }

  @override
  Future<Map<String, dynamic>> receivePresentationRequest(String uri) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!uri.startsWith('archethic://request/')) {
      throw Exception('URI invalide');
    }

    // Simule une demande de présentation
    return {
      'id': 'request-${DateTime.now().millisecondsSinceEpoch}',
      'type': 'PresentationRequest',
      'verifier': 'did:archethic:service_provider',
      'challenge': 'random_challenge_${Random().nextInt(10000)}',
      'domain': 'https://service-provider.com',
      'requestedCredentials': [
        {
          'type': 'IdentityCredential',
          'attributes': ['firstName', 'lastName', 'dateOfBirth'],
        },
      ],
    };
  }

  @override
  Stream<List<Credential>> watchCredentials() {
    return _credentialsController.stream;
  }

  // Dispose pour libérer les ressources
  void dispose() {
    _credentialsController.close();
  }
}
