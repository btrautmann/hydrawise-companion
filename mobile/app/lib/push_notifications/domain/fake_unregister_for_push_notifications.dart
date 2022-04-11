import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/push_notifications/push_notifications.dart';

class FakeUnregisterForPushNotifications
    implements UnregisterForPushNotifications {
  FakeUnregisterForPushNotifications({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  @override
  Future<void> call() async {
    final tokens = await _repository.getRegisteredFcmTokens();
    // Copy tokens to a new list to avoid ConcurrentModificationExceptions
    for (final token in [...tokens]) {
      await _repository.removeFcmToken(token);
    }
  }
}
