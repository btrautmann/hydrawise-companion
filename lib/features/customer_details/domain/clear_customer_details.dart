import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';

typedef ClearCustomerDetails = Future<void> Function();

class ClearCustomerDetailsFromStorage {
  ClearCustomerDetailsFromStorage({
    required DataStorage dataStorage,
    required CustomerDetailsRepository customerDetailsRepository,
  })  : _dataStorage = dataStorage,
        _customerDetailsRepository = customerDetailsRepository;

  final DataStorage _dataStorage;
  final CustomerDetailsRepository _customerDetailsRepository;

  Future<void> call() async {
    await _dataStorage.setString('api_key', '');
    await _customerDetailsRepository.clearAllData();
  }
}
