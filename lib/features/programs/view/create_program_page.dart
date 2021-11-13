import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/customer_details/models/zone.dart';
import 'package:hydrawise/features/programs/programs.dart';

import 'create_program_page/run_creation.dart';

class CreateProgramPage extends StatelessWidget {
  const CreateProgramPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Program'),
      ),
      body: const CreateProgramView(),
    );
  }
}

class CreateProgramView extends StatefulWidget {
  const CreateProgramView({Key? key}) : super(key: key);

  @override
  _CreateProgramViewState createState() => _CreateProgramViewState();
}

class _CreateProgramViewState extends State<CreateProgramView> {
  String? _name;
  Frequency? _frequency;
  List<RunCreation> _runCreations = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
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
            onFrequencyChanged: (frequency) {
              setState(() {
                _frequency = frequency;
              });
            },
          ),
          _RunsConfiguration(
            onRunsChanged: (runs) {
              setState(() {
                _runCreations = runs;
              });
            },
          ),
          Visibility(
            visible: _name != null &&
                _name!.isNotEmpty &&
                _frequency != null &&
                _frequency!.hasAtLeastOneDay() &&
                _runCreations.isNotEmpty &&
                !(_runCreations.any((element) =>
                    element.duration == null ||
                    element.duration!.inMinutes == 0 ||
                    element.timeOfDay == null ||
                    element.zones == null ||
                    element.zones!.isEmpty)),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text('Done'),
                onPressed: () {
                  context.read<ProgramsCubit>().createProgram(
                        name: _name!,
                        frequency: _frequency!,
                        runs: _runCreations,
                      );
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

  const _FrequencySelection({
    Key? key,
    required this.onFrequencyChanged,
  }) : super(key: key);

  @override
  _FrequencySelectionState createState() {
    return _FrequencySelectionState();
  }
}

class _FrequencySelectionState extends State<_FrequencySelection> {
  Frequency _frequency = Frequency(
    monday: false,
    tuesday: false,
    wednesday: false,
    thursday: false,
    friday: false,
    saturday: false,
    sunday: false,
  );

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
  final ValueSetter<List<RunCreation>> onRunsChanged;

  const _RunsConfiguration({
    Key? key,
    required this.onRunsChanged,
  }) : super(key: key);

  @override
  _RunsConfigurationState createState() => _RunsConfigurationState();
}

class _RunsConfigurationState extends State<_RunsConfiguration> {
  final _runs = <RunCreation>[];

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
            if (_runs.isNotEmpty)
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: _runs.length,
                itemBuilder: (context, rIndex) {
                  return _RunCreationView(
                    key: ObjectKey(_runs[rIndex]),
                    runCreation: _runs[rIndex],
                    availableZones: zones,
                    onChanged: (runCreation) {
                      setState(() {
                        _runs[rIndex] = runCreation;
                      });
                      widget.onRunsChanged(_runs);
                    },
                    onRemoved: (runCreation) {
                      setState(() {
                        _runs.remove(runCreation);
                      });
                      widget.onRunsChanged(_runs);
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
                      _runs.add(RunCreation(
                        timeOfDay: TimeOfDay.now(),
                        zones: [],
                      ));
                    });
                    widget.onRunsChanged(_runs);
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
  final RunCreation runCreation;
  final List<Zone> availableZones;
  final ValueSetter<RunCreation> onChanged;
  final ValueSetter<RunCreation> onRemoved;

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
  late RunCreation _runCreation;

  @override
  void initState() {
    _runCreation = widget.runCreation;
    super.initState();
  }

  void _changeTime(TimeOfDay? timeOfDay, BuildContext context) {
    if (timeOfDay != null) {
      setState(() {
        _runCreation = _runCreation.copyWith(timeOfDay: timeOfDay);
        widget.onChanged(_runCreation);
      });
    }
  }

  void _changeDuration(String minutes) {
    if (minutes.isNotEmpty) {
      setState(() {
        _runCreation = _runCreation.copyWith(
            duration: Duration(
          minutes: int.parse(minutes),
        ));
        widget.onChanged(_runCreation);
      });
    }
  }

  void _changeZoneMembership(bool isSelected, Zone zone) {
    final zones = _runCreation.zones ?? [];
    if (isSelected) {
      zones.add(zone);
    } else {
      zones.remove(zone);
    }
    _runCreation = _runCreation.copyWith(zones: zones);
    widget.onChanged(_runCreation);
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
                    widget.onRemoved(_runCreation);
                  },
                  icon: const Icon(Icons.remove_circle),
                ),
              ),
              OutlinedButton(
                child: Text(_runCreation.timeOfDay?.format(context) ?? ''),
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
                child: Text(_runCreation.duration?.inMinutes.toString() ?? '0'),
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
                  selected: _runCreation.zones?.contains(zone) ?? false,
                  onSelected: (isSelected) {
                    _changeZoneMembership(isSelected, zone);
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
