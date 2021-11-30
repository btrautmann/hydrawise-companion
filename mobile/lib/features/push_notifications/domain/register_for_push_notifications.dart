import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/push_notifications/push_notifications.dart';
import 'package:uuid/uuid.dart';

class RegisterForPushNotifications {
  RegisterForPushNotifications({
    required FirebaseMessaging firebaseMessaging,
    required CustomerDetailsRepository repository,
  })  : _messaging = firebaseMessaging,
        _repository = repository;

  final FirebaseMessaging _messaging;
  final CustomerDetailsRepository _repository;

  Future<void> call() async {
    final currentSettings = await _messaging.getNotificationSettings();
    if (currentSettings.hasPushPermissions()) {
      await _handleSettings(currentSettings);
      return;
    }
    final resultSettings = await _messaging.requestPermission();
    await _handleSettings(resultSettings);
  }

  Future<void> _handleSettings(NotificationSettings settings) async {
    final registeredTokens = await _repository.getRegisteredFcmTokens();
    if (settings.hasPushPermissions()) {
      final token = await _messaging.getToken();
      if (token != null && !registeredTokens.contains(token)) {
        await _repository.addFcmToken(token);
      }
    }
  }
}

class FakeRegisterForPushNotifications implements RegisterForPushNotifications {
  FakeRegisterForPushNotifications({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  @override
  final CustomerDetailsRepository _repository;

  @override
  Future<void> _handleSettings(NotificationSettings settings) {
    throw UnimplementedError();
  }

  @override
  FirebaseMessaging get _messaging => throw UnimplementedError();

  @override
  Future<void> call() async {
    await _repository.addFcmToken(const Uuid().v4());
  }
}
