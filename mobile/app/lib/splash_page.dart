import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/auth/providers.dart';

/// Initial page of the app places as the `home` of the
/// MaterialApp. The sole responsibility is to determine
/// authentication state and route the user to the correct
/// location in the app.
class SplashPage extends ConsumerWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.when(
        loggedIn: () => GoRouter.of(context).go('/home'),
        loggedOut: () => GoRouter.of(context).go('/login'),
      );
    });
    return const CircularProgressIndicator();
  }
}
