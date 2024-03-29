import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/log_out/log_out.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SafeArea(child: ConfigurationView()),
    );
  }
}

class ConfigurationView extends StatelessWidget {
  const ConfigurationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: HStretch(
            child: ColoredBox(
              color: Colors.yellow.withAlpha(50),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '// TODO: \n'
                  '- Allow for updating user time zone',
                ),
              ),
            ),
          ),
        ),
        _AppThemeRow(),
        const VSpace(spacing: 16),
        _LogOutRow(),
      ],
    );
  }
}

class _AppThemeRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appStateProvider).themeMode;
    Icon icon;
    switch (themeMode) {
      case ThemeMode.system:
        icon = const Icon(Icons.settings);
        break;
      case ThemeMode.light:
        icon = const Icon(Icons.light_mode);
        break;
      case ThemeMode.dark:
        icon = const Icon(Icons.dark_mode);
        break;
    }
    return ListTile(
      leading: CircleBackground(child: icon),
      title: const Text('App theme'),
      onTap: () => showDialog<void>(
        context: context,
        builder: (_) => const ChooseThemeModeDialog(),
      ),
    );
  }
}

class ChooseThemeModeDialog extends ConsumerWidget {
  const ChooseThemeModeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const CircleBackground(
                child: Icon(Icons.light_mode),
              ),
              title: const Text('Light mode'),
              onTap: () {
                ref.read(appStateProvider.notifier).setThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const CircleBackground(
                child: Icon(Icons.dark_mode),
              ),
              title: const Text('Dark mode'),
              onTap: () {
                ref.read(appStateProvider.notifier).setThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const CircleBackground(
                child: Icon(Icons.settings),
              ),
              title: const Text('Follow system'),
              onTap: () {
                ref.read(appStateProvider.notifier).setThemeMode(ThemeMode.system);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LogOutRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleBackground(
        child: Icon(
          Icons.logout,
        ),
      ),
      title: const Text('Log out'),
      onTap: () => showDialog<void>(
        context: context,
        builder: (_) => const LogOutDialog(),
      ),
    );
  }
}

class LogOutDialog extends ConsumerWidget {
  const LogOutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yesButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
        ref.read(logOutControllerProvider.notifier).logOut();
      },
      child: const Text('Yes'),
    );
    final noButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('No'),
    );
    return AlertDialog(
      content: const Text('Are you sure?'),
      actions: [yesButton, noButton],
    );
  }
}
