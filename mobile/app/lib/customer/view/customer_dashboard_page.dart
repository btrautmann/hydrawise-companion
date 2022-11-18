import 'package:api_models/api_models.dart';
import 'package:clock/clock.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/extensions.dart';
import 'package:irri/programs/providers.dart';
import 'package:irri/zones/providers.dart';

class CustomerDashboardPage extends StatelessWidget {
  const CustomerDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: _CustomerDashboardView(),
      ),
    );
  }
}

class _CustomerDashboardView extends ConsumerWidget {
  const _CustomerDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(programsProvider).maybeWhen(
      data: (programs) {
        return _Runs(
          programs: programs,
        );
      },
      orElse: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _Runs extends StatelessWidget {
  const _Runs({
    Key? key,
    required this.programs,
  }) : super(key: key);

  final List<Program> programs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: _Greeting(),
        ),
        const VSpace(spacing: 16),
        _RunsList(
          programs: programs,
          onRunTapped: (run) {
            GoRouter.of(context).push('/zone/${run.zoneId}');
          },
        ),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateTime = clock.now();
    String text;
    if (dateTime.hour < 12) {
      text = 'Good morning';
    } else if (dateTime.hour < 18) {
      text = 'Good afternoon';
    } else {
      text = 'Good evening';
    }
    return Text(
      text,
      style: theme.textTheme.headline5,
    );
  }
}

class _RunsList extends ConsumerWidget {
  _RunsList({
    Key? key,
    required this.programs,
    required this.onRunTapped,
  })  : todayRuns = programs.todayRuns(),
        super(key: key);

  final List<Program> programs;
  final List<Run> todayRuns;
  final ValueSetter<Run> onRunTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zonesState = ref.watch(zonesProvider);
    return zonesState.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (_, __) => const Center(
        child: Text('Something went wrong.'),
      ),
      data: (zones) {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: zones.length,
          itemBuilder: (_, index) {
            final item = zones[index];
            return ListTile(
              title: Text(item.name),
            );
          },
        );
      },
    );
  }
}
