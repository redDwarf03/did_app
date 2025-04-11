import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/infrastructure/credential/eidas_credential_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour le service eIDAS
final eidasCredentialServiceProvider = Provider<EidasCredentialService>((ref) {
  return EidasCredentialService();
});

/// État pour la fonctionnalité eIDAS
class EidasState {
  const EidasState({
    this.isLoading = false,
    this.errorMessage,
    this.lastImportedCredential,
    this.lastExportedJson,
    this.isEudiWalletAvailable = false,
  });

  /// Indicateur de chargement
  final bool isLoading;

  /// Message d'erreur éventuel
  final String? errorMessage;

  /// Dernière attestation importée
  final Credential? lastImportedCredential;

  /// Dernier JSON exporté
  final String? lastExportedJson;

  /// Indique si l'EUDI Wallet est disponible sur l'appareil
  final bool isEudiWalletAvailable;

  EidasState copyWith({
    bool? isLoading,
    String? errorMessage,
    Credential? lastImportedCredential,
    String? lastExportedJson,
    bool? isEudiWalletAvailable,
  }) {
    return EidasState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      lastImportedCredential:
          lastImportedCredential ?? this.lastImportedCredential,
      lastExportedJson: lastExportedJson ?? this.lastExportedJson,
      isEudiWalletAvailable:
          isEudiWalletAvailable ?? this.isEudiWalletAvailable,
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
    _checkEudiWalletAvailability();
  }

  final Ref _ref;

  /// Vérifie si l'EUDI Wallet est disponible sur l'appareil
  Future<void> _checkEudiWalletAvailability() async {
    // Dans une implémentation réelle, on vérifierait si l'app EUDI est installée
    // Pour la démo, on considère qu'elle est disponible
    state = state.copyWith(isEudiWalletAvailable: true);
  }

  /// Importe une attestation depuis un JSON au format eIDAS
  Future<Credential?> importFromJson(String jsonString) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final credential = await service.importFromJson(jsonString);

      state = state.copyWith(
        isLoading: false,
        lastImportedCredential: credential,
      );

      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de l\'import: $e',
      );
      return null;
    }
  }

  /// Exporte une attestation au format eIDAS
  Future<String?> exportToJson(Credential credential) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final json = await service.exportToJson(credential);

      state = state.copyWith(
        isLoading: false,
        lastExportedJson: json,
      );

      return json;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de l\'export: $e',
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
      errorMessage: null,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final result = await service.makeEidasCompatible(credential);

      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de la conversion eIDAS: $e',
      );
      return null;
    }
  }

  /// Partage une attestation avec l'EUDI Wallet
  Future<bool> shareWithEudiWallet(Credential credential) async {
    if (!state.isEudiWalletAvailable) {
      state = state.copyWith(
        errorMessage: 'L\'EUDI Wallet n\'est pas disponible sur cet appareil',
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final result = await service.shareWithEudiWallet(credential);

      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors du partage avec EUDI Wallet: $e',
      );
      return false;
    }
  }

  /// Importe une attestation depuis l'EUDI Wallet
  Future<Credential?> importFromEudiWallet() async {
    if (!state.isEudiWalletAvailable) {
      state = state.copyWith(
        errorMessage: 'L\'EUDI Wallet n\'est pas disponible sur cet appareil',
      );
      return null;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final service = _ref.read(eidasCredentialServiceProvider);
      final credential = await service.importFromEudiWallet();

      state = state.copyWith(
        isLoading: false,
        lastImportedCredential: credential,
      );

      return credential;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erreur lors de l\'import depuis EUDI Wallet: $e',
      );
      return null;
    }
  }
}
