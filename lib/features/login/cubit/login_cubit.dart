import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/login/login.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final GetApiKey _getApiKey;
  final SetApiKey _setApiKey;
  final GetCustomerDetails _getCustomerDetails;
  final ClearCustomerDetails _clearCustomerDetails;
  final GetAuthFailures _getAuthFailures;

  LoginCubit({
    required GetApiKey getApiKey,
    required SetApiKey setApiKey,
    required GetCustomerDetails getCustomerDetails,
    required ClearCustomerDetails clearCustomerDetails,
    required GetAuthFailures getAuthFailures,
  })  : _getApiKey = getApiKey,
        _setApiKey = setApiKey,
        _getCustomerDetails = getCustomerDetails,
        _clearCustomerDetails = clearCustomerDetails,
        _getAuthFailures = getAuthFailures,
        super(LoginState.loggedOut()) {
    _checkAuthenticationStatus();
    _listenForAuthFailures();
  }

  void _listenForAuthFailures() async {
    await _getAuthFailures().then(
      (stream) => stream.listen((event) {
        emit(LoginState.loggedOut());
      }),
    );
  }

  void _checkAuthenticationStatus() async {
    final apiKey = await _getApiKey();
    if (apiKey != null && apiKey.isNotEmpty) {
      emit(LoginState.loggedIn(apiKey: apiKey));
    } else {
      emit(LoginState.loggedOut());
    }
  }

  Future<void> logOut() async {
    await _clearCustomerDetails();
    emit(LoginState.loggedOut());
  }

  Future<void> login(String apiKey) async {
    await _setApiKey(apiKey);
    final detailsResult = await _getCustomerDetails();
    if (detailsResult.isSuccess) {
      emit(LoginState.loggedIn(apiKey: apiKey));
    } else {
      // TODO(brandon): Handle auth failures
    }
  }
}
