import 'dart:async';
import 'dart:math';

import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_repository.dart';
import 'package:uuid/uuid.dart';

/// Implémentation simulée du repository pour les attestations vérifiables
///
/// Cette classe simule la gestion d'attestations vérifiables pour le développement et les tests.
/// Elle sera remplacée par une implémentation réelle utilisant la blockchain Archethic.
class MockCredentialRepository implements CredentialRepository {
  final Map<String, Credential> _credentials = {};
  final Map<String, List<String>> _credentialsByIdentity = {};
  final Map<String, CredentialPresentation> _presentations = {};
  final Map<String, String> _presentationLinks = {};

  final _uuid = const Uuid();
  final _random = Random.secure();

  // Liste d'exemples d'attestations pour la démo
  final List<Map<String, dynamic>> _sampleCredentials = [
    {
      'type': CredentialType.identity,
      'name': 'Carte d\'identité nationale',
      'description': 'Attestation d\'identité officielle',
      'issuer': 'Ministère de l\'Intérieur',
      'issuerId': 'did:archethic:government',
      'schemaId': 'schema:gov:identity:1.0',
      'claims': {
        'firstName': 'Jean',
        'lastName': 'Dupont',
        'dateOfBirth': '1985-04-12',
        'placeOfBirth': 'Paris',
        'nationality': 'Française',
        'gender': 'M',
        'idNumber': 'FR123456789',
      },
      'supportsZkp': true,
    },
    {
      'type': CredentialType.diploma,
      'name': 'Diplôme d\'ingénieur',
      'description': 'Diplôme d\'ingénieur en informatique',
      'issuer': 'École Polytechnique',
      'issuerId': 'did:archethic:polytechnique',
      'schemaId': 'schema:edu:diploma:1.0',
      'claims': {
        'degreeName': 'Ingénieur en Informatique',
        'graduationDate': '2010-06-30',
        'gpa': '16.8/20',
        'honors': 'Mention Très Bien',
      },
      'supportsZkp': false,
    },
    {
      'type': CredentialType.drivingLicense,
      'name': 'Permis de conduire',
      'description': 'Permis de conduire catégorie B',
      'issuer': 'Préfecture de Police',
      'issuerId': 'did:archethic:prefecture',
      'schemaId': 'schema:gov:driving:1.0',
      'claims': {
        'licenseNumber': 'B123456789',
        'categories': ['B'],
        'issueDate': '2005-07-15',
        'expiryDate': '2025-07-15',
        'restrictions': 'Aucune',
      },
      'supportsZkp': false,
    },
    {
      'type': CredentialType.ageVerification,
      'name': 'Attestation d\'âge',
      'description': 'Confirme que le détenteur est majeur',
      'issuer': 'Service de vérification',
      'issuerId': 'did:archethic:verifier',
      'schemaId': 'schema:age:verification:1.0',
      'claims': {
        'isOver18': true,
        'isOver21': false,
        'verificationDate': '2023-01-10',
      },
      'supportsZkp': true,
    },
    {
      'type': CredentialType.employmentProof,
      'name': 'Attestation d\'emploi',
      'description': 'Certificat de travail',
      'issuer': 'Entreprise XYZ',
      'issuerId': 'did:archethic:enterprise',
      'schemaId': 'schema:employment:proof:1.0',
      'claims': {
        'employer': 'Entreprise XYZ',
        'position': 'Développeur Senior',
        'startDate': '2018-03-01',
        'employmentStatus': 'CDI',
        'annualSalary': '60000',
      },
      'supportsZkp': true,
    },
  ];

  @override
  Future<bool> hasCredentials(String identityAddress) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 300));
    return _credentialsByIdentity.containsKey(identityAddress) &&
        _credentialsByIdentity[identityAddress]!.isNotEmpty;
  }

  @override
  Future<List<Credential>> getCredentials(String identityAddress) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    // Si aucune attestation n'existe pour cet utilisateur, générer des exemples
    if (!_credentialsByIdentity.containsKey(identityAddress) ||
        _credentialsByIdentity[identityAddress]!.isEmpty) {
      _generateSampleCredentials(identityAddress);
    }

    final credentialIds = _credentialsByIdentity[identityAddress] ?? [];
    return credentialIds
        .map((id) => _credentials[id])
        .whereType<Credential>()
        .toList();
  }

  @override
  Future<Credential?> getCredential(String credentialId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 300));
    return _credentials[credentialId];
  }

  @override
  Future<Credential> addCredential({
    required String identityAddress,
    required Map<String, dynamic> credentialData,
  }) async {
    // Simuler un délai réseau et vérification
    await Future.delayed(const Duration(milliseconds: 800));

    // Générer un ID unique pour l'attestation
    final credentialId = _uuid.v4();

    // Créer la preuve cryptographique
    final proof = CredentialProof(
      type: 'Ed25519Signature2020',
      created: DateTime.now(),
      verificationMethod: 'did:archethic:issuer#key-1',
      proofPurpose: 'assertionMethod',
      proofValue: _generateRandomSignature(),
    );

    // Créer l'attestation
    final now = DateTime.now();
    final credential = Credential(
      id: credentialId,
      type: credentialData['type'] ?? CredentialType.other,
      name: credentialData['name'] ?? 'Attestation',
      description: credentialData['description'],
      issuer: credentialData['issuer'] ?? 'Émetteur inconnu',
      issuerId: credentialData['issuerId'] ?? 'did:archethic:unknown',
      subjectId: identityAddress,
      issuedAt: now,
      expiresAt: credentialData['expiresAt'] != null
          ? DateTime.parse(credentialData['expiresAt'])
          : now.add(const Duration(days: 365)),
      claims: credentialData['claims'] ?? {},
      schemaId: credentialData['schemaId'] ?? 'schema:default:1.0',
      proof: proof,
      revocationStatus: RevocationStatus.notRevoked,
      supportsZkp: credentialData['supportsZkp'] ?? false,
      verificationStatus: VerificationStatus.verified,
    );

    // Stocker l'attestation
    _credentials[credentialId] = credential;

    // Ajouter l'ID de l'attestation à la liste de l'utilisateur
    if (!_credentialsByIdentity.containsKey(identityAddress)) {
      _credentialsByIdentity[identityAddress] = [];
    }
    _credentialsByIdentity[identityAddress]!.add(credentialId);

    return credential;
  }

  @override
  Future<bool> deleteCredential(String credentialId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    final credential = _credentials[credentialId];
    if (credential == null) {
      return false;
    }

    // Supprimer l'attestation
    _credentials.remove(credentialId);

    // Mettre à jour la liste des attestations de l'utilisateur
    final subjectId = credential.subjectId;
    if (_credentialsByIdentity.containsKey(subjectId)) {
      _credentialsByIdentity[subjectId]!.remove(credentialId);
    }

    return true;
  }

  @override
  Future<bool> verifyCredential(String credentialId) async {
    // Simuler un délai réseau et vérification
    await Future.delayed(const Duration(milliseconds: 1000));

    final credential = _credentials[credentialId];
    if (credential == null) {
      return false;
    }

    // Simuler une vérification cryptographique (toujours réussie pour la démo)
    return true;
  }

  @override
  Future<RevocationStatus> checkRevocationStatus(String credentialId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 700));

    final credential = _credentials[credentialId];
    if (credential == null) {
      return RevocationStatus.unknown;
    }

    // Retourner le statut de révocation actuel
    return credential.revocationStatus;
  }

  @override
  Future<CredentialPresentation> createPresentation({
    required String identityAddress,
    required List<String> credentialIds,
    required Map<String, List<String>> revealedAttributes,
    List<CredentialPredicate>? predicates,
  }) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 800));

    // Vérifier que les attestations existent
    final credentials = credentialIds
        .map((id) => _credentials[id])
        .whereType<Credential>()
        .toList();

    if (credentials.isEmpty) {
      throw Exception('Aucune attestation valide trouvée');
    }

    // Créer un extrait des attributs révélés
    final Map<String, dynamic> extractedAttributes = {};
    for (final credId in credentialIds) {
      final credential = _credentials[credId];
      if (credential != null) {
        final attrs = revealedAttributes[credId] ?? [];
        for (final attr in attrs) {
          if (credential.claims.containsKey(attr)) {
            if (!extractedAttributes.containsKey(credId)) {
              extractedAttributes[credId] = {};
            }
            extractedAttributes[credId][attr] = credential.claims[attr];
          }
        }
      }
    }

    // Créer la preuve de présentation
    final proof = CredentialProof(
      type: 'Ed25519Signature2020',
      created: DateTime.now(),
      verificationMethod: 'did:archethic:$identityAddress#key-1',
      proofPurpose: 'authentication',
      proofValue: _generateRandomSignature(),
    );

    // Créer la présentation
    final presentationId = _uuid.v4();
    final presentation = CredentialPresentation(
      id: presentationId,
      type: 'VerifiablePresentation',
      verifiableCredentials: credentials,
      created: DateTime.now(),
      revealedAttributes: extractedAttributes,
      predicates: predicates,
      proof: proof,
    );

    // Stocker la présentation
    _presentations[presentationId] = presentation;

    return presentation;
  }

  @override
  Future<bool> verifyPresentation(CredentialPresentation presentation) async {
    // Simuler un délai réseau et vérification
    await Future.delayed(const Duration(milliseconds: 1200));

    // Dans une implémentation réelle, on vérifierait:
    // 1. La signature de la présentation
    // 2. La validité de chaque attestation incluse
    // 3. La correspondance entre les attributs révélés et les attestations
    // 4. La validité des preuves ZKP pour les prédicats

    // Pour la démo, toujours renvoyer vrai
    return true;
  }

  @override
  Future<String> generatePresentationLink(String presentationId) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 400));

    final presentation = _presentations[presentationId];
    if (presentation == null) {
      throw Exception('Présentation non trouvée');
    }

    // Générer un code court pour le lien
    final code = _generateShortCode();
    _presentationLinks[code] = presentationId;

    // Simuler un lien de partage
    return 'https://example.com/p/$code';
  }

  @override
  Future<CredentialPresentation?> getPresentationFromLink(String link) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    // Extraire le code du lien
    final uri = Uri.parse(link);
    final pathSegments = uri.pathSegments;
    if (pathSegments.length != 2 || pathSegments[0] != 'p') {
      return null;
    }

    final code = pathSegments[1];
    final presentationId = _presentationLinks[code];
    if (presentationId == null) {
      return null;
    }

    return _presentations[presentationId];
  }

  @override
  Future<Credential> acceptCredentialOffer({
    required String identityAddress,
    required String offerId,
    required Map<String, dynamic> consents,
  }) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 1500));

    // Pour la démo, générer une attestation aléatoire
    final sampleIndex = _random.nextInt(_sampleCredentials.length);
    final credentialData = _sampleCredentials[sampleIndex];

    return addCredential(
      identityAddress: identityAddress,
      credentialData: credentialData,
    );
  }

  @override
  Future<String> createCredentialRequest({
    required String identityAddress,
    required String issuerId,
    required String credentialType,
    Map<String, dynamic>? additionalInfo,
  }) async {
    // Simuler un délai réseau
    await Future.delayed(const Duration(milliseconds: 600));

    // Générer un ID de demande
    return _uuid.v4();
  }

  // Méthodes utilitaires privées

  // Génère des attestations d'exemple pour un utilisateur
  void _generateSampleCredentials(String identityAddress) {
    // Sélectionner aléatoirement 2-3 attestations d'exemple
    final count = 2 + _random.nextInt(2);
    final selectedIndices = <int>[];

    while (selectedIndices.length < count &&
        selectedIndices.length < _sampleCredentials.length) {
      final index = _random.nextInt(_sampleCredentials.length);
      if (!selectedIndices.contains(index)) {
        selectedIndices.add(index);
      }
    }

    // Ajouter les attestations sélectionnées
    for (final index in selectedIndices) {
      final credentialData = _sampleCredentials[index];

      // Générer un ID unique
      final credentialId = _uuid.v4();

      // Créer la preuve
      final proof = CredentialProof(
        type: 'Ed25519Signature2020',
        created: DateTime.now().subtract(Duration(days: _random.nextInt(60))),
        verificationMethod: 'did:archethic:${credentialData['issuerId']}#key-1',
        proofPurpose: 'assertionMethod',
        proofValue: _generateRandomSignature(),
      );

      // Créer l'attestation
      final now = DateTime.now();
      final credential = Credential(
        id: credentialId,
        type: credentialData['type'],
        name: credentialData['name'],
        description: credentialData['description'],
        issuer: credentialData['issuer'],
        issuerId: credentialData['issuerId'],
        subjectId: identityAddress,
        issuedAt: now.subtract(Duration(days: 30 + _random.nextInt(300))),
        expiresAt: now.add(Duration(days: 180 + _random.nextInt(730))),
        claims: Map<String, dynamic>.from(credentialData['claims']),
        schemaId: credentialData['schemaId'],
        proof: proof,
        revocationStatus: RevocationStatus.notRevoked,
        supportsZkp: credentialData['supportsZkp'],
        verificationStatus: VerificationStatus.verified,
      );

      // Stocker l'attestation
      _credentials[credentialId] = credential;

      // Ajouter l'ID à la liste de l'utilisateur
      if (!_credentialsByIdentity.containsKey(identityAddress)) {
        _credentialsByIdentity[identityAddress] = [];
      }
      _credentialsByIdentity[identityAddress]!.add(credentialId);
    }
  }

  // Génère une signature aléatoire pour la simulation
  String _generateRandomSignature() {
    final bytes = List<int>.generate(64, (i) => _random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  // Génère un code court pour les liens de partage
  String _generateShortCode() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(
      List.generate(
          8, (index) => chars.codeUnitAt(_random.nextInt(chars.length))),
    );
  }
}
