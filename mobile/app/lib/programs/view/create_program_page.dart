import 'package:api_models/api_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String? existingProgramId;

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
            frequency: existingProgram?.frequency ?? [],
            runGroups: existingProgram?.runs.toRunGroups() ?? [],
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
  final List<RunGroup> runGroups;
  final String? existingProgramId;

  @override
  State<CreateProgramView> createState() => _CreateProgramViewState();
}

class _CreateProgramViewState extends State<CreateProgramView> {
  late String _name;
  late List<int> _frequency;
  late List<RunGroup> _runGroups;
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          _RunsConfiguration(
            initialrunGroups: _runGroups,
            onRunsChanged: (runs) {
              setState(() {
                _runGroups = runs;
              });
            },
          ),
          Visibility(
            visible: _name.isNotEmpty &&
                _frequency.isNotEmpty &&
                _runGroups.isNotEmpty &&
                !_runGroups.any(
                  (element) =>
                      element.duration.inMinutes == 0 ||
                      element.zoneIds.isEmpty,
                ),
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
      ),
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
                  colorResolver: (states) =>
                      _frequency.contains(DateTime.monday)
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.tuesday);
                  },
                  text: 'T',
                  colorResolver: (states) =>
                      _frequency.contains(DateTime.tuesday)
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.wednesday);
                  },
                  text: 'W',
                  colorResolver: (states) =>
                      _frequency.contains(DateTime.wednesday)
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.thursday);
                  },
                  text: 'R',
                  colorResolver: (states) =>
                      _frequency.contains(DateTime.thursday)
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.friday);
                  },
                  text: 'F',
                  colorResolver: (friday) =>
                      _frequency.contains(DateTime.friday)
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.saturday);
                  },
                  text: 'S',
                  colorResolver: (states) =>
                      _frequency.contains(DateTime.saturday)
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                ),
                _DayButton(
                  onTapped: () {
                    _updateFrequency(DateTime.sunday);
                  },
                  text: 'Su',
                  colorResolver: (states) =>
                      _frequency.contains(DateTime.sunday)
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

  final List<RunGroup> initialrunGroups;
  final ValueSetter<List<RunGroup>> onRunsChanged;

  @override
  _RunsConfigurationState createState() => _RunsConfigurationState();
}

class _RunsConfigurationState extends State<_RunsConfiguration> {
  late List<RunGroup> _runGroups;

  @override
  void initState() {
    _runGroups = widget.initialrunGroups;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
      builder: (context, state) {
        final zones = state.map(
          loading: (_) => List<Zone>.empty(),
          complete: (state) => state.zones,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Run at',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Set start times and durations for groups of zones.',
              ),
            ),
            if (_runGroups.isNotEmpty)
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: _runGroups.length,
                itemBuilder: (context, rIndex) {
                  return _RunCreationView(
                    key: ObjectKey(_runGroups[rIndex]),
                    runCreation: _runGroups[rIndex],
                    availableZones: zones,
                    onChanged: (runCreation) {
                      setState(() {
                        _runGroups[rIndex] = runCreation;
                      });
                      widget.onRunsChanged(_runGroups);
                    },
                    onRemoved: (runCreation) {
                      setState(() {
                        _runGroups.remove(runCreation);
                      });
                      widget.onRunsChanged(_runGroups);
                    },
                  );
                },
              ),
            Align(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _runGroups.add(
                        RunGroup(
                          type: RunGroupType.creation,
                          timeOfDay: TimeOfDay.now(),
                          zoneIds: [],
                          duration: Duration.zero,
                        ),
                      );
                    });
                    widget.onRunsChanged(_runGroups);
                  },
                  child: const Text('Add Run'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RunCreationView extends StatefulWidget {
  const _RunCreationView({
    Key? key,
    required this.runCreation,
    required this.availableZones,
    required this.onChanged,
    required this.onRemoved,
  }) : super(key: key);

  final RunGroup runCreation;
  final List<Zone> availableZones;
  final ValueSetter<RunGroup> onChanged;
  final ValueSetter<RunGroup> onRemoved;

  @override
  _RunCreationViewState createState() => _RunCreationViewState();
}

class _RunCreationViewState extends State<_RunCreationView> {
  late RunGroup _runGroup;

  @override
  void initState() {
    _runGroup = widget.runCreation;
    super.initState();
  }

  void _changeTime(TimeOfDay? timeOfDay, BuildContext context) {
    if (timeOfDay != null) {
      setState(() {
        _runGroup = _runGroup.copyWith(timeOfDay: timeOfDay);
        widget.onChanged(_runGroup);
      });
    }
  }

  void _changeDuration(String minutes) {
    if (minutes.isNotEmpty) {
      setState(() {
        _runGroup = _runGroup.copyWith(
          duration: Duration(
            minutes: int.parse(minutes),
          ),
        );
        widget.onChanged(_runGroup);
      });
    }
  }

  void _changeZoneMembership(bool isSelected, int zoneId) {
    final zones = List.of(_runGroup.zoneIds);
    if (isSelected) {
      zones.add(zoneId);
    } else {
      zones.remove(zoneId);
    }
    _runGroup = _runGroup.copyWith(zoneIds: zones);
    widget.onChanged(_runGroup);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Tooltip(
                message: 'Remove run',
                child: IconButton(
                  onPressed: () {
                    widget.onRemoved(_runGroup);
                  },
                  icon: const Icon(Icons.remove_circle),
                ),
              ),
              OutlinedButton(
                child: Text(_runGroup.timeOfDay.format(context)),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  // TODO(brandon): Address this by passing
                  // a param `onChosen`
                  // ignore: use_build_context_synchronously
                  _changeTime(time, context);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text('for'),
              ),
              OutlinedButton(
                child: Text(_runGroup.duration.inMinutes.toString()),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return _DurationTimeInputDialog(
                        onSubmit: _changeDuration,
                      );
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text('minutes'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 48,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16, right: 16),
            shrinkWrap: true,
            itemCount: widget.availableZones.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, zIndex) {
              final zone = widget.availableZones[zIndex];
              return Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                ),
                child: FilterChip(
                  key: ValueKey(zone.id),
                  label: Text(
                    zone.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  checkmarkColor: Theme.of(context).colorScheme.onSecondary,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  selected: _runGroup.zoneIds.contains(zone.id),
                  onSelected: (isSelected) {
                    _changeZoneMembership(isSelected, zone.id);
                  },
                ),
              );
            },
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _DurationTimeInputDialog extends StatelessWidget {
  const _DurationTimeInputDialog({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final ValueSetter<String> onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: TextField(
        autofocus: true,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (value) {
          onSubmit(value);
          Navigator.pop(context);
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: const TextInputType.numberWithOptions(signed: true),
      ),
    );
  }
}
