import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/auth/providers.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      GoRouter.of(context).go(next.isAuthenticated ? '/home' : '/login');
    });
    return const CircularProgressIndicator();
  }
}
