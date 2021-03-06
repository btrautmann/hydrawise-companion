import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:irri/auth/auth.dart';

/// Initial page of the app places as the `home` of the
/// MaterialApp. The sole responsibility is to determine
/// authentication state and route the user to the correct
/// location in the app.
class SplashPage extends StatelessWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      listener: (context, state) {
        state.when(
          loggedIn: () => GoRouter.of(context).go('/home'),
          loggedOut: () => GoRouter.of(context).go('/login'),
        );
      },
    );
  }
}
