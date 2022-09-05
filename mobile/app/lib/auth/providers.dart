import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/app/app.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/customer_details/customer_details.dart';

part 'providers.freezed.dart';

final getApiKeyProvider = Provider<GetApiKey>((ref) {
  final storage = ref.watch(storageProvider);
  return GetApiKey(storage);
});

final setApiKeyProvider = Provider<SetApiKey>((ref) {
  return SetApiKey(
    ref.watch(storageProvider),
  );
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
    customerDetailsRepository: ref.watch(customerDetailsRepositoryProvider),
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

  Future<void> login(String apiKey) async {
    final timeZone = await _getLocalTimezone();
    final isLoggedIn = await _logIn(apiKey, timeZone);
    if (isLoggedIn) {
      state = AuthState.loggedIn();
      return;
    }
    // TODO(brandon): Handle auth failures gracefully
    await _logOut();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier(
      isLoggedIn: ref.watch(isLoggedInProvider),
      logIn: ref.watch(logInProvider),
      logOut: ref.watch(logOutProvider),
      getAuthFailures: GetAuthFailures(
        authFailuresController: ref.watch(authFailuresProvider),
      ),
      getLocalTimezone: GetLocalTimezone(),
    );
  },
);
