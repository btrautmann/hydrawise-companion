part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.loggedIn() = _LoggedIn;

  factory AuthState.loggedOut() = _LoggedOut;
}

extension AuthStateX on AuthState {
  bool isLoggedIn() {
    return when(loggedIn: () => true, loggedOut: () => false);
  }
}
