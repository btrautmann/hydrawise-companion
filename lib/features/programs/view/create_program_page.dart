import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/customer_details/models/zone.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:uuid/uuid.dart';

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

class CreateProgramView extends StatelessWidget {
  const CreateProgramView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Give your program a name',
              ),
            ),
          ),
          _FrequencySelection(
            onFrequencyChanged: (frequency) {},
          ),
          _RunsConfiguration(
            onRunsChanged: (runs) {},
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
                colorResolver: (states) => _frequency.monday ? Colors.green : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(tuesday: !_frequency.tuesday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'T',
                colorResolver: (states) => _frequency.tuesday ? Colors.green : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(wednesday: !_frequency.wednesday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'W',
                colorResolver: (states) => _frequency.wednesday ? Colors.green : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(thursday: !_frequency.thursday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'R',
                colorResolver: (states) => _frequency.thursday ? Colors.green : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(friday: !_frequency.friday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'F',
                colorResolver: (friday) => _frequency.friday ? Colors.green : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(saturday: !_frequency.saturday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'S',
                colorResolver: (states) => _frequency.saturday ? Colors.green : Colors.transparent,
              ),
              _DayButton(
                onTapped: () {
                  _frequency = _frequency.copyWith(sunday: !_frequency.sunday);
                  widget.onFrequencyChanged(_frequency);
                },
                text: 'Su',
                colorResolver: (states) => _frequency.sunday ? Colors.green : Colors.transparent,
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
          const CircleBorder(side: BorderSide(color: Colors.green)),
        ),
      ),
      onPressed: onTapped,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _runs.add(RunCreation(zones: []));
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
  late TextEditingController _timeOfDayController;
  late TextEditingController _durationController;
  late RunCreation _runCreation;

  @override
  void initState() {
    _runCreation = widget.runCreation;
    _timeOfDayController = TextEditingController();
    _durationController = TextEditingController();
    super.initState();
  }

  void _changeTime(TimeOfDay? timeOfDay) {
    if (timeOfDay != null) {
      setState(() {
        _runCreation = _runCreation.copyWith(timeOfDay: timeOfDay);
        widget.onChanged(_runCreation);
      });
      _timeOfDayController.text = '${timeOfDay.hour}:${timeOfDay.minute}';
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
              IconButton(
                onPressed: () {
                  widget.onRemoved(_runCreation);
                },
                icon: const Icon(Icons.remove_circle),
              ),
              SizedBox(
                height: 48,
                width: 100,
                child: TextField(
                  controller: _timeOfDayController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    _changeTime(time);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text('for'),
              ),
              SizedBox(
                height: 48,
                width: 100,
                child: TextField(
                  onChanged: (text) {
                    _changeDuration(text);
                  },
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
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
                  label: Text(zone.name),
                  selectedColor: Colors.green,
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
