import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';

class LogOut {
  LogOut({
    required SetApiKey setApiKey,
    required CustomerDetailsRepository customerDetailsRepository,
  })  : _setApiKey = setApiKey,
        _customerDetailsRepository = customerDetailsRepository;

  final SetApiKey _setApiKey;
  final CustomerDetailsRepository _customerDetailsRepository;

  Future<void> call() async {
    await _customerDetailsRepository.clearAllData();
    await _setApiKey('');
  }
}
