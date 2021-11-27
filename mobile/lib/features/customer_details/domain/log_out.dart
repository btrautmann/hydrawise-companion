import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';

class LogOut {
  LogOut({
    required SetApiKey setApiKey,
    required FirebaseAuth auth,
    required SetFirebaseUid setFirebaseUid,
    required CustomerDetailsRepository customerDetailsRepository,
  })  : _setApiKey = setApiKey,
        _auth = auth,
        _setFirebaseUid = setFirebaseUid,
        _customerDetailsRepository = customerDetailsRepository;

  final SetApiKey _setApiKey;
  final FirebaseAuth _auth;
  final SetFirebaseUid _setFirebaseUid;
  final CustomerDetailsRepository _customerDetailsRepository;

  Future<void> call() async {
    await _customerDetailsRepository.clearAllData();
    await _setApiKey('');
    await _setFirebaseUid('');
    await _auth.signOut();
  }
}

class FakeLogOut implements LogOut {
  FakeLogOut({
    required CustomerDetailsRepository customerDetailsRepository,
    required SetApiKey setApiKey,
    required SetFirebaseUid setFirebaseUid,
  })  : _customerDetailsRepository = customerDetailsRepository,
        _setFirebaseUid = setFirebaseUid,
        _setApiKey = setApiKey;

  @override
  final CustomerDetailsRepository _customerDetailsRepository;
  @override
  final SetFirebaseUid _setFirebaseUid;
  @override
  final SetApiKey _setApiKey;

  @override
  FirebaseAuth get _auth => throw UnimplementedError();

  @override
  Future<void> call() async {
    await _customerDetailsRepository.clearAllData();
    await _setApiKey('');
    await _setFirebaseUid('');
  }
}
