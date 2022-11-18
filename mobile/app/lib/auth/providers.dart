import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/domain/get_api_key.dart';
import 'package:irri/auth/domain/is_logged_in.dart';
import 'package:irri/auth/domain/set_api_key.dart';
import 'package:irri/auth/log_in/log_in.dart';
import 'package:irri/auth/log_out/log_out.dart';

part 'providers.freezed.dart';

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

@freezed
class AuthState with _$AuthState {
  factory AuthState.loggedIn() = _LoggedIn;
  factory AuthState.loggedOut() = _LoggedOut;
}

extension AuthStateX on AuthState {
  bool isLoggedIn() {
    return map(loggedIn: (_) => true, loggedOut: (_) => false);
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required IsLoggedIn isLoggedIn,
    required LogOut logOut,
  })  : _isLoggedIn = isLoggedIn,
        _logOut = logOut,
        super(AuthState.loggedOut()) {
    _checkAuthenticationStatus();
  }

  final IsLoggedIn _isLoggedIn;
  final LogOut _logOut;

  Future<void> _checkAuthenticationStatus() async {
    if (await _isLoggedIn()) {
      state = AuthState.loggedIn();
    } else {
      state = AuthState.loggedOut();
    }
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
