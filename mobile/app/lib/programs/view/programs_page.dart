import 'package:api_models/api_models.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/providers.dart';
import 'package:irri/zones/providers.dart';
import 'package:irri/zones/update_zone/update_zone.dart';

class ProgramsPage extends ConsumerWidget {
  const ProgramsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const SafeArea(
        child: ProgramsPageView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            GoRouter.of(context).go('/home/create_program'),
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
              'Irri',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
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
                    '- Tapping a Zone should bring up Run Zone, and allow for updates via a menu\n '
                    '- Show menu on right of each cell allowing for updates ',
                  ),
                ),
              ),
            ),
          ),
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

class RenameZoneDialog extends HookConsumerWidget {
  const RenameZoneDialog({
    Key? key,
    required Zone zone,
  })  : _zone = zone,
        super(key: key);

  final Zone _zone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final controllerUpdates = useValueListenable(controller);
    ref.listen<AsyncValue<Object?>>(
      updateZoneControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
        data: (isSuccessful) {
          if (isSuccessful != null) {
            if (isSuccessful == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Oops! Something went wrong.')),
              );
            } else {
              Navigator.pop(context);
            }
          }
        },
      ),
    );
    final isLoading = ref.watch(updateZoneControllerProvider).isLoading;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              textAlign: TextAlign.left,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(.1),
                hintText: 'Rename ${_zone.name}',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            Visibility(
              child: TextButton(
                onPressed: isLoading || controllerUpdates.text.isEmpty
                    ? null
                    : () {
                        ref.read(updateZoneControllerProvider.notifier).updateZone(zone: _zone, name: controller.text);
                      },
                child: const Text('Done'),
              ),
            )
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
            onTap: () {
              showDialog(context: context, builder: (_) => RenameZoneDialog(zone: item));
            },
          );
        } else if (item is Program) {
          return ListTile(
            title: Text(item.name),
            onTap: () => GoRouter.of(context).go(
              '/home/update_program/${item.id}',
            ),
          );
        }
        throw Exception('Item not a zone or program');
      },
    );
  }
}
