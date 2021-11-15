import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/customer_details/models/zone.dart';
import 'package:hydrawise/features/programs/programs.dart';

class CreateProgramPage extends StatelessWidget {
  /// If present, represents the ID of the
  /// program being modified
  final String? existingProgramId;

  const CreateProgramPage({
    Key? key,
    this.existingProgramId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramsCubit, ProgramsState>(
      builder: (context, state) {
        final Program? existingProgram = existingProgramId != null
            ? state.programs
                .singleWhere((program) => program.id == existingProgramId)
            : null;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              existingProgramId == null ? 'Create Program' : 'Edit Program',
            ),
          ),
          body: CreateProgramView(
            name: existingProgram?.name ?? '',
            frequency: existingProgram?.frequency ?? FrequencyX.none(),
            runDrafts: existingProgram?.runs.toRunModifications() ?? [],
            existingProgramId: existingProgramId,
          ),
        );
      },
    );
  }
}

class CreateProgramView extends StatefulWidget {
  final String name;
  final Frequency frequency;
  final List<RunDraft> runDrafts;
  final String? existingProgramId;

  const CreateProgramView({
    Key? key,
    required this.name,
    required this.frequency,
    required this.runDrafts,
    required this.existingProgramId,
  }) : super(key: key);

  @override
  _CreateProgramViewState createState() => _CreateProgramViewState();
}

class _CreateProgramViewState extends State<CreateProgramView> {
  late String _name;
  late Frequency _frequency;
  late List<RunDraft> _runDrafts;
  late TextEditingController _nameController;

  @override
  void initState() {
    _name = widget.name;
    _frequency = widget.frequency;
    _runDrafts = widget.runDrafts;
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
            initialRunDrafts: _runDrafts,
            onRunsChanged: (runs) {
              setState(() {
                _runDrafts = runs;
              });
            },
          ),
          Visibility(
            visible: _name.isNotEmpty &&
                _frequency.hasAtLeastOneDay() &&
                _runDrafts.isNotEmpty &&
                !(_runDrafts.any(
                  (element) =>
                      element.duration.inMinutes == 0 ||
                      element.zoneIds.isEmpty,
                )),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text('Done'),
                onPressed: () {
                  if (widget.existingProgramId != null) {
                    context.read<ProgramsCubit>().updateProgram(
                          programId: widget.existingProgramId!,
                          name: _name,
                          frequency: _frequency,
                          runs: _runDrafts,
                        );
                  } else {
                    context.read<ProgramsCubit>().createProgram(
                          name: _name,
                          frequency: _frequency,
                          runs: _runDrafts,
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
  final ValueSetter<Frequency> onFrequencyChanged;
  final Frequency initialFrequency;

  const _FrequencySelection(
      {Key? key,
      required this.initialFrequency,
      required this.onFrequencyChanged})
      : super(key: key);

  @override
  _FrequencySelectionState createState() {
    return _FrequencySelectionState();
  }
}

class _FrequencySelectionState extends State<_FrequencySelection> {
  late Frequency _frequency;

  @override
  void initState() {
    _frequency = widget.initialFrequency;
    super.initState();
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
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(monday: !_frequency.monday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'M',
                colorResolver: (states) => _frequency.monday
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency =
                      _frequency.copyWith(tuesday: !_frequency.tuesday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'T',
                colorResolver: (states) => _frequency.tuesday
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency =
                      _frequency.copyWith(wednesday: !_frequency.wednesday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'W',
                colorResolver: (states) => _frequency.wednesday
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency =
                      _frequency.copyWith(thursday: !_frequency.thursday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'R',
                colorResolver: (states) => _frequency.thursday
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(friday: !_frequency.friday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'F',
                colorResolver: (friday) => _frequency.friday
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency =
                      _frequency.copyWith(saturday: !_frequency.saturday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'S',
                colorResolver: (states) => _frequency.saturday
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(sunday: !_frequency.sunday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'Su',
                colorResolver: (states) => _frequency.sunday
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _DayButton extends StatelessWidget {
  final VoidCallback onTapped;
  final String text;
  final MaterialPropertyResolver<Color> colorResolver;

  const _DayButton({
    Key? key,
    required this.onTapped,
    required this.text,
    required this.colorResolver,
  }) : super(key: key);

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
        padding: const EdgeInsets.all(4.0),
        // TODO(brandon): Dynamically color text based on
        // selection
        child: Text(text),
      ),
    );
  }
}

class _RunsConfiguration extends StatefulWidget {
  final List<RunDraft> initialRunDrafts;
  final ValueSetter<List<RunDraft>> onRunsChanged;

  const _RunsConfiguration({
    Key? key,
    required this.initialRunDrafts,
    required this.onRunsChanged,
  }) : super(key: key);

  @override
  _RunsConfigurationState createState() => _RunsConfigurationState();
}

class _RunsConfigurationState extends State<_RunsConfiguration> {
  late List<RunDraft> _runDrafts;

  @override
  void initState() {
    _runDrafts = widget.initialRunDrafts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
      builder: (context, state) {
        final List<Zone> zones = state.map(
          loading: (_) => List<Zone>.empty(),
          complete: (state) => state.customerStatus.zones,
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
            if (_runDrafts.isNotEmpty)
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: _runDrafts.length,
                itemBuilder: (context, rIndex) {
                  return _RunCreationView(
                    key: ObjectKey(_runDrafts[rIndex]),
                    runCreation: _runDrafts[rIndex],
                    availableZones: zones,
                    onChanged: (runCreation) {
                      setState(() {
                        _runDrafts[rIndex] = runCreation;
                      });
                      widget.onRunsChanged(_runDrafts);
                    },
                    onRemoved: (runCreation) {
                      setState(() {
                        _runDrafts.remove(runCreation);
                      });
                      widget.onRunsChanged(_runDrafts);
                    },
                  );
                },
              ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _runDrafts.add(
                        RunDraft.creation(
                          timeOfDay: TimeOfDay.now(),
                          zoneIds: [],
                          duration: Duration.zero,
                        ),
                      );
                    });
                    widget.onRunsChanged(_runDrafts);
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
  final RunDraft runCreation;
  final List<Zone> availableZones;
  final ValueSetter<RunDraft> onChanged;
  final ValueSetter<RunDraft> onRemoved;

  const _RunCreationView({
    Key? key,
    required this.runCreation,
    required this.availableZones,
    required this.onChanged,
    required this.onRemoved,
  }) : super(key: key);

  @override
  _RunCreationViewState createState() => _RunCreationViewState();
}

class _RunCreationViewState extends State<_RunCreationView> {
  late RunDraft _runDraft;

  @override
  void initState() {
    _runDraft = widget.runCreation;
    super.initState();
  }

  void _changeTime(TimeOfDay? timeOfDay, BuildContext context) {
    if (timeOfDay != null) {
      setState(() {
        _runDraft = _runDraft.copyWith(timeOfDay: timeOfDay);
        widget.onChanged(_runDraft);
      });
    }
  }

  void _changeDuration(String minutes) {
    if (minutes.isNotEmpty) {
      setState(() {
        _runDraft = _runDraft.copyWith(
            duration: Duration(
          minutes: int.parse(minutes),
        ));
        widget.onChanged(_runDraft);
      });
    }
  }

  void _changeZoneMembership(bool isSelected, int zoneId) {
    final zones = _runDraft.zoneIds;
    if (isSelected) {
      zones.add(zoneId);
    } else {
      zones.remove(zoneId);
    }
    _runDraft = _runDraft.copyWith(zoneIds: zones);
    widget.onChanged(_runDraft);
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
                    widget.onRemoved(_runDraft);
                  },
                  icon: const Icon(Icons.remove_circle),
                ),
              ),
              OutlinedButton(
                child: Text(_runDraft.timeOfDay.format(context)),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  _changeTime(time, context);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text('for'),
              ),
              OutlinedButton(
                child: Text(_runDraft.duration.inMinutes.toString()),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (_) {
                        return _DurationTimeInputDialog(onSubmit: (value) {
                          _changeDuration(value);
                        });
                      });
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
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  checkmarkColor: Theme.of(context).colorScheme.onSecondary,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  selected: _runDraft.zoneIds.contains(zone.id),
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
  final ValueSetter<String> onSubmit;

  const _DurationTimeInputDialog({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: TextField(
        autofocus: true,
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
