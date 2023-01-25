import 'package:api_models/api_models.dart';
import 'package:clock/clock.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/providers.dart';

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
        return _TodayRuns(
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

class _TodayRuns extends StatelessWidget {
  const _TodayRuns({
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
        Padding(
          padding: const EdgeInsets.all(16),
          child: HStretch(
            child: ColoredBox(
              color: Colors.yellow.withAlpha(50),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '// TODO: \n'
                  '- Show zones scheduled for today as a stacked deck',
                ),
              ),
            ),
          ),
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
      style: theme.textTheme.headlineSmall,
    );
  }
}
