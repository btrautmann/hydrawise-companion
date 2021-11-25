import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';

class ClearCustomerDetails {
  ClearCustomerDetails({
    required SetApiKey setApiKey,
    required SetFirebaseUid setFirebaseUid,
    required CustomerDetailsRepository customerDetailsRepository,
  })  : _setApiKey = setApiKey,
        _setFirebaseUid = setFirebaseUid,
        _customerDetailsRepository = customerDetailsRepository;

  final SetApiKey _setApiKey;
  final SetFirebaseUid _setFirebaseUid;
  final CustomerDetailsRepository _customerDetailsRepository;

  Future<void> call() async {
    await _setApiKey('');
    await _setFirebaseUid('');
    await _customerDetailsRepository.clearAllData();
  }
}
