import 'package:api_models/api_models.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide ChangeNotifierProvider;
import 'package:irri/programs/create_program/create_program.dart';
import 'package:irri/programs/extensions.dart';
import 'package:irri/programs/providers.dart';
import 'package:irri/programs/update_program/update_program.dart';
import 'package:irri/zones/providers.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class _ProgramCreation {
  _ProgramCreation({
    required this.name,
    required this.frequency,
    required this.runs,
    required this.runsValid,
  });

  final String name;
  final List<int> frequency;
  final List<RunCreation> runs;
  final bool runsValid;
}

class _ProgramNotifier extends ValueNotifier<_ProgramCreation> {
  _ProgramNotifier(_ProgramCreation initialProgram) : super(initialProgram);

  void updateFrequency(List<int> frequency) {
    value = _ProgramCreation(
      name: value.name,
      frequency: frequency,
      runs: value.runs,
      runsValid: value.runsValid,
    );
  }

  void updateRuns(List<RunCreation> runs) {
    value = _ProgramCreation(
      name: value.name,
      frequency: value.frequency,
      runs: runs,
      runsValid: value.runsValid,
    );
  }

  void updateName(String name) {
    value = _ProgramCreation(
      name: name,
      frequency: value.frequency,
      runs: value.runs,
      runsValid: value.runsValid,
    );
  }

  void updateRunValidity({required bool isValid}) {
    value = _ProgramCreation(
      name: value.name,
      frequency: value.frequency,
      runs: value.runs,
      runsValid: isValid,
    );
  }

  bool isValid() {
    return value.name.isNotEmpty && value.frequency.isNotEmpty && value.runs.isNotEmpty && value.runsValid;
  }
}

class CreateProgramPage extends ConsumerStatefulWidget {
  const CreateProgramPage({
    Key? key,
    this.existingProgramId,
  }) : super(key: key);

  final int? existingProgramId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProgramPageState();
  }
}

class _CreateProgramPageState extends ConsumerState<CreateProgramPage> {
  late _ProgramNotifier notifier;

  @override
  void initState() {
    final initial =
        widget.existingProgramId != null ? ref.read(existingProgramProvider(widget.existingProgramId)) : null;
    notifier = _ProgramNotifier(
      _ProgramCreation(
        name: initial == null ? '' : initial.asData!.value!.name,
        frequency: initial == null ? [] : initial.asData!.value!.frequency,
        runs: initial == null ? [] : initial.asData!.value!.runs.toRunCreations(),
        runsValid: true,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final existingProgram = ref.watch(
      existingProgramProvider(
        widget.existingProgramId,
      ),
    );
    return ChangeNotifierProvider<_ProgramNotifier>.value(
      value: notifier,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.existingProgramId == null ? 'Create Program' : 'Edit Program',
            ),
            actions: [
              Builder(
                builder: (context) {
                  return ValueListenableBuilder<_ProgramCreation>(
                    valueListenable: context.read<_ProgramNotifier>(),
                    builder: (context, value, state) {
                      if (value.runsValid) {
                        return IconButton(
                          onPressed: () {
                            if (widget.existingProgramId != null) {
                              ref.read(updateProgramControllerProvider.notifier).updateProgram(
                                    programId: widget.existingProgramId!,
                                    name: value.name,
                                    frequency: value.frequency,
                                    runGroups: value.runs,
                                  );
                            } else {
                              ref.read(createProgramControllerProvider.notifier).createProgram(
                                    name: value.name,
                                    frequency: value.frequency,
                                    runGroups: value.runs,
                                  );
                            }
                          },
                          icon: const Icon(Icons.done),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ],
            bottom: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(
                  text: 'Data',
                ),
                Tab(
                  text: 'Runs',
                )
              ],
              indicator: DotIndicator(
                color: Theme.of(context).colorScheme.secondary,
                distanceFromCenter: 16,
              ),
            ),
          ),
          body: _RequestListeners(
            child: TabBarView(
              children: [
                if (widget.existingProgramId == null) ...[
                  const _DataTab(
                    initialFrequency: [],
                    initialName: '',
                  ),
                  const _RunsTab(
                    initialrunGroups: [],
                  ),
                ],
                if (widget.existingProgramId != null) ...[
                  existingProgram.maybeWhen(
                    data: (program) {
                      return _DataTab(
                        initialFrequency: program!.frequency,
                        initialName: program.name,
                      );
                    },
                    orElse: CircularProgressIndicator.new,
                  ),
                  existingProgram.maybeWhen(
                    data: (program) {
                      return _RunsTab(
                        initialrunGroups: program!.runs.toRunCreations(),
                      );
                    },
                    orElse: CircularProgressIndicator.new,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RequestListeners extends ConsumerWidget {
  const _RequestListeners({required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<Object?>>(
        createProgramControllerProvider,
        (_, state) => state.whenOrNull(
          error: (error, stack) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
          data: (result) {
            if (result == success) {
              Navigator.pop(context);
            }
          },
        ),
      )
      ..listen<AsyncValue<Object?>>(
        updateProgramControllerProvider,
        (_, state) {
          state.whenOrNull(
            error: (error, stack) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.toString())),
              );
            },
            data: (result) {
              if (result == success) {
                Navigator.pop(context);
              }
            },
          );
        },
      );
    return child;
  }
}

class _DataTab extends ConsumerStatefulWidget {
  const _DataTab({
    Key? key,
    required this.initialFrequency,
    required this.initialName,
  }) : super(key: key);

  final List<int> initialFrequency;
  final String initialName;

  @override
  _DataTabState createState() {
    return _DataTabState();
  }
}

class _DataTabState extends ConsumerState<_DataTab> with AutomaticKeepAliveClientMixin {
  late List<int> _frequency;
  late TextEditingController _nameController;

  @override
  void initState() {
    _frequency = List.from(widget.initialFrequency);
    _nameController = TextEditingController(text: widget.initialName);
    super.initState();
  }

  void _updateFrequency(int day, bool? selected) {
    setState(() {
      if (selected ?? false) {
        _frequency.add(day);
      } else {
        _frequency.remove(day);
      }
      context.read<_ProgramNotifier>().updateFrequency(_frequency);
    });
  }

  void _updateName(String name) {
    setState(() {
      context.read<_ProgramNotifier>().updateName(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _nameController,
              onChanged: _updateName,
              decoration: const InputDecoration(
                hintText: 'Give your program a name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              'Run on:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Which days of the week should this program run?',
            ),
          ),
          CheckboxListTile(
            title: const Text('Monday'),
            selected: _frequency.contains(DateTime.monday),
            value: _frequency.contains(DateTime.monday),
            onChanged: (selected) {
              _updateFrequency(DateTime.monday, selected);
            },
          ),
          CheckboxListTile(
            title: const Text('Tuesday'),
            selected: _frequency.contains(DateTime.tuesday),
            value: _frequency.contains(DateTime.tuesday),
            onChanged: (selected) {
              _updateFrequency(DateTime.tuesday, selected);
            },
          ),
          CheckboxListTile(
            title: const Text('Wednesday'),
            selected: _frequency.contains(DateTime.wednesday),
            value: _frequency.contains(DateTime.wednesday),
            onChanged: (selected) {
              _updateFrequency(DateTime.wednesday, selected);
            },
          ),
          CheckboxListTile(
            title: const Text('Thursday'),
            selected: _frequency.contains(DateTime.thursday),
            value: _frequency.contains(DateTime.thursday),
            onChanged: (selected) {
              _updateFrequency(DateTime.thursday, selected);
            },
          ),
          CheckboxListTile(
            title: const Text('Friday'),
            selected: _frequency.contains(DateTime.friday),
            value: _frequency.contains(DateTime.friday),
            onChanged: (selected) {
              _updateFrequency(DateTime.friday, selected);
            },
          ),
          CheckboxListTile(
            title: const Text('Saturday'),
            selected: _frequency.contains(DateTime.saturday),
            value: _frequency.contains(DateTime.saturday),
            onChanged: (selected) {
              _updateFrequency(DateTime.saturday, selected);
            },
          ),
          CheckboxListTile(
            title: const Text('Sunday'),
            selected: _frequency.contains(DateTime.sunday),
            value: _frequency.contains(DateTime.sunday),
            onChanged: (selected) {
              _updateFrequency(DateTime.sunday, selected);
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _RunsTab extends ConsumerStatefulWidget {
  const _RunsTab({
    Key? key,
    required this.initialrunGroups,
  }) : super(key: key);

  final List<RunCreation> initialrunGroups;

  @override
  ConsumerState<_RunsTab> createState() => _RunsTabState();
}

class _RunsTabState extends ConsumerState<_RunsTab> with AutomaticKeepAliveClientMixin {
  final entries = <TimelineEntry>[];
  final mapping = <String, RunCreation>{};
  bool isValid = true;

  @override
  void initState() {
    for (final element in widget.initialrunGroups) {
      final entry = TimelineEntry(
        time: TimeOfDay(
          hour: element.startHour,
          minute: element.startMinute,
        ),
        duration: Duration(seconds: element.durationSeconds),
      );
      entries.add(entry);
      mapping[entry.id] = element;
    }
    super.initState();
  }

  void _addStartTime(TimelineEntry entry, Zone zone) {
    setState(() {
      mapping[entry.id] = RunCreation(
        zoneId: zone.id,
        durationSeconds: entry.duration.inSeconds,
        startHour: entry.time.hour,
        startMinute: entry.time.minute,
      );
      entries.add(entry);
      context.read<_ProgramNotifier>().updateRuns(mapping.values.toList());
    });
  }

  void _changeStartTime(String entryId, TimeOfDay time) {
    final entry = entries.singleWhere(
      (element) => element.id == entryId,
    );
    final adjustedEntry = TimelineEntry(
      time: time,
      duration: entry.duration,
      id: entry.id,
    );
    final runCreation = mapping[entryId]!;
    setState(() {
      entries
        ..removeWhere((element) => element.id == adjustedEntry.id)
        ..add(adjustedEntry);
      mapping[entryId] = runCreation.copyWith(
        startHour: time.hour,
        startMinute: time.minute,
      );
      context.read<_ProgramNotifier>().updateRuns(mapping.values.toList());
    });
  }

  void _changeDuration(String entryId, double duration) {
    final entry = entries.singleWhere(
      (element) => element.id == entryId,
    );
    setState(() {
      entries
        ..removeWhere((element) => element.id == entryId)
        ..add(
          TimelineEntry(
            time: entry.time,
            duration: Duration(minutes: duration.toInt()),
            id: entry.id,
          ),
        );
      final runCreation = mapping[entryId]!;
      mapping[entryId] = runCreation.copyWith(
        durationSeconds: Duration(minutes: duration.toInt()).inSeconds,
      );
      context.read<_ProgramNotifier>().updateRuns(mapping.values.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final zonesState = ref.watch(zonesProvider);
    return zonesState.maybeWhen(
      data: (zones) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TimelineBuilder(
                    entries: entries,
                    buildTitle: (entryId) {
                      final zoneId = mapping[entryId]!.zoneId;
                      final zone = zones.singleWhere(
                        (element) => element.id == zoneId,
                      );
                      final entry = entries.singleWhere(
                        (element) => element.id == entryId,
                      );
                      return 'Zone ${zone.name} runs for ${entry.duration.inMinutes} minutes';
                    },
                    onEntryDurationChanged: (String entryId, double duration) {
                      _changeDuration(entryId, duration);
                    },
                    onValidityChanged: (valid) {
                      setState(() {
                        isValid = valid;
                      });
                      context.read<_ProgramNotifier>().updateRunValidity(isValid: valid);
                    },
                    onNodeTapped: (node) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      mapping.remove(node);
                                      entries.removeWhere(
                                        (element) => element.id == node,
                                      );
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Remove run'),
                                  ),
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final newTime = await showTimePicker(
                                      context: context,
                                      initialTime: entries
                                          .singleWhere(
                                            (element) => element.id == node,
                                          )
                                          .time,
                                    );
                                    if (newTime != null) {
                                      _changeStartTime(node, newTime);
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text('Adjust start time'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: isValid,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        final zone = await showDialog<Zone>(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: zones.length,
                                itemBuilder: (context, index) {
                                  final zone = zones[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop(zone);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(zone.name),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                        if (zone != null && mounted) {
                          entries.sortByTime();
                          final lastEntry = entries.isEmpty ? null : entries.last;
                          final newTime = await showTimePicker(
                            context: context,
                            initialTime: lastEntry == null
                                ? TimeOfDay.now()
                                : TimeOfDay.fromDateTime(
                                    DateTime.now().apply(lastEntry.time).add(lastEntry.duration),
                                  ),
                          );
                          if (newTime != null) {
                            _addStartTime(
                              TimelineEntry(
                                time: newTime,
                                duration: const Duration(minutes: 10),
                              ),
                              zone,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      orElse: () {
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
