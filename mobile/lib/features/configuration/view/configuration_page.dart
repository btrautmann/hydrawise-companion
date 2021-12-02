import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irri/app/cubit/app_cubit.dart';
import 'package:irri/core-ui/core_ui.dart';
import 'package:irri/features/push_notifications/push_notifications.dart';

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
          padding: const EdgeInsets.all(16),
          child: Text(
            'Configuration',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final currentThemeMode = state.themeMode;
              Icon icon;
              switch (currentThemeMode) {
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
            },
          ),
        ),
        const Divider(
          indent: 16,
        ),
        BlocBuilder<PushNotificationsCubit, PushNotificationsState>(
          builder: (context, state) {
            final title = state.pushNotificationsEnabled
                ? 'Tap to turn off push notifications'
                : 'Tap to turn on push notifications';
            return ListRow(
              leadingIcon: const CircleBackground(
                child: Icon(
                  Icons.vibration_sharp,
                ),
              ),
              title: Text(title),
              onTapped: () {
                context
                    .read<PushNotificationsCubit>()
                    .registerForPushNotifications();
              },
            );
          },
        ),
      ],
    );
  }
}

class ChooseThemeModeDialog extends StatelessWidget {
  const ChooseThemeModeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                context.read<AppCubit>().setThemeMode(ThemeMode.light);
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
                context.read<AppCubit>().setThemeMode(ThemeMode.dark);
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
                context.read<AppCubit>().setThemeMode(ThemeMode.system);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
