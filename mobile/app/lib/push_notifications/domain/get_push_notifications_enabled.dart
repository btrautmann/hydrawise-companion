import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/push_notifications/push_notifications.dart';

class GetPushNotificationsEnabled {
  GetPushNotificationsEnabled({
    required FirebaseMessaging firebaseMessaging,
    required CustomerDetailsRepository repository,
  })  : _messaging = firebaseMessaging,
        _repository = repository;

  final FirebaseMessaging _messaging;
  final CustomerDetailsRepository _repository;

  Future<bool> call() async {
    final settings = await _messaging.getNotificationSettings();
    if (settings.hasPushPermissions()) {
      final registeredTokens = await _repository.getRegisteredFcmTokens();
      final token = await _messaging.getToken();
      return token != null && registeredTokens.contains(token);
    }
    return false;
  }
}

class FakeGetPushNotificationsEnabled implements GetPushNotificationsEnabled {
  FakeGetPushNotificationsEnabled({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  @override
  final CustomerDetailsRepository _repository;

  @override
  FirebaseMessaging get _messaging => throw UnimplementedError();

  @override
  Future<bool> call() async {
    final tokens = await _repository.getRegisteredFcmTokens();
    return tokens.isNotEmpty;
  }
}
