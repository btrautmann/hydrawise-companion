import 'package:irri/customer_details/customer_details.dart';

class UpdateUserTimeZone {
  UpdateUserTimeZone({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<void> call(String timeZone) {
    return _repository.updateTimeZone(timeZone);
  }
}
