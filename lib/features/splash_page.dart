import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrawise/features/login/login.dart';

/// Initial page of the app places as the `home` of the
/// MaterialApp. The sole responsibility is to determine
/// authentication state and route the user to the correct
/// location in the app.
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.when(
          loggedOut: () => GoRouter.of(context).go('/login'),
          loggedIn: (_) => GoRouter.of(context).go('/home'),
        );
      },
      child: const Scaffold(),
    );
  }
}
