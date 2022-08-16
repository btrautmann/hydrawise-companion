import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/configuration/configuration.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required IsLoggedIn isLoggedIn,
    required LogIn logIn,
    required LogOut logOut,
    required GetAuthFailures getAuthFailures,
    required GetLocalTimezone getLocalTimezone,
  })  : _isLoggedIn = isLoggedIn,
        _logIn = logIn,
        _logOut = logOut,
        _getAuthFailures = getAuthFailures,
        _getLocalTimezone = getLocalTimezone,
        super(AuthState.loggedOut()) {
    _checkAuthenticationStatus();
    _listenForAuthFailures();
  }

  final IsLoggedIn _isLoggedIn;
  final LogIn _logIn;
  final LogOut _logOut;
  final GetAuthFailures _getAuthFailures;
  final GetLocalTimezone _getLocalTimezone;

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

  Future<void> login(String apiKey) async {
    final timeZone = await _getLocalTimezone();
    final isLoggedIn = await _logIn(apiKey, timeZone);
    if (isLoggedIn) {
      emit(AuthState.loggedIn());
      return;
    }
    // If we got here, we failed to authenticate
    // with Hydrawise
    // TODO(brandon): Handle auth failures
    await _logOut();
  }
}
