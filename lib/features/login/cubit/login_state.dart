part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState.loggedIn({
    required String apiKey,
  }) = _LoggedIn;

  factory LoginState.loggedOut() = _LoggedOut;
}