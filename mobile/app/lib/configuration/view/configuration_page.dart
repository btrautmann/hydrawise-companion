import 'dart:developer';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:irri/app/cubit/app_cubit.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/push_notifications/push_notifications.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ConfigurationCubit(
            getPushNotificationsEnabled:
                context.read<GetPushNotificationsEnabled>(),
            getLocalTimezone: context.read<GetLocalTimezone>(),
            getAvailableTimezones: context.read<GetAvailableTimezones>(),
            registerForPushNotifications:
                context.read<RegisterForPushNotifications>(),
            unregisterForPushNotifications:
                context.read<UnregisterForPushNotifications>(),
            getUserTimezone: context.read<GetUserTimezone>(),
            updateUserTimeZone: context.read<UpdateUserTimeZone>(),
          ),
          child: const ConfigurationView(),
        ),
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
        const Divider(
          indent: 16,
        ),
        _PushNotificationsRow(),
        const Divider(
          indent: 16,
        ),
        _ChangeTimeZoneRow(),
        const Divider(
          indent: 16,
        ),
        Visibility(
          visible: false,
          child: _ChangeApiKeyRow(),
        ),
      ],
    );
  }
}

class _AppThemeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
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

class _PushNotificationsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationCubit, ConfigurationState>(
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
            if (state.pushNotificationsEnabled) {
              context
                  .read<ConfigurationCubit>()
                  .unregisterForPushNotifications();
            } else {
              context.read<ConfigurationCubit>().registerForPushNotifications();
            }
          },
        );
      },
    );
  }
}

class _ChangeApiKeyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListRow(
      leadingIcon: const CircleBackground(
        child: Icon(Icons.lock),
      ),
      title: const Text('Change API key'),
      onTapped: () => showDialog<void>(
        context: context,
        builder: (_) => const _ChangeApiKeyDialog(),
      ),
    );
  }
}

class _ChangeApiKeyDialog extends StatefulWidget {
  const _ChangeApiKeyDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<_ChangeApiKeyDialog> createState() => _ChangeApiKeyDialogState();
}

class _ChangeApiKeyDialogState extends State<_ChangeApiKeyDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Hydrawise API key',
                ),
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ),
            TextButton(
              onPressed: _controller.text.isEmpty
                  ? null
                  : () => context
                      .read<AuthCubit>()
                      .login(_controller.text),
              child: const Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangeTimeZoneRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationCubit, ConfigurationState>(
      builder: (context, state) {
        final rowText = state.timeZone ?? 'Set timezone';
        return ListRow(
          leadingIcon: const CircleBackground(
            child: Icon(Icons.map),
          ),
          title: Text(rowText),
          onTapped: () => showDialog<void>(
            context: context,
            builder: (_) => _ChangeTimeZoneDialog(
              onTimezoneSelected: (timezone) {
                context.read<ConfigurationCubit>().updateUserTimezone(timezone);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

class _ChangeTimeZoneDialog extends StatefulWidget {
  const _ChangeTimeZoneDialog({
    Key? key,
    required ValueSetter<String> onTimezoneSelected,
  })  : _onTimezoneSelected = onTimezoneSelected,
        super(key: key);

  final ValueSetter<String> _onTimezoneSelected;

  @override
  State<_ChangeTimeZoneDialog> createState() => _ChangeTimeZoneDialogState();
}

class _ChangeTimeZoneDialogState extends State<_ChangeTimeZoneDialog> {
  late String _timezone;
  List<String> _availableTimezones = <String>[];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // TODO(brandon): This is yuck, make a Cubit later
  Future<void> _initData() async {
    try {
      _timezone = await FlutterNativeTimezone.getLocalTimezone();
    } on Exception catch (e) {
      log(e.toString());
    }
    try {
      _availableTimezones = await FlutterNativeTimezone.getAvailableTimezones();
      _availableTimezones.sort();
    } on Exception catch (e) {
      log(e.toString());
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO(brandon): Move this out of the scrolling portion
              ButtonBar(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: _availableTimezones.length,
                itemBuilder: (context, index) {
                  final timeZone = _availableTimezones[index];
                  final isUserTimeZone = _timezone == timeZone;
                  return InkWell(
                    onTap: () => widget._onTimezoneSelected(timeZone),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(timeZone),
                          const Spacer(),
                          Visibility(
                            visible: isUserTimeZone,
                            child: const Icon(Icons.check),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
