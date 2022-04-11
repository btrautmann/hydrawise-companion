import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/push_notifications/push_notifications.dart';

class UnregisterForPushNotifications implements RegisterForPushNotifications {
  UnregisterForPushNotifications({
    required FirebaseMessaging firebaseMessaging,
    required CustomerDetailsRepository repository,
  })  : _messaging = firebaseMessaging,
        _repository = repository;

  final FirebaseMessaging _messaging;
  final CustomerDetailsRepository _repository;

  @override
  Future<void> call() async {
    final currentSettings = await _messaging.getNotificationSettings();
    if (currentSettings.hasPushPermissions()) {
      final registeredTokens = await _repository.getRegisteredFcmTokens();
      final token = await _messaging.getToken();
      if (token != null && registeredTokens.contains(token)) {
        await _repository.removeFcmToken(token);
      }
    }
  }
}
