// ignore_for_file: avoid_redundant_argument_values
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:irri/app/app_colors.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/providers.dart';

class IrriApp extends HookConsumerWidget {
  const IrriApp({
    Key? key,
    required GoRouter router,
  })  : _router = router,
        super(key: key);

  final GoRouter _router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    useOnAppLifecycleStateChange((_, newState) {
      ref.read(appLifecycleStateProvider.notifier).setLifecycleState(newState);
    });
    return AuthListener(
      router: _router,
      child: MaterialApp.router(
        theme: _buildLightTheme(context),
        darkTheme: _buildDarkTheme(context),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        themeMode: appState.themeMode,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }
}

class AuthListener extends ConsumerWidget {
  const AuthListener({
    Key? key,
    required this.router,
    required this.child,
  }) : super(key: key);

  final GoRouter router;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (a, b) {
      if (b.isLoggedIn()) {
        router.go('/home');
      } else {
        router.go('/login');
      }
    });
    return child;
  }
}

ThemeData _buildLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: _lightColorScheme,
    textTheme: GoogleFonts.firaSansCondensedTextTheme(base.textTheme).copyWith(
      headline5: GoogleFonts.pacifico(textStyle: base.textTheme.headline5),
      headline4: GoogleFonts.pacifico(textStyle: base.textTheme.headline4),
    ),
  );
}

ThemeData _buildDarkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base.copyWith(
    colorScheme: _darkColorScheme,
    textTheme: GoogleFonts.firaSansCondensedTextTheme(base.textTheme).copyWith(
      headline5: GoogleFonts.pacifico(textStyle: base.textTheme.headline5),
      headline4: GoogleFonts.pacifico(textStyle: base.textTheme.headline4),
    ),
  );
}

ColorScheme _lightColorScheme = ColorScheme.fromSeed(
  seedColor: AppColors.pink,
  brightness: Brightness.light,
);

ColorScheme _darkColorScheme = ColorScheme.fromSeed(
  seedColor: AppColors.pink,
  brightness: Brightness.dark,
);
