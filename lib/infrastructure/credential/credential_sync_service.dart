import 'dart:async';
import 'dart:developer';
import 'package:did_app/application/credential/credential_status_provider.dart';
import 'package:did_app/application/credential/providers.dart';
import 'package:did_app/domain/credential/credential.dart';
import 'package:did_app/domain/credential/credential_status.dart';
import 'package:did_app/infrastructure/credential/credential_status_service.dart';
import 'package:did_app/infrastructure/credential/mock_notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service de synchronisation des statuts d'attestation en arrière-plan
class CredentialSyncService {
  /// Référence au notifier de statut
  final CredentialStatusNotifier statusNotifier;

  /// Service de vérification des statuts
  final CredentialStatusService statusService;

  /// Fournisseur d'attestations
  final CredentialNotifier credentialNotifier;

  /// Plugin de notifications locales
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  /// Intervalle de synchronisation
  final Duration syncInterval;

  /// Timer pour la synchronisation périodique
  Timer? _syncTimer;

  /// Indique si le service est en cours d'exécution
  bool _isRunning = false;

  CredentialSyncService({
    required this.statusNotifier,
    required this.statusService,
    required this.credentialNotifier,
    FlutterLocalNotificationsPlugin? notificationsPlugin,
    this.syncInterval = const Duration(hours: 1),
  }) : _notificationsPlugin =
            notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  /// Initialise le service de notifications
  Future<void> initNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Démarre le service de synchronisation
  void startSync() {
    if (_isRunning) return;

    _isRunning = true;

    // Synchroniser immédiatement
    syncNow();

    // Démarrer la synchronisation périodique
    _syncTimer = Timer.periodic(syncInterval, (_) {
      syncNow();
    });

    log('Service de synchronisation démarré');
  }

  /// Arrête le service de synchronisation
  void stopSync() {
    _syncTimer?.cancel();
    _isRunning = false;
    log('Service de synchronisation arrêté');
  }

  /// Force une synchronisation immédiate
  Future<void> syncNow() async {
    log('Synchronisation des statuts en cours...');

    try {
      // Récupérer toutes les attestations
      final credentials = await credentialNotifier.getAllCredentials();

      // Vérifier les statuts
      final results = await statusService.checkStatuses(credentials);

      // Traiter les résultats
      _processResults(credentials, results);

      log('Synchronisation terminée');
    } catch (e) {
      log('Erreur lors de la synchronisation: $e');
    }
  }

  /// Traite les résultats de vérification et envoie des notifications si nécessaire
  void _processResults(
    List<Credential> credentials,
    List<StatusCheckResult> results,
  ) {
    // Vérifier les changements de statut
    for (final result in results) {
      final credential = credentials.firstWhere(
        (c) => c.id == result.credentialId,
        orElse: () => throw Exception('Attestation non trouvée'),
      );

      if (result.status == CredentialStatusType.revoked) {
        _sendRevocationNotification(credential);
      } else if (result.status == CredentialStatusType.expired) {
        _sendExpirationNotification(credential);
      }
    }
  }

  /// Envoie une notification pour une attestation révoquée
  Future<void> _sendRevocationNotification(Credential credential) async {
    const androidDetails = AndroidNotificationDetails(
      'revocation_channel',
      'Révocations',
      channelDescription: 'Notifications de révocation d\'attestations',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iOSDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notificationsPlugin.show(
      credential.id.hashCode,
      'Attestation révoquée',
      'L\'attestation "${_getCredentialName(credential)}" a été révoquée',
      details,
      payload: credential.id,
    );
  }

  /// Envoie une notification pour une attestation expirée
  Future<void> _sendExpirationNotification(Credential credential) async {
    const androidDetails = AndroidNotificationDetails(
      'expiration_channel',
      'Expirations',
      channelDescription: 'Notifications d\'expiration d\'attestations',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iOSDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notificationsPlugin.show(
      credential.id.hashCode,
      'Attestation expirée',
      'L\'attestation "${_getCredentialName(credential)}" a expiré',
      details,
      payload: credential.id,
    );
  }

  /// Obtient un nom lisible pour une attestation
  String _getCredentialName(Credential credential) {
    final type =
        credential.type.isNotEmpty ? credential.type.first : 'Attestation';
    final subject = credential.credentialSubject;

    if (subject.containsKey('name')) {
      return subject['name'].toString();
    }

    if (subject.containsKey('givenName') && subject.containsKey('familyName')) {
      return '${subject['givenName']} ${subject['familyName']}';
    }

    return type;
  }

  /// Gestionnaire de tap sur les notifications
  void _onNotificationTap(NotificationResponse response) {
    // À implémenter: navigation vers l'écran de détail de l'attestation
    final credentialId = response.payload;
    if (credentialId != null) {
      log('Notification tappée pour l\'attestation: $credentialId');
      // Navigator.push(...) - À implémenter via un callback
    }
  }
}

/// Provider pour le service de synchronisation
final credentialSyncServiceProvider = Provider<CredentialSyncService>((ref) {
  final statusNotifier = ref.read(credentialStatusNotifierProvider.notifier);
  final statusService = ref.read(credentialStatusServiceProvider);
  final credentialNotifier = ref.read(credentialNotifierProvider.notifier);

  return CredentialSyncService(
    statusNotifier: statusNotifier,
    statusService: statusService,
    credentialNotifier: credentialNotifier,
  );
});
