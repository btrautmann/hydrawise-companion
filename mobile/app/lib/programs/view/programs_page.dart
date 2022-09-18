import 'package:api_models/api_models.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/programs.dart';
import 'package:irri/zones/providers.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: ProgramsPageView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => GoRouter.of(context).push('/create_program'),
      ),
    );
  }
}

class ProgramsPageView extends ConsumerWidget {
  const ProgramsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zonesState = ref.watch(
      zonesProvider,
    );
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Irrigation',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const VSpace(spacing: 16),
          zonesState.maybeWhen(
            data: (zones) {
              return _ZonesAndPrograms(
                zones: zones,
              );
            },
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}

class ProgramDetailsDialog extends StatelessWidget {
  const ProgramDetailsDialog({
    Key? key,
    required Program program,
  })  : _program = program,
        super(key: key);

  final Program _program;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_program.name),
            Text(_program.frequency.toString()),
            Text(_program.runs.toString()),
          ],
        ),
      ),
    );
  }
}

class _ZonesAndPrograms extends ConsumerWidget {
  const _ZonesAndPrograms({
    Key? key,
    required this.zones,
  }) : super(key: key);

  final List<Zone> zones;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsState = ref.watch(programsProvider);
    final programs = programsState.asData?.value;

    final zonesAndPrograms = [
      ...zones,
      ...?programs,
    ];
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: zonesAndPrograms.length,
      itemBuilder: (_, index) {
        final item = zonesAndPrograms[index];
        if (item is Zone) {
          return ListTile(
            title: Text(item.name),
            onTap: () => GoRouter.of(context).push('/zone/${item.id}'),
          );
        } else if (item is Program) {
          return ListTile(
            title: Text(item.name),
            onTap: () => GoRouter.of(context).push(
              '/update_program/${item.id}',
            ),
          );
        }
        throw Exception('Item not a zone or program');
      },
    );
  }
}
