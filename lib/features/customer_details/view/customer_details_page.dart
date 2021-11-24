import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrawise/core-ui/core_ui.dart';
import 'package:hydrawise/core-ui/widgets/h_stretch.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/programs/cubit/programs_cubit.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:hydrawise/features/weather/weather.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomerDetailsView();
  }
}

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: _CustomerDetailsStateView(),
      ),
    );
  }
}

class _CustomerDetailsStateView extends StatelessWidget {
  const _CustomerDetailsStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramsCubit, ProgramsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: _AllCustomerContent(
            programs: state.programs,
          ),
        );
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
              children: [
                const _Greeting(),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().logOut();
                  },
                  icon: const Tooltip(
                    message: 'Log out',
                    child: Icon(Icons.logout),
                  ),
                )
              ],
            ),
          ),
          _RunsList(
            programs: programs,
            onRunTapped: (run) {
              GoRouter.of(context).push('/zone/${run.zoneId}');
            },
          ),
          const WeatherDetailsCard(),
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
    // TODO(brandon): Use a framework we can
    // modify under test for time
    final dateTime = DateTime.now();
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

class _RunsList extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              child: BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    complete: (_, state) {
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
                                  zone: state.zones.singleWhere(
                                    (z) => z.id == todayRuns[index].zoneId,
                                  ),
                                  program: programs.singleWhere(
                                    (p) => p.id == todayRuns[index].programId,
                                  ),
                                  run: todayRuns[index],
                                  shouldShowDivider:
                                      index != todayRuns.length - 1,
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
                  );
                },
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
    return run.startTime.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onRunTapped(run),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Hero(
                    tag: run,
                    child: CircleBackground(
                      child: Text(zone.physicalNumber.toString()),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(zone.name),
                    Text(
                      program.name,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(formattedTimeOfNextRun(context)),
              ],
            ),
          ),
        ),
        if (shouldShowDivider)
          const Divider(
            indent: 16,
          ),
      ],
    );
  }
}
