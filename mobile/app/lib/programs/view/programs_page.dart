import 'package:api_models/api_models.dart';
import 'package:collection/collection.dart';
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
    return const Scaffold(
      body: SafeArea(child: ProgramsPageView()),
    );
  }
}

class ProgramsPageView extends ConsumerWidget {
  const ProgramsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Irri',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(
                onPressed: () => GoRouter.of(context).go('/home/configuration'),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
        const Align(child: _ZonesAndPrograms()),
      ],
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
  const _ZonesAndPrograms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsState = ref.watch(programsProvider);
    final zonesState = ref.watch(zonesProvider);

    final zonesError = zonesState.error;
    final programsError = programsState.error;

    if (zonesError != null || programsError != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(zonesError.toString()),
          Text(programsError.toString()),
        ],
      );
    }

    if (zonesState.isLoading || programsState.isLoading) {
      return const CircularProgressIndicator();
    }

    final zones = zonesState.asData!.value.toList()
      ..sortByCompare(
        (z) => z.number,
        (a, b) => a.compareTo(b),
      );
    final programs = programsState.asData!.value.toList()
      ..sortByCompare(
        (p) => p.name,
        (a, b) => a.compareTo(b),
      );

    final zonesAndPrograms = [...zones, ...programs, 1];

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: zonesAndPrograms.length,
      itemBuilder: (context, index) {
        final item = zonesAndPrograms[index];
        if (item is Zone) {
          return ListTile(
            title: Text(item.name),
            leading: CircleBackground(
              color: Theme.of(context).colorScheme.secondary,
              child: Text(item.number.toString()),
            ),
            trailing: PopupMenuButton(
              onSelected: (_) {
                showDialog(
                  context: context,
                  builder: (_) => RenameZoneDialog(zone: item),
                );
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Rename',
                  child: Text('Rename'),
                ),
              ],
            ),
            onTap: () => GoRouter.of(context).go('/home/zone/${item.id}'),
          );
        } else if (item is Program) {
          return ListTile(
            leading: CircleBackground(
              color: Theme.of(context).colorScheme.tertiary,
              child: Text(item.name.characters.first),
            ),
            title: Text(item.name),
            onTap: () => GoRouter.of(context).go('/home/update_program/${item.id}'),
          );
        } else {
          return ListTile(
            leading: CircleBackground(
              color: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add),
            ),
            title: const Text('Add Program'),
            subtitle: const Text('Create a new irrigation program'),
            onTap: () => GoRouter.of(context).go('/home/create_program'),
          );
        }
      },
    );
  }
}
