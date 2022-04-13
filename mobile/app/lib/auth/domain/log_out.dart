import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';

class LogOut {
  LogOut({
    required SetApiKey setApiKey,
    required UnauthenticateWithFirebase unauthenticateWithFirebase,
    required CustomerDetailsRepository customerDetailsRepository,
  })  : _setApiKey = setApiKey,
        _unauthenticateWithFirebase = unauthenticateWithFirebase,
        _customerDetailsRepository = customerDetailsRepository;

  final SetApiKey _setApiKey;
  final UnauthenticateWithFirebase _unauthenticateWithFirebase;
  final CustomerDetailsRepository _customerDetailsRepository;

  Future<void> call() async {
    await _customerDetailsRepository.clearAllData();
    await _unauthenticateWithFirebase();
    await _setApiKey('');
  }
}
