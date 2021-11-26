import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required GetApiKey getApiKey,
    required SetApiKey setApiKey,
    required GetFirebaseUid getFirebaseUid,
    required SetFirebaseUid setFirebaseUid,
    required AuthenticateWithFirebase authenticateWithFirebase,
    required GetCustomerDetails getCustomerDetails,
    required ClearCustomerDetails clearCustomerDetails,
    required GetAuthFailures getAuthFailures,
  })  : _getApiKey = getApiKey,
        _setApiKey = setApiKey,
        _getFirebaseUid = getFirebaseUid,
        _setFirebaseUid = setFirebaseUid,
        _authenticateWithFirebase = authenticateWithFirebase,
        _getCustomerDetails = getCustomerDetails,
        _clearCustomerDetails = clearCustomerDetails,
        _getAuthFailures = getAuthFailures,
        super(AuthState.loggedOut()) {
    _checkAuthenticationStatus();
    _listenForAuthFailures();
  }

  final GetApiKey _getApiKey;
  final SetApiKey _setApiKey;
  final GetFirebaseUid _getFirebaseUid;
  final SetFirebaseUid _setFirebaseUid;
  final AuthenticateWithFirebase _authenticateWithFirebase;
  final GetCustomerDetails _getCustomerDetails;
  final ClearCustomerDetails _clearCustomerDetails;
  final GetAuthFailures _getAuthFailures;

  Future<void> _listenForAuthFailures() async {
    await _getAuthFailures().then(
      (stream) => stream.listen((event) {
        emit(AuthState.loggedOut());
      }),
    );
  }

  Future<void> _checkAuthenticationStatus() async {
    final apiKey = await _getApiKey();
    final uId = await _getFirebaseUid();
    if (apiKey != null && apiKey.isNotEmpty && uId != null && uId.isNotEmpty) {
      emit(AuthState.loggedIn());
    } else {
      await logOut();
    }
  }

  Future<void> logOut() async {
    await _clearCustomerDetails();
    // TODO(brandon): Un-authenticate with Firebase
    emit(AuthState.loggedOut());
  }

  Future<void> login(String apiKey) async {
    final uId = await _authenticateWithFirebase();
    if (uId != null) {
      await _setFirebaseUid(uId);
      await _setApiKey(apiKey);
      final detailsResult = await _getCustomerDetails();
      if (detailsResult.isSuccess) {
        emit(AuthState.loggedIn());
        return;
      }
    }
    // If we got here, either we failed to authenticate
    // with Hydrawise or Firebase
    // TODO(brandon): Handle auth failures
    await logOut();
  }
}
