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

class CreateProgramView extends StatelessWidget {
  const CreateProgramView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
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
          _FrequencySelection(onFrequencyChanged: (frequency) {}),
          _RunsConfiguration(),
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
  @override
  _RunsConfigurationState createState() => _RunsConfigurationState();
}

class _RunsConfigurationState extends State<_RunsConfiguration> {
  final _runs = <RunCreation>[];
  late TextEditingController _timeOfDayController;

  @override
  void initState() {
    _timeOfDayController = TextEditingController();
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Run at',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            if (_runs.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _runs.length,
                  itemBuilder: (context, rIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
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
                                    if (time != null) {
                                      _runs[rIndex] = _runs[rIndex].copyWith(timeOfDay: time);
                                      _timeOfDayController.text = '${time.hour}:${time.minute}';
                                    }
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
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () {
                                    print('Show time chooser');
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text('minutes'),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _runs[rIndex].zones?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, zIndex) {
                                return ActionChip(
                                  key: ValueKey(
                                    _runs[rIndex].zones![zIndex].id,
                                  ),
                                  label: Text(_runs[rIndex].zones![zIndex].name),
                                  onPressed: () {
                                    final rZones = _runs[rIndex].zones ?? List.empty();
                                    if (!rZones.contains(zones[zIndex])) {
                                      rZones.add(zones[zIndex]);
                                    } else {
                                      rZones.remove(zones[zIndex]);
                                    }
                                    setState(() {
                                      _runs[rIndex] = _runs[rIndex].copyWith(zones: rZones);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      // TODO(brandon): Don't use real Run objects here,
                      // store only necessary data and create Runs in the
                      // repository
                      _runs.add(RunCreation(zones: zones));
                    });
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
