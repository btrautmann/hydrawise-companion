import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrawise/features/error_page.dart';
import 'package:hydrawise/features/home/home.dart';
import 'package:hydrawise/features/login/login.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:hydrawise/features/splash_page.dart';

/// Contract for building the [GoRouter] that the app
/// will use for all of its navigation
abstract class BuildRouter {
  Future<GoRouter> call();
}

class BuildStandardRouter implements BuildRouter {
  BuildStandardRouter();

  @override
  Future<GoRouter> call() async {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const SplashPage(),
          ),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const LoginPage(),
            transitionsBuilder: (_, __, ___, child) => child,
          ),
        ),
        // Allow for `/home` to be invoked by itself so
        // we can decide the "default" tab in one place
        GoRoute(
          path: '/home',
          redirect: (state) => '/home/0',
        ),
        GoRoute(
            path: '/home/:tid',
            pageBuilder: (context, state) {
              final tabIndex = state.params['tid'] ?? '0';
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: HomePage(
                  selectedTabIndex: int.parse(tabIndex),
                ),
                transitionsBuilder: (_, __, ___, child) => child,
              );
            }),
        GoRoute(
          path: '/zone/:zid',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RunZonesPage(
              zoneId: int.parse(state.params['zid']!),
            ),
          ),
        ),
        GoRoute(
          path: '/create_program',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const CreateProgramPage(),
          ),
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: ErrorPage(exception: state.error),
      ),
    );
  }
}
