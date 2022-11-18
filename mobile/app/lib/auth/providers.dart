import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/domain/get_api_key.dart';
import 'package:irri/auth/domain/is_logged_in.dart';
import 'package:irri/auth/domain/set_api_key.dart';
import 'package:irri/auth/log_in/log_in.dart';
import 'package:irri/auth/log_out/log_out.dart';

final getApiKeyProvider = Provider<GetApiKey>((ref) {
  return GetApiKey(ref.watch(storageProvider));
});

final setApiKeyProvider = Provider<SetApiKey>((ref) {
  return SetApiKey(ref.watch(storageProvider));
});

final isLoggedInProvider = Provider<IsLoggedIn>((ref) {
  return IsLoggedIn(
    getApiKey: ref.watch(getApiKeyProvider),
  );
});

final logInProvider = Provider<LogIn>((ref) {
  return LogIn(
    httpClient: ref.watch(httpClientProvider),
    setApiKey: ref.watch(setApiKeyProvider),
  );
});

final logOutProvider = Provider<LogOut>((ref) {
  return LogOut(
    setApiKey: ref.watch(setApiKeyProvider),
  );
});

class AuthState {
  AuthState({required this.isAuthenticated});

  final bool isAuthenticated;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required IsLoggedIn isLoggedIn,
    required LogOut logOut,
  })  : _isLoggedIn = isLoggedIn,
        _logOut = logOut,
        super(AuthState(isAuthenticated: false)) {
    _checkAuthenticationStatus();
  }

  final IsLoggedIn _isLoggedIn;
  final LogOut _logOut;

  Future<void> _checkAuthenticationStatus() async {
    final isLoggedIn = await _isLoggedIn();
    state = AuthState(isAuthenticated: isLoggedIn);
  }

  Future<void> logOut() async {
    return _logOut();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier(
      isLoggedIn: ref.watch(isLoggedInProvider),
      logOut: ref.watch(logOutProvider),
    );
  },
);
