import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/app/app.dart';
import 'package:irri/auth/auth.dart';

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
    required GetAuthFailures getAuthFailures,
  })  : _isLoggedIn = isLoggedIn,
        _logOut = logOut,
        _getAuthFailures = getAuthFailures,
        super(AuthState.loggedOut()) {
    _checkAuthenticationStatus();
    _listenForAuthFailures();
  }

  final IsLoggedIn _isLoggedIn;
  final LogOut _logOut;
  final GetAuthFailures _getAuthFailures;

  Future<void> _checkAuthenticationStatus() async {
    if (await _isLoggedIn()) {
      state = AuthState.loggedIn();
    } else {
      state = AuthState.loggedOut();
    }
  }

  Future<void> _listenForAuthFailures() async {
    await _getAuthFailures().then(
      (stream) => stream.listen((event) async {
        await _logOut();
        state = AuthState.loggedOut();
      }),
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier(
      isLoggedIn: ref.watch(isLoggedInProvider),
      logOut: ref.watch(logOutProvider),
      getAuthFailures: GetAuthFailures(
        authFailuresController: ref.watch(authFailuresProvider),
      ),
    );
  },
);
