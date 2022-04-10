import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/auth/auth.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required IsLoggedIn isLoggedIn,
    required LogIn logIn,
    required LogOut logOut,
    required GetAuthFailures getAuthFailures,
  })  : _isLoggedIn = isLoggedIn,
        _logIn = logIn,
        _logOut = logOut,
        _getAuthFailures = getAuthFailures,
        super(AuthState.loggedOut()) {
    _checkAuthenticationStatus();
    _listenForAuthFailures();
  }

  final IsLoggedIn _isLoggedIn;
  final LogIn _logIn;
  final LogOut _logOut;
  final GetAuthFailures _getAuthFailures;

  Future<void> _checkAuthenticationStatus() async {
    if (await _isLoggedIn()) {
      emit(AuthState.loggedIn());
    } else {
      emit(AuthState.loggedOut());
    }
  }

  Future<void> _listenForAuthFailures() async {
    await _getAuthFailures().then(
      (stream) => stream.listen((event) async {
        await _logOut();
        emit(AuthState.loggedOut());
      }),
    );
  }

  Future<bool> validateApiKey(String apiKey) {
    return _logIn(apiKey);
  }

  Future<void> login(String apiKey) async {
    final isLoggedIn = await _logIn(apiKey);
    if (isLoggedIn) {
      emit(AuthState.loggedIn());
      return;
    }
    // If we got here, either we failed to authenticate
    // with Hydrawise or Firebase
    // TODO(brandon): Handle auth failures
    await _logOut();
  }
}
