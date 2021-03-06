import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/developer/developer.dart';
import 'package:irri/error_page.dart';
import 'package:irri/home/home.dart';
import 'package:irri/programs/programs.dart';
import 'package:irri/run_zone/run_zone.dart';
import 'package:irri/splash_page.dart';

class BuildAppRouter {
  BuildAppRouter();

  Future<GoRouter> call() async => GoRouter(
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
            },
          ),
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
          GoRoute(
            path: '/update_program/:pid',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: CreateProgramPage(
                existingProgramId: int.parse(state.params['pid']!),
              ),
            ),
          ),
          GoRoute(
            path: '/developer',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const DeveloperPage(),
            ),
          ),
        ],
        errorPageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ErrorPage(exception: state.error),
        ),
      );
}
