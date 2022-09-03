import 'package:api_models/api_models.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';

class CreateProgramPage extends StatelessWidget {
  const CreateProgramPage({
    Key? key,
    this.existingProgramId,
  }) : super(key: key);

  /// If present, represents the ID of the
  /// program being modified
  final int? existingProgramId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramsCubit, ProgramsState>(
      builder: (context, state) {
        final existingProgram = existingProgramId != null
            ? state.programs.singleWhere(
                (program) => program.id == existingProgramId,
              )
            : null;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              existingProgramId == null ? 'Create Program' : 'Edit Program',
            ),
          ),
          body: CreateProgramView(
            name: existingProgram?.name ?? '',
            frequency: List.of(existingProgram?.frequency ?? []),
            runGroups: existingProgram?.runs.toRunCreations() ?? [],
            existingProgramId: existingProgramId,
          ),
        );
      },
    );
  }
}

class CreateProgramView extends StatefulWidget {
  const CreateProgramView({
    Key? key,
    required this.name,
    required this.frequency,
    required this.runGroups,
    required this.existingProgramId,
  }) : super(key: key);

  final String name;
  final List<int> frequency;
  final List<RunCreation> runGroups;
  final int? existingProgramId;

  @override
  State<CreateProgramView> createState() => _CreateProgramViewState();
}

class _CreateProgramViewState extends State<CreateProgramView> {
  late String _name;
  late List<int> _frequency;
  late List<RunCreation> _runGroups;
  late TextEditingController _nameController;

  @override
  void initState() {
    _name = widget.name;
    _frequency = widget.frequency;
    _runGroups = widget.runGroups;
    _nameController = TextEditingController();
    _nameController.text = _name;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _nameController,
            onChanged: (text) {
              setState(() {
                _name = text;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Give your program a name',
            ),
          ),
        ),
        _FrequencySelection(
          initialFrequency: _frequency,
          onFrequencyChanged: (frequency) {
            setState(() {
              _frequency = frequency;
            });
          },
        ),
        Flexible(
          child: _RunsConfiguration(
            initialrunGroups: _runGroups,
            onRunsChanged: (runs) {
              setState(() {
                _runGroups = runs;
              });
            },
          ),
        ),
        Visibility(
          visible: _name.isNotEmpty && _frequency.isNotEmpty && _runGroups.isNotEmpty,
          child: Align(
            child: ElevatedButton(
              child: const Text('Done'),
              onPressed: () {
                if (widget.existingProgramId != null) {
                  context.read<ProgramsCubit>().updateProgram(
                        programId: widget.existingProgramId!,
                        name: _name,
                        frequency: _frequency,
                        runs: _runGroups,
                      );
                } else {
                  context.read<ProgramsCubit>().createProgram(
                        name: _name,
                        frequency: _frequency,
                        runGroups: _runGroups,
                      );
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _FrequencySelection extends StatefulWidget {
  const _FrequencySelection({
    Key? key,
    required this.initialFrequency,
    required this.onFrequencyChanged,
  }) : super(key: key);

  final ValueSetter<List<int>> onFrequencyChanged;
  final List<int> initialFrequency;

  @override
  _FrequencySelectionState createState() {
    return _FrequencySelectionState();
  }
}

class _FrequencySelectionState extends State<_FrequencySelection> {
  late List<int> _frequency;

  @override
  void initState() {
    _frequency = widget.initialFrequency;
    super.initState();
  }

  void _updateFrequency(int day) {
    if (_frequency.contains(day)) {
      _frequency.remove(day);
    } else {
      _frequency.add(day);
    }
    widget.onFrequencyChanged(_frequency);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            'Run on',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 8),
          child: Text(
            'Which days of the week should this program run?',
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.monday);
                  },
                  text: 'M',
                  colorResolver: (states) => _frequency.contains(DateTime.monday)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.tuesday);
                  },
                  text: 'T',
                  colorResolver: (states) => _frequency.contains(DateTime.tuesday)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.wednesday);
                  },
                  text: 'W',
                  colorResolver: (states) => _frequency.contains(DateTime.wednesday)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.thursday);
                  },
                  text: 'R',
                  colorResolver: (states) => _frequency.contains(DateTime.thursday)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.friday);
                  },
                  text: 'F',
                  colorResolver: (friday) => _frequency.contains(DateTime.friday)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.saturday);
                  },
                  text: 'S',
                  colorResolver: (states) => _frequency.contains(DateTime.saturday)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.sunday);
                  },
                  text: 'Su',
                  colorResolver: (states) => _frequency.contains(DateTime.sunday)
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _DayButton extends StatelessWidget {
  const _DayButton({
    Key? key,
    required this.onTapped,
    required this.text,
    required this.colorResolver,
  }) : super(key: key);

  final VoidCallback onTapped;
  final String text;
  final MaterialPropertyResolver<Color> colorResolver;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(colorResolver),
        shape: MaterialStateProperty.all<CircleBorder>(
          CircleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
      onPressed: onTapped,
      child: Padding(
        padding: const EdgeInsets.all(4),
        // TODO(brandon): Dynamically color text based on
        // selection
        child: Text(text),
      ),
    );
  }
}

class _RunsConfiguration extends StatefulWidget {
  const _RunsConfiguration({
    Key? key,
    required this.initialrunGroups,
    required this.onRunsChanged,
  }) : super(key: key);

  final List<RunCreation> initialrunGroups;
  final ValueSetter<List<RunCreation>> onRunsChanged;

  @override
  _RunsConfigurationState createState() => _RunsConfigurationState();
}

class _RunsConfigurationState extends State<_RunsConfiguration> {
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
      widget.onRunsChanged(mapping.values.toList());
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
      widget.onRunsChanged(mapping.values.toList());
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
      widget.onRunsChanged(mapping.values.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
      builder: (context, state) {
        final zones = state.map(
          loading: (_) => List<Zone>.empty(),
          complete: (state) => state.zones,
        );
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
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
              Visibility(
                visible: isValid,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FloatingActionButton.extended(
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
                      if (zone != null) {
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
                    backgroundColor: Colors.green.shade300,
                    label: const Text('Add Run'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
