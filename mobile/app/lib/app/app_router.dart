import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irri/auth/view/login_page.dart';
import 'package:irri/configuration/view/configuration_page.dart';
import 'package:irri/error_page.dart';
import 'package:irri/programs/view/create_program_page.dart';
import 'package:irri/programs/view/programs_page.dart';
import 'package:irri/splash_page.dart';
import 'package:irri/zones/view/run_zone_page.dart';

GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const SplashPage(),
      ),
      routes: [
        GoRoute(
          path: 'login',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const LoginPage(),
          ),
        ),
        // Allow for `home` to be invoked by itself so
        // we can decide the "default" tab in one place
        GoRoute(
          path: 'home',
          pageBuilder: (context, state) {
            return const NoTransitionPage<void>(
              child: ProgramsPage(),
            );
          },
          routes: [
            GoRoute(
              path: 'zone/:zid',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: RunZonePage(
                  zoneId: int.parse(state.params['zid']!),
                ),
              ),
            ),
            GoRoute(
              path: 'create_program',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const CreateProgramPage(),
              ),
            ),
            GoRoute(
              path: 'update_program/:pid',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: CreateProgramPage(
                  existingProgramId: int.parse(state.params['pid']!),
                ),
              ),
            ),
            GoRoute(
              path: 'configuration',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const ConfigurationPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage<void>(
    key: state.pageKey,
    child: ErrorPage(exception: state.error),
  ),
);
