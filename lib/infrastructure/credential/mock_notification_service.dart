import 'dart:developer';

/// Mock pour les notifications Android
class AndroidInitializationSettings {
  const AndroidInitializationSettings(this.defaultIcon);
  final String defaultIcon;
}

/// Mock pour les notifications iOS
class DarwinInitializationSettings {
  const DarwinInitializationSettings();
}

/// Mock pour les paramètres d'initialisation
class InitializationSettings {
  const InitializationSettings({
    required this.android,
    required this.iOS,
  });
  final AndroidInitializationSettings android;
  final DarwinInitializationSettings iOS;
}

/// Mock pour la réponse à une notification
class NotificationResponse {
  const NotificationResponse({this.payload});
  final String? payload;
}

/// Mock pour les niveaux d'importance
enum Importance {
  unspecified,
  none,
  min,
  low,
  defaultImportance,
  high,
  max,
}

/// Mock pour les niveaux de priorité
enum Priority {
  min,
  low,
  defaultPriority,
  high,
  max,
}

/// Mock pour les détails de notification Android
class AndroidNotificationDetails {
  const AndroidNotificationDetails(
    this.channelId,
    this.channelName, {
    this.channelDescription,
    this.importance = Importance.defaultImportance,
    this.priority = Priority.defaultPriority,
  });
  final String channelId;
  final String channelName;
  final String? channelDescription;
  final Importance importance;
  final Priority priority;
}

/// Mock pour les détails de notification iOS
class DarwinNotificationDetails {
  const DarwinNotificationDetails();
}

/// Mock pour les détails de notification
class NotificationDetails {
  const NotificationDetails({
    required this.android,
    required this.iOS,
  });
  final AndroidNotificationDetails android;
  final DarwinNotificationDetails iOS;
}

/// Mock pour le plugin de notifications locales
class FlutterLocalNotificationsPlugin {
  Future<void> initialize(
    InitializationSettings initializationSettings, {
    Function(NotificationResponse)? onDidReceiveNotificationResponse,
  }) async {
    log('Simulating notification initialization');
    _onDidReceiveNotificationResponse = onDidReceiveNotificationResponse;
    return Future.value();
  }

  Function(NotificationResponse)? _onDidReceiveNotificationResponse;

  Future<void> show(
    int id,
    String title,
    String body,
    NotificationDetails notificationDetails, {
    String? payload,
  }) async {
    log('Simulating notification: $title - $body');
    if (payload != null) {
      log('Notification payload: $payload');
    }
    return Future.value();
  }
}
