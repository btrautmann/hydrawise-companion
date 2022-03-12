import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/push_notifications/push_notifications.dart';

class FakeUnregisterForPushNotifications
    implements UnregisterForPushNotifications {
  FakeUnregisterForPushNotifications({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  @override
  Future<void> call() async {
    await _repository.getRegisteredFcmTokens().then((tokens) {
      tokens.forEach(_repository.removeFcmToken);
    });
  }
}
