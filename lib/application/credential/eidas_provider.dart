import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/eidas_credential.dart';
import 'package:did_app/infrastructure/credential/eidas_credential_service.dart'
    as eidas_service;
import 'package:did_app/infrastructure/credential/eidas_trust_list.dart';
import 'package:did_app/infrastructure/credential/eu_trust_registry_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour le service eIDAS
final eidasCredentialServiceProvider =
    Provider<eidas_service.EidasCredentialService>((ref) {
  return eidas_service.EidasCredentialService();
});

/// État pour la fonctionnalité eIDAS
class EidasState {
  const EidasState({
    this.isLoading = false,
    this.errorMessage,
    this.isEudiWalletAvailable = false,
    this.verificationResult,
    this.revocationStatus,
    this.lastSyncDate,
    this.trustListReport,
    this.interoperabilityReport,
    this.trustedIssuers = const [],
    this.selectedTrustLevel,
    this.selectedCountry,
  });

  /// Indique si une opération est en cours
  final bool isLoading;

  /// Message d'erreur éventuel
  final String? errorMessage;

  /// Indique si l'EUDI Wallet est disponible sur l'appareil
  final bool isEudiWalletAvailable;

  /// Résultat de la dernière vérification de signature
  final eidas_service.VerificationResult? verificationResult;

  /// Statut de révocation de la dernière attestation vérifiée
  final eidas_service.RevocationStatus? revocationStatus;

  /// Date de dernière synchronisation avec le registre européen
  final DateTime? lastSyncDate;

  /// Rapport sur la liste de confiance
  final Map<String, dynamic>? trustListReport;

  /// Rapport d'interopérabilité
  final Map<String, dynamic>? interoperabilityReport;

  /// Liste des émetteurs de confiance
  final List<TrustedIssuer> trustedIssuers;

  /// Niveau de confiance sélectionné pour le filtrage
  final TrustLevel? selectedTrustLevel;

  /// Pays sélectionné pour le filtrage
  final String? selectedCountry;

  EidasState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isEudiWalletAvailable,
    eidas_service.VerificationResult? verificationResult,
    eidas_service.RevocationStatus? revocationStatus,
    DateTime? lastSyncDate,
    Map<String, dynamic>? trustListReport,
    Map<String, dynamic>? interoperabilityReport,
    List<TrustedIssuer>? trustedIssuers,
    TrustLevel? selectedTrustLevel,
    String? selectedCountry,
  }) {
    return EidasState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isEudiWalletAvailable:
          isEudiWalletAvailable ?? this.isEudiWalletAvailable,
      verificationResult: verificationResult ?? this.verificationResult,
      revocationStatus: revocationStatus ?? this.revocationStatus,
      lastSyncDate: lastSyncDate ?? this.lastSyncDate,
      trustListReport: trustListReport ?? this.trustListReport,
      interoperabilityReport:
          interoperabilityReport ?? this.interoperabilityReport,
      trustedIssuers: trustedIssuers ?? this.trustedIssuers,
      selectedTrustLevel: selectedTrustLevel ?? this.selectedTrustLevel,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}

/// Provider pour la gestion de l'interopérabilité eIDAS
final eidasNotifierProvider =
    StateNotifierProvider<EidasNotifier, EidasState>((ref) {
  return EidasNotifier(ref);
});

/// Notifier pour la gestion des fonctionnalités eIDAS
class EidasNotifier extends StateNotifier<EidasState> {
  EidasNotifier(this._ref) : super(const EidasState()) {
    // À l'initialisation, vérifier la disponibilité de l'EUDI Wallet
    _checkEudiWalletAvailability();

    // Charger les données de la liste de confiance
    _loadTrustListData();
  }

  final Ref _ref;

  /// Vérifie si l'EUDI Wallet est disponible sur l'appareil
  Future<void> _checkEudiWalletAvailability() async {
    // Dans une implémentation réelle, cela vérifierait si l'application EUDI Wallet
    // est installée sur l'appareil via une API du système d'exploitation
    // Pour la démo, on simule que c'est disponible
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isEudiWalletAvailable: true);
  }

  /// Charge les données initiales de la liste de confiance
  Future<void> _loadTrustListData() async {
    state = state.copyWith(isLoading: true);

    try {
      // Récupérer la date de dernière synchronisation
      final lastSyncDate = await EidasTrustList.instance.getLastSyncDate();

      // Récupérer tous les émetteurs de confiance
      final trustedIssuers =
          await EidasTrustList.instance.getAllTrustedIssuers();

      // Générer un rapport sur la liste de confiance
      final trustListReport =
          await EidasTrustList.instance.generateTrustListReport();

      state = state.copyWith(
        isLoading: false,
        lastSyncDate: lastSyncDate,
        trustedIssuers: trustedIssuers,
        trustListReport: trustListReport,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du chargement des données: $e',
      );
    }
  }

  /// Charge ou actualise les données de la liste de confiance
  Future<void> loadTrustList() async {
    return _loadTrustListData();
  }

  /// Importe une attestation depuis un JSON au format eIDAS
  Future<Credential?> importFromJson(String jsonString) async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final credential = await service.importFromJson(jsonString);

      state = state.copyWith(
        isLoading: false,
      );

      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Erreur lors de l'importation: $e",
      );
      return null;
    }
  }

  /// Exporte une attestation au format eIDAS
  Future<String?> exportToJson(Credential credential) async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final jsonString = await service.exportToJson(credential);

      state = state.copyWith(
        isLoading: false,
      );

      return jsonString;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Erreur lors de l'exportation: $e",
      );
      return null;
    }
  }

  /// Vérifie si une attestation est compatible eIDAS
  bool isEidasCompatible(Credential credential) {
    final service = _ref.read(eidasCredentialServiceProvider);
    return service.isEidasCompatible(credential);
  }

  /// Rend une attestation compatible eIDAS
  Future<Credential?> makeEidasCompatible(Credential credential) async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final result = await service.makeEidasCompatible(credential);

      state = state.copyWith(
        isLoading: false,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la conversion eIDAS: $e',
      );
      return null;
    }
  }

  /// Importe une attestation depuis l'EUDI Wallet
  Future<Credential?> importFromEudiWallet() async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      // Dans une implémentation réelle, cette méthode :
      // 1. Ouvrirait l'application EUDI Wallet via une Intent/URL Scheme
      // 2. Recevrait les données de l'attestation sélectionnée
      // 3. Convertirait ces données au format attendu par l'application

      await Future.delayed(const Duration(seconds: 2)); // Simuler le délai

      final service = _ref.read(eidasCredentialServiceProvider);

      // Simulation: charger un exemple de credential eIDAS
      final jsonString = await service.exportToJson(Credential(
        id: 'urn:uuid:${DateTime.now().millisecondsSinceEpoch}',
        type: ['VerifiableCredential', 'EuropeanIdentityCredential'],
        issuer: 'did:example:eudi-wallet-issuer',
        issuanceDate: DateTime.now(),
        subject: 'did:example:c1234',
        credentialSubject: {
          'id': 'did:example:c1234',
          'firstName': 'Alice',
          'lastName': 'Martin',
          'dateOfBirth': '1990-01-01',
          'nationality': 'FR',
          'documentNumber': 'FR-ID-123456789',
        },
        context: [
          'https://www.w3.org/2018/credentials/v1',
          'https://ec.europa.eu/2023/credentials/eidas/v1',
        ],
        proof: {
          'type': 'EidasSignature2023',
          'created': DateTime.now().toIso8601String(),
          'verificationMethod': 'did:example:eudi-wallet-issuer#key-1',
          'proofPurpose': 'assertionMethod',
          'proofValue': 'zQeVbY4oey5q2M3XKaxup3tmzN4DRFTLVqpLMweBrSxBz',
        },
      ),);

      final credential = await service.importFromJson(jsonString);

      state = state.copyWith(
        isLoading: false,
      );

      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Erreur lors de l'importation depuis EUDI Wallet: $e",
      );
      return null;
    }
  }

  /// Vérifie l'authenticité d'une attestation eIDAS
  Future<eidas_service.VerificationResult> verifyCredential(
      Credential credential,) async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);

      // Convertir en format eIDAS si nécessaire
      final eidasCompatible = await service.makeEidasCompatible(credential);
      final eidasCredential = EidasCredential.fromCredential(eidasCompatible);

      // Vérifier la signature cryptographique
      final verificationResult =
          await service.verifyEidasCredential(eidasCredential);

      // Vérifier le statut de révocation si la signature est valide
      eidas_service.RevocationStatus? revocationStatus;
      if (verificationResult.isValid) {
        revocationStatus = await service.checkRevocationStatus(eidasCredential);
      }

      // Vérifier si l'émetteur est dans la liste de confiance européenne
      var issuerTrusted = false;
      if (eidasCredential.issuer.id.isNotEmpty) {
        issuerTrusted = await EidasTrustList.instance
            .isIssuerTrusted(eidasCredential.issuer.id);
      }

      // Créer un résultat enrichi avec les informations de confiance
      final result = eidas_service.VerificationResult(
        isValid: verificationResult.isValid &&
            (revocationStatus?.isRevoked != true) &&
            issuerTrusted,
        message: _buildVerificationMessage(
            verificationResult, revocationStatus, issuerTrusted,),
        details: {
          ...?verificationResult.details,
          'issuerTrusted': issuerTrusted,
          if (revocationStatus != null)
            'revocationStatus':
                revocationStatus.isRevoked ? 'révoqué' : 'valide',
        },
      );

      state = state.copyWith(
        isLoading: false,
        verificationResult: result,
        revocationStatus: revocationStatus,
      );

      return result;
    } catch (e) {
      final errorResult = eidas_service.VerificationResult(
        isValid: false,
        message: 'Erreur lors de la vérification: $e',
      );

      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la vérification: $e',
        verificationResult: errorResult,
      );

      return errorResult;
    }
  }

  /// Construit un message de vérification synthétique
  String _buildVerificationMessage(
    eidas_service.VerificationResult result,
    eidas_service.RevocationStatus? revocationStatus,
    bool issuerTrusted,
  ) {
    final messages = <String>[];

    // Message principal de vérification
    messages.add(result.message);

    // Statut de révocation
    if (revocationStatus != null) {
      messages.add(revocationStatus.message);
    }

    // Statut de confiance de l'émetteur
    if (issuerTrusted) {
      messages.add('Émetteur présent dans le registre de confiance européen');
    } else {
      messages
          .add('Émetteur non reconnu par le registre de confiance européen');
    }

    return messages.join('. ');
  }

  /// Génère un QR code pour partager une attestation
  Future<String?> generateQrCodeForCredential(Credential credential) async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);

      // Convertir en format eIDAS si nécessaire
      final eidasCompatible = await service.makeEidasCompatible(credential);

      // Exporter au format JSON pour le QR code
      final json = await service.exportToJson(eidasCompatible);

      // Dans une implémentation réelle, on utiliserait une bibliothèque pour
      // générer un QR code à partir du JSON, potentiellement compressé

      // Pour cette démo, on retourne simplement le JSON
      state = state.copyWith(
        isLoading: false,
      );

      return json;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la génération du QR code: $e',
      );
      return null;
    }
  }

  /// Synchronise les attestations avec l'infrastructure eIDAS européenne
  Future<bool> synchronizeWithEidasInfrastructure() async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      // Dans une implémentation réelle, cette méthode :
      // 1. Se connecterait à l'infrastructure de nœuds eIDAS
      // 2. Mettrait à jour les listes de révocation
      // 3. Synchroniserait les listes de confiance
      // 4. Mettrait à jour les schémas de validation

      // Utiliser le service de registre européen pour synchroniser les données
      final success =
          await EuTrustRegistryService.instance.synchronizeTrustList();

      if (success) {
        // Mettre à jour les données locales
        final lastSyncDate = await EidasTrustList.instance.getLastSyncDate();
        final trustedIssuers =
            await EidasTrustList.instance.getAllTrustedIssuers();
        final trustListReport =
            await EidasTrustList.instance.generateTrustListReport();

        // Générer un rapport d'interopérabilité
        final interoperabilityReport = await EuTrustRegistryService.instance
            .generateInteroperabilityReport();

        state = state.copyWith(
          isLoading: false,
          lastSyncDate: lastSyncDate,
          trustedIssuers: trustedIssuers,
          trustListReport: trustListReport,
          interoperabilityReport: interoperabilityReport,
        );

        return true;
      } else {
        throw Exception(
            'Échec de la synchronisation avec le registre européen',);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            "Erreur lors de la synchronisation avec l'infrastructure eIDAS: $e",
      );
      return false;
    }
  }

  /// Filtre les émetteurs de confiance par pays
  Future<void> filterIssuersByCountry(String? countryCode) async {
    state = state.copyWith(
      isLoading: true,
      selectedCountry: countryCode,
    );

    try {
      List<TrustedIssuer> filteredIssuers;

      if (countryCode == null) {
        // Pas de filtre de pays
        filteredIssuers = await EidasTrustList.instance.getAllTrustedIssuers();
      } else {
        // Filtrer par pays
        filteredIssuers = await EidasTrustList.instance
            .getTrustedIssuersByCountry(countryCode);
      }

      // Appliquer le filtre de niveau si existant
      if (state.selectedTrustLevel != null) {
        filteredIssuers = filteredIssuers
            .where((issuer) => issuer.trustLevel == state.selectedTrustLevel)
            .toList();
      }

      state = state.copyWith(
        isLoading: false,
        trustedIssuers: filteredIssuers,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du filtrage par pays: $e',
      );
    }
  }

  /// Filtre les émetteurs de confiance par niveau de confiance
  Future<void> filterIssuersByTrustLevel(TrustLevel? level) async {
    state = state.copyWith(
      isLoading: true,
      selectedTrustLevel: level,
    );

    try {
      List<TrustedIssuer> filteredIssuers;

      if (level == null) {
        // Pas de filtre de niveau
        filteredIssuers = await EidasTrustList.instance.getAllTrustedIssuers();
      } else {
        // Filtrer par niveau
        filteredIssuers =
            await EidasTrustList.instance.getTrustedIssuersByLevel(level);
      }

      // Appliquer le filtre de pays si existant
      if (state.selectedCountry != null) {
        filteredIssuers = filteredIssuers
            .where((issuer) => issuer.country == state.selectedCountry)
            .toList();
      }

      state = state.copyWith(
        isLoading: false,
        trustedIssuers: filteredIssuers,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du filtrage par niveau: $e',
      );
    }
  }

  /// Vérifie si un émetteur est dans le registre de confiance européen
  Future<Map<String, dynamic>> verifyTrustedIssuer(String issuerId) async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final result =
          await EuTrustRegistryService.instance.verifyTrustedIssuer(issuerId);

      state = state.copyWith(
        isLoading: false,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Erreur lors de la vérification de l'émetteur: $e",
      );

      return {
        'isValid': false,
        'error': e.toString(),
      };
    }
  }

  /// Récupère les schémas de confiance disponibles
  Future<Map<String, dynamic>> fetchTrustSchemes() async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final schemes = await EuTrustRegistryService.instance.fetchTrustSchemes();

      state = state.copyWith(
        isLoading: false,
      );

      return schemes;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Erreur lors de la récupération des schémas de confiance: $e',
      );

      return {'schemes': []};
    }
  }

  /// Partage une attestation avec l'EUDI Wallet
  Future<bool> shareWithEudiWallet(Credential credential) async {
    if (!state.isEudiWalletAvailable) {
      state = state.copyWith(
        errorMessage: "L'EUDI Wallet n'est pas disponible sur cet appareil",
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
    );

    try {
      // Dans une implémentation réelle, cette méthode :
      // 1. Convertirait l'attestation au format eIDAS si nécessaire
      // 2. Ouvrirait l'application EUDI Wallet via une Intent/URL Scheme
      // 3. Partagerait les données avec l'EUDI Wallet

      // Convertir en format eIDAS si nécessaire
      final service = _ref.read(eidasCredentialServiceProvider);
      final eidasCompatible = await service.makeEidasCompatible(credential);

      // Exporter au format JSON pour le partage
      final json = await service.exportToJson(eidasCompatible);

      // Simuler un délai pour l'opération de partage
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(
        isLoading: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du partage avec EUDI Wallet: $e',
      );
      return false;
    }
  }
}
