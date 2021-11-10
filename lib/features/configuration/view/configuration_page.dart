import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/app/cubit/app_cubit.dart';
import 'package:hydrawise/core-ui/core_ui.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

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
          child: Row(
            children: [
              Text(
                'Configuration',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
            builder: (context, state) {
              return state.maybeWhen(
                complete: (details, status) {
                  return _ZoneList(
                    zones: status.zones,
                    onZoneTapped: (zone) {},
                  );
                },
                orElse: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final currentThemeMode = state.themeMode;
              Icon icon;
              final color = Theme.of(context).colorScheme.onSecondary;
              switch (currentThemeMode) {
                case ThemeMode.system:
                  icon = Icon(Icons.settings, color: color);
                  break;
                case ThemeMode.light:
                  icon = Icon(Icons.light_mode, color: color);
                  break;
                case ThemeMode.dark:
                  icon = Icon(Icons.dark_mode, color: color);
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
    final color = Theme.of(context).colorScheme.onSecondary;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListRow(
              leadingIcon: CircleBackground(
                child: Icon(
                  Icons.light_mode,
                  color: color,
                ),
              ),
              title: const Text('Light mode'),
              onTapped: () {
                context.read<AppCubit>().setThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListRow(
              leadingIcon: CircleBackground(
                child: Icon(
                  Icons.dark_mode,
                  color: color,
                ),
              ),
              title: const Text('Dark mode'),
              onTapped: () {
                context.read<AppCubit>().setThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListRow(
              leadingIcon: CircleBackground(
                child: Icon(
                  Icons.settings,
                  color: color,
                ),
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

class _ZoneList extends StatelessWidget {
  const _ZoneList({
    Key? key,
    required this.zones,
    required this.onZoneTapped,
  }) : super(key: key);

  final List<Zone> zones;
  final ValueSetter<Zone> onZoneTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: zones.length,
          itemBuilder: (_, index) {
            return _ZoneCell(
              zone: zones[index],
              onZoneTapped: onZoneTapped,
            );
          },
        ),
      ],
    );
  }
}

class _ZoneCell extends StatelessWidget {
  const _ZoneCell({
    Key? key,
    required this.zone,
    required this.onZoneTapped,
  }) : super(key: key);

  final Zone zone;
  final ValueSetter<Zone> onZoneTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListRow(
          leadingIcon: CircleBackground(
            child: Text(zone.physicalNumber.toString()),
          ),
          title: Text(zone.name),
          onTapped: () => onZoneTapped(zone),
        ),
        const Divider(
          indent: 16,
        ),
      ],
    );
  }
}
