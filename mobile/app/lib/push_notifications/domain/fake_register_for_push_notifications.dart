import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/push_notifications/push_notifications.dart';
import 'package:uuid/uuid.dart';

class FakeRegisterForPushNotifications implements RegisterForPushNotifications {
  FakeRegisterForPushNotifications({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  @override
  Future<void> call() async {
    await _repository.addFcmToken(const Uuid().v4());
  }
}
