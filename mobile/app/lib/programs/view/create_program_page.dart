import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:collection/collection.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/create_program/create_program.dart';
import 'package:irri/programs/providers.dart';
import 'package:irri/programs/update_program/update_program.dart';
import 'package:irri/zones/providers.dart';
import 'package:uuid/uuid.dart';

class CreateProgramPage extends StatefulWidget {
  const CreateProgramPage({super.key, this.programId});

  final int? programId;

  @override
  State<CreateProgramPage> createState() => _CreateProgramPageState();
}

class _CreateProgramPageState extends State<CreateProgramPage> {
  Program? _program;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Program'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final shouldFetch = widget.programId != null && _program == null;
            if (shouldFetch) {
              return _LoadProgramView(
                programId: widget.programId!,
                onProgramLoaded: (program) {
                  setState(() {
                    _program = program;
                  });
                },
              );
            }
            return _CreateProgramView(program: _program);
          },
        ),
      ),
    );
  }
}

class _LoadProgramView extends ConsumerWidget {
  const _LoadProgramView({
    required this.programId,
    required this.onProgramLoaded,
  });

  final int programId;
  final ValueSetter<Program> onProgramLoaded;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final program = ref.read(existingProgramProvider(programId));
    // ignore: cascade_invocations
    program.maybeWhen(
      orElse: () {},
      data: (program) {
        if (program != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            onProgramLoaded(program);
          });
        }
      },
    );
    return const Center(child: CircularProgressIndicator());
  }
}

class _CreateProgramView extends StatefulHookConsumerWidget {
  const _CreateProgramView({required this.program});

  final Program? program;
  @override
  ConsumerState<_CreateProgramView> createState() => _CreateProgramViewState();
}

class _CreateProgramViewState extends ConsumerState<_CreateProgramView> {
  var _frequency = List.generate(7, (index) => false);
  var _runGroups = <_RunGroup>[];

  @override
  void initState() {
    super.initState();
    if (widget.program != null) {
      _frequency = List.generate(7, (index) => widget.program!.frequency.contains(index + 1));
      _runGroups = widget.program!.runs
          .map(
            (r) => _RunGroup(
              startTime: TimeOfDay(hour: r.startHour, minute: r.startMinute),
              duration: Duration(seconds: r.durationSeconds),
              zoneIds: r.zoneIds,
            ),
          )
          .toList();
    }
  }

  String? error() {
    for (final g in _runGroups) {
      if (_runGroups.last == g) {
        return null;
      }
      final startTime = (g.startTime.hour * 60) + g.startTime.minute;
      final duration = g.duration.inMinutes;
      final zones = g.zoneIds.length;
      final nextGroup = _runGroups[_runGroups.indexOf(g) + 1];
      final nextGroupStartTime = (nextGroup.startTime.hour * 60) + nextGroup.startTime.minute;
      if (startTime + (zones * duration) > nextGroupStartTime) {
        final difference = Duration(minutes: startTime + (zones * duration) - nextGroupStartTime);
        return 'Run times of groups ${_runGroups.indexOf(g) + 1} and ${_runGroups.indexOf(nextGroup) + 1} overlap by ${difference.inMinutes} minutes.';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: widget.program?.name);
    final controllerUpdates = useValueListenable(controller);
    final zonesState = ref.read(zonesProvider);
    if (zonesState.hasError) {
      return Center(child: Text(zonesState.error!.toString()));
    }
    if (zonesState.isLoading) {
      return const CircularProgressIndicator();
    }
    final zones = zonesState.asData!.value;
    ref
      ..listen<AsyncValue<Object?>>(
        createProgramControllerProvider,
        (_, state) => state.whenOrNull(
          error: (error, stack) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
          data: (data) {
            if (data == createProgramSuccess) {
              GoRouter.of(context).pop();
            }
          },
        ),
      )
      ..listen<AsyncValue<Object?>>(
        updateProgramControllerProvider,
        (_, state) => state.whenOrNull(
          error: (error, stack) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
          data: (data) {
            if (data == updateProgramSuccess) {
              GoRouter.of(context).pop();
            }
          },
        ),
      );
    final isLoading = ref.watch(createProgramControllerProvider).isLoading;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Program name',
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final frequency = await showDialog<List<bool>>(
                    context: context,
                    builder: (context) {
                      return _FrequencySelectionDialog(
                        initialFrequency: _frequency,
                      );
                    },
                  );
                  if (frequency != null) {
                    setState(() {
                      _frequency = frequency;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_month),
              ),
            ],
          ),
          const VSpace(spacing: 8),
          _RunsOnText(frequency: _frequency),
          const VSpace(spacing: 8),
          ..._runGroups.mapIndexed(
            (index, g) => Dismissible(
              key: ValueKey(g.id),
              onDismissed: (_) {
                setState(() {
                  _runGroups = _runGroups
                    ..removeAt(index)
                    ..sort(
                      (a, b) => ((a.startTime.hour * 60) + a.startTime.minute)
                          .compareTo((b.startTime.hour * 60) + b.startTime.minute),
                    );
                });
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${_runGroups[index].startTime.format(context)} for ${_runGroups[index].duration.inMinutes} minutes',
                ),
                leading: CircleBackground(
                  child: Text((index + 1).toString()),
                ),
                subtitle: Text(
                  zones
                      .where((element) => _runGroups[index].zoneIds.contains(element.id))
                      .map((z) => z.name)
                      .join(', '),
                ),
                onTap: () async {
                  final group = await showDialog<_RunGroup>(
                    context: context,
                    builder: (context) {
                      return _RunGroupCreationDialog(
                        initialRunGroup: _runGroups[index],
                        zones: zones,
                      );
                    },
                  );
                  if (group != null) {
                    setState(() {
                      _runGroups = _runGroups
                        ..removeWhere((g) => g.id == group.id)
                        ..add(group)
                        ..sort(
                          (a, b) => ((a.startTime.hour * 60) + a.startTime.minute)
                              .compareTo((b.startTime.hour * 60) + b.startTime.minute),
                        );
                    });
                  }
                },
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleBackground(
              color: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add),
            ),
            title: _runGroups.isEmpty ? const Text('Tap to add runs') : const Text('Tap to add more runs'),
            subtitle: const Text('Choose start time, length, and zones to run'),
            onTap: () async {
              final group = await showDialog<_RunGroup>(
                context: context,
                builder: (context) {
                  return _RunGroupCreationDialog(
                    initialRunGroup: null,
                    zones: zones,
                  );
                },
              );
              if (group != null) {
                setState(() {
                  _runGroups = _runGroups
                    ..removeWhere((g) => g.id == group.id)
                    ..add(group)
                    ..sort(
                      (a, b) => ((a.startTime.hour * 60) + a.startTime.minute)
                          .compareTo((b.startTime.hour * 60) + b.startTime.minute),
                    );
                });
              }
            },
          ),
          const VSpace(spacing: 32),
          Builder(
            builder: (context) {
              final possibleError = error();
              final canSubmit = _frequency.any((f) => f) &&
                  controllerUpdates.text.isNotEmpty &&
                  _runGroups.isNotEmpty &&
                  possibleError == null;
              return Visibility(
                visible: (possibleError != null || canSubmit) && !isLoading,
                child: const Divider(height: 0.5),
              );
            },
          ),
          Builder(
            builder: (context) {
              final possibleError = error();
              final canSubmit = _frequency.any((f) => f) &&
                  controllerUpdates.text.isNotEmpty &&
                  _runGroups.isNotEmpty &&
                  possibleError == null;
              return Visibility(
                visible: canSubmit && !isLoading,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleBackground(
                    color: Colors.green.shade500,
                    child: Icon(
                      Icons.done,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  title: const Text('Tap to submit'),
                  subtitle: Builder(
                    builder: (context) {
                      final verb = widget.program != null ? 'Update' : 'Create';
                      return Text('$verb ${controllerUpdates.text}');
                    },
                  ),
                  onTap: () async {
                    if (widget.program != null) {
                      unawaited(
                        ref.read(updateProgramControllerProvider.notifier).updateProgram(
                              programId: widget.program!.id,
                              name: controllerUpdates.text,
                              frequency:
                                  _frequency.mapIndexed((index, f) => f ? index + 1 : null).whereNotNull().toList(),
                              runGroups: _runGroups
                                  .map(
                                    (e) => RunGroupCreation(
                                      zoneIds: e.zoneIds,
                                      durationSeconds: e.duration.inSeconds,
                                      startHour: e.startTime.hour,
                                      startMinute: e.startTime.minute,
                                    ),
                                  )
                                  .toList(),
                            ),
                      );
                    } else {
                      unawaited(
                        ref.read(createProgramControllerProvider.notifier).createProgram(
                              name: controllerUpdates.text,
                              frequency:
                                  _frequency.mapIndexed((index, f) => f ? index + 1 : null).whereNotNull().toList(),
                              runGroups: _runGroups
                                  .map(
                                    (e) => RunGroupCreation(
                                      zoneIds: e.zoneIds,
                                      durationSeconds: e.duration.inSeconds,
                                      startHour: e.startTime.hour,
                                      startMinute: e.startTime.minute,
                                    ),
                                  )
                                  .toList(),
                            ),
                      );
                    }
                  },
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              final possibleError = error();
              return Visibility(
                visible: possibleError != null,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleBackground(
                    color: Theme.of(context).colorScheme.error,
                    child: Icon(
                      Icons.block,
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                  title: const Text('Oops'),
                  subtitle: Text(possibleError ?? ''),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RunsOnText extends StatelessWidget {
  const _RunsOnText({required this.frequency});

  final List<bool> frequency;

  @override
  Widget build(BuildContext context) {
    late String text;
    if (frequency.every((f) => !f)) {
      text = 'Tap the calendar to set a frequency';
    } else {
      final desc = frequency.mapIndexed((index, f) => f ? index.toWeekDayName() : null).whereNotNull();
      text = 'Runs on ${desc.join(', ')}';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class _FrequencySelectionDialog extends StatefulWidget {
  const _FrequencySelectionDialog({required this.initialFrequency});

  final List<bool>? initialFrequency;

  @override
  State<_FrequencySelectionDialog> createState() => _FrequencySelectionDialogState();
}

class _FrequencySelectionDialogState extends State<_FrequencySelectionDialog> {
  late final List<bool> frequency;

  @override
  void initState() {
    super.initState();
    frequency = widget.initialFrequency ?? List.generate(7, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...frequency.mapIndexed(
              (index, element) => CheckboxListTile(
                value: frequency[index],
                onChanged: (value) {
                  setState(
                    () {
                      frequency[index] = value ?? false;
                    },
                  );
                },
                title: Text(index.toWeekDayName()),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(frequency),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RunGroup {
  _RunGroup({
    // TODO(brandon): Use freezed for CopyWith
    String? id,
    required this.startTime,
    required this.duration,
    required this.zoneIds,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final TimeOfDay startTime;
  final Duration duration;
  final List<int> zoneIds;
}

class _RunGroupCreationDialog extends StatefulWidget {
  const _RunGroupCreationDialog({
    required this.initialRunGroup,
    required this.zones,
  });

  final _RunGroup? initialRunGroup;
  final List<Zone> zones;

  @override
  State<_RunGroupCreationDialog> createState() => _RunGroupCreationDialogState();
}

class _RunGroupCreationDialogState extends State<_RunGroupCreationDialog> {
  late _RunGroup group;

  @override
  void initState() {
    super.initState();
    group = widget.initialRunGroup ??
        _RunGroup(
          startTime: TimeOfDay.now(),
          duration: const Duration(minutes: 30),
          zoneIds: widget.zones.map((e) => e.id).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final timeOfDay = await showTimePicker(
                      context: context,
                      useRootNavigator: false,
                      initialTime: group.startTime,
                    );
                    if (timeOfDay != null) {
                      setState(() {
                        group = _RunGroup(
                          id: group.id,
                          startTime: timeOfDay,
                          duration: group.duration,
                          zoneIds: group.zoneIds,
                        );
                      });
                    }
                  },
                  child: Text(group.startTime.format(context)),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final duration = await showDialog<Duration>(
                      context: context,
                      builder: (context) {
                        return _RunDurationDialog(
                          initialDuration: group.duration,
                        );
                      },
                    );
                    if (duration != null) {
                      setState(() {
                        group = _RunGroup(
                          id: group.id,
                          startTime: group.startTime,
                          duration: duration,
                          zoneIds: group.zoneIds,
                        );
                      });
                    }
                  },
                  child: Text(
                    '${group.duration.inMinutes} mins',
                  ),
                ),
                const Spacer(),
              ],
            ),
            ...widget.zones.mapIndexed(
              (index, element) => CheckboxListTile(
                value: group.zoneIds.contains(widget.zones[index].id),
                onChanged: (value) {
                  final currZoneIds = List.of(group.zoneIds);
                  final currId = widget.zones[index].id;
                  final newZoneIds = currZoneIds..removeWhere((i) => i == currId);
                  if (value ?? false) {
                    newZoneIds.add(currId);
                  }
                  setState(
                    () {
                      group = _RunGroup(
                        id: group.id,
                        startTime: group.startTime,
                        duration: group.duration,
                        zoneIds: newZoneIds,
                      );
                    },
                  );
                },
                title: Text(widget.zones[index].name),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(group),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RunDurationDialog extends StatefulWidget {
  const _RunDurationDialog({required this.initialDuration});

  final Duration initialDuration;
  @override
  State<_RunDurationDialog> createState() => _RunDurationDialogState();
}

class _RunDurationDialogState extends State<_RunDurationDialog> {
  late Duration duration;

  @override
  void initState() {
    duration = widget.initialDuration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    duration = Duration(minutes: duration.inMinutes - 1);
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Text(duration.inMinutes.toString()),
              IconButton(
                onPressed: () {
                  setState(() {
                    duration = Duration(minutes: duration.inMinutes + 1);
                  });
                },
                icon: const Icon(Icons.add),
              ),
              const Spacer()
            ],
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(duration),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

class _RunLengthSlider extends StatefulWidget {
  const _RunLengthSlider({
    Key? key,
    required this.zone,
    required this.onChanged,
  }) : super(key: key);

  final Zone zone;
  final ValueSetter<Duration> onChanged;

  @override
  _RunLengthSliderState createState() => _RunLengthSliderState();
}

class _RunLengthSliderState extends State<_RunLengthSlider> {
  late Duration _currentValue;

  @override
  void initState() {
    final nextRunLength = Duration(seconds: widget.zone.nextRunLengthSec);
    _setCurrentValue(nextRunLength == Duration.zero ? const Duration(minutes: 1) : nextRunLength);
    super.initState();
  }

  void _setCurrentValue(Duration value) {
    setState(() {
      _currentValue = value;
    });
    widget.onChanged(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 1,
      max: 90,
      divisions: 90,
      label: _currentValue.inMinutes.toString(),
      value: _currentValue.inMinutes.toDouble(),
      onChanged: (value) => _setCurrentValue(Duration(minutes: value.round())),
    );
  }
}

extension on int {
  String toWeekDayName() {
    switch (this) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        throw Exception('Invalid int $this');
    }
  }
}
