import 'package:irri/features/customer_details/customer_details.dart';

class GetUserTimezone {
  GetUserTimezone({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<String?> call() {
    return _repository.getUserTimeZone();
  }
}
