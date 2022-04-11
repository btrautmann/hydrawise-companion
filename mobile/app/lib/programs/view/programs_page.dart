import 'dart:developer';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ProgramsPageView(),
      ),
    );
  }
}

class ProgramsPageView extends StatelessWidget {
  const ProgramsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgramsCubit, ProgramsState>(
      listener: (context, state) {
        if (state.pendingDeletes.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Deleting programs is permanent'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<ProgramsCubit>().deletePending();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ProgramsCubit>().resetPrograms();
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  )
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
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
              Expanded(
                flex: 2,
                child: BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      complete: (details, status) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: _ZoneList(
                            zones: status.zones,
                            onZoneTapped: (zone) {
                              log('$zone tapped');
                            },
                          ),
                        );
                      },
                      orElse: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: _Programs(),
              ),
            ],
          ),
        );
      },
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

class _Programs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramsCubit, ProgramsState>(
      builder: (context, state) {
        return Column(
          children: [
            Visibility(visible: state.programs.isEmpty, child: const Spacer()),
            Visibility(
              visible: state.programs.isEmpty,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No programs'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push('/create_program');
                        },
                        child: const Text('Create Program'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: state.programs.isNotEmpty,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.programs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Dismissible(
                              background: ColoredBox(
                                color: Theme.of(context).errorColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              direction: DismissDirection.startToEnd,
                              key: ObjectKey(state.programs[index]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 4),
                                child: ListRow(
                                  leadingIcon: CircleBackground(
                                    child: Text(
                                      state.programs[index].name.characters
                                          .first,
                                    ),
                                  ),
                                  title: Text(state.programs[index].name),
                                  onTapped: () {
                                    GoRouter.of(context).push(
                                      '/update_program/${state.programs[index].id}',
                                    );
                                  },
                                ),
                              ),
                              onDismissed: (direction) {
                                context
                                    .read<ProgramsCubit>()
                                    .addToPendingDeletes(state.programs[index]);
                              },
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).push('/create_program');
                    },
                    child: const Text('Add Program'),
                  )
                ],
              ),
            ),
            Visibility(visible: state.programs.isEmpty, child: const Spacer()),
          ],
        );
      },
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      primary: false,
      itemCount: zones.length,
      itemBuilder: (_, index) {
        return ZoneCell(
          zone: zones[index],
          onZoneTapped: onZoneTapped,
        );
      },
    );
  }
}
