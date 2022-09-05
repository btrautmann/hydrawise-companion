import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/app/app.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ConfigurationView(),
      ),
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Text(
            'Configuration',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        _AppThemeRow(),
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
    return ListRow(
      leadingIcon: CircleBackground(child: icon),
      title: const Text('App theme'),
      onTapped: () => showDialog<void>(
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
            ListRow(
              leadingIcon: const CircleBackground(
                child: Icon(Icons.light_mode),
              ),
              title: const Text('Light mode'),
              onTapped: () {
                ref.read(appStateProvider.notifier).setThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListRow(
              leadingIcon: const CircleBackground(
                child: Icon(Icons.dark_mode),
              ),
              title: const Text('Dark mode'),
              onTapped: () {
                ref.read(appStateProvider.notifier).setThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListRow(
              leadingIcon: const CircleBackground(
                child: Icon(Icons.settings),
              ),
              title: const Text('Follow system'),
              onTapped: () {
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
