import 'package:api_models/api_models.dart';
import 'package:clock/clock.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irri/programs/programs.dart';
import 'package:irri/zones/providers.dart';

class CustomerDashboardPage extends StatelessWidget {
  const CustomerDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomerDashboardView();
  }
}

class CustomerDashboardView extends StatelessWidget {
  const CustomerDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: _CustomerDashboardStateView(),
      ),
    );
  }
}

class _CustomerDashboardStateView extends ConsumerWidget {
  const _CustomerDashboardStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(programsProvider).maybeWhen(
      data: (programs) {
        return SingleChildScrollView(
          child: _AllCustomerContent(
            programs: programs,
          ),
        );
      },
      orElse: () {
        return const CircularProgressIndicator();
      },
    );
  }
}

class _AllCustomerContent extends StatelessWidget {
  const _AllCustomerContent({
    Key? key,
    required this.programs,
  }) : super(key: key);

  final List<Program> programs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: const [
                _Greeting(),
              ],
            ),
          ),
          _RunsList(
            programs: programs,
            onRunTapped: (run) {
              GoRouter.of(context).push('/zone/${run.zoneId}');
            },
          ),
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HStretch(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Watering Schedule',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: zonesState.maybeWhen(
                data: (zones) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: todayRuns.isEmpty,
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No more runs today'),
                        ),
                      ),
                      Visibility(
                        visible: todayRuns.isNotEmpty,
                        child: ListView.builder(
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: todayRuns.length,
                          itemBuilder: (_, index) {
                            return _RunCell(
                              zone: zones.singleWhere(
                                (z) => z.id == todayRuns[index].zoneId,
                              ),
                              program: programs.singleWhere(
                                (p) => p.id == todayRuns[index].programId,
                              ),
                              run: todayRuns[index],
                              shouldShowDivider: index != todayRuns.length - 1,
                              onRunTapped: onRunTapped,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                orElse: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RunCell extends StatelessWidget {
  const _RunCell({
    Key? key,
    required this.zone,
    required this.program,
    required this.run,
    required this.shouldShowDivider,
    required this.onRunTapped,
  }) : super(key: key);

  final Program program;
  final Zone zone;
  final Run run;
  final bool shouldShowDivider;
  final ValueSetter<Run> onRunTapped;

  String formattedTimeOfNextRun(BuildContext context) {
    if (zone.isRunning) {
      return 'Running now';
    }
    return TimeOfDay(hour: run.startHour, minute: run.startMinute)
        .format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text('${zone.name} at ${formattedTimeOfNextRun(context)}'),
          subtitle: Text(program.name),
          onTap: () => onRunTapped(run),
        ),
        if (shouldShowDivider)
          const Divider(
            indent: 16,
          ),
      ],
    );
  }
}
