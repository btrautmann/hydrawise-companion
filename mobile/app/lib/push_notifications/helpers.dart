import 'package:firebase_messaging/firebase_messaging.dart';

extension NotificationSettingsX on NotificationSettings {
  bool hasPushPermissions() {
    return authorizationStatus == AuthorizationStatus.authorized ||
        authorizationStatus == AuthorizationStatus.provisional;
  }
}
