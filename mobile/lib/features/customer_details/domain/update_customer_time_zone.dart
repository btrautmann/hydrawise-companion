import 'package:irri/features/customer_details/repository/repository.dart';

class UpdateCustomerTimeZone {
  UpdateCustomerTimeZone({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;
  Future<void> call({
    required String timeZone,
  }) {
    return _repository.updateCustomerTimeZone(timeZone);
  }
}
