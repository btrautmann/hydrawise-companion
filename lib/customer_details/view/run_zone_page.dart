import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/customer_details/cubit/run_zone_cubit.dart';
import 'package:hydrawise/customer_details/cubit/run_zone_state.dart';
import 'package:hydrawise/customer_details/domain/run_zone.dart';
import 'package:hydrawise/customer_details/domain/stop_zone.dart';
import 'package:hydrawise/customer_details/models/zone.dart';

class RunZonesPage extends StatelessWidget {
  const RunZonesPage({
    Key? key,
    required this.zone,
  }) : super(key: key);

  final Zone zone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(zone.name),
      ),
      body: BlocProvider<RunZoneCubit>(
        create: (_) => RunZoneCubit(
          runZone: context.read<RunZone>(),
          stopZone: context.read<StopZone>(),
          zone: zone,
        ),
        child: _RunZonesView(zone: zone),
      ),
    );
  }
}

class _RunZonesView extends StatefulWidget {
  const _RunZonesView({
    Key? key,
    required this.zone,
  }) : super(key: key);

  final Zone zone;

  @override
  __RunZonesViewState createState() => __RunZonesViewState();
}

class __RunZonesViewState extends State<_RunZonesView> {
  double selectedRunLengthInMinutes = 0;

  @override
  Widget build(BuildContext context) {
    final customerDetailsState =
        context.select((CustomerDetailsCubit cubit) => cubit.state);
    return customerDetailsState.maybeWhen(
      complete: (details, status) {
        final selectedZone =
            status.zones.singleWhere((element) => element.id == widget.zone.id);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _ZoneHeader(zone: selectedZone),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _NextWaterText(zone: selectedZone),
                ),
                if (!selectedZone.isRunning)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _RunLengthSlider(
                      zone: selectedZone,
                      onChanged: (value) {
                        selectedRunLengthInMinutes = value;
                      },
                    ),
                  ),
                _ZoneButtons(
                  zone: selectedZone,
                  onRunPressed: () {
                    // TODO(brandon): Figure out correct way to get time from
                    // slider
                    context.read<RunZoneCubit>().runZone(
                        runLengthMinutes: selectedRunLengthInMinutes.toInt());
                  },
                  onStopPressed: () {
                    context.read<RunZoneCubit>().stopZone();
                  },
                ),
              ],
            ),
          ),
        );
      },
      orElse: () {
        return const Center(child: CircularProgressIndicator());
      },
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
  final ValueSetter<double> onChanged;

  @override
  __RunLengthSliderState createState() => __RunLengthSliderState();
}

class __RunLengthSliderState extends State<_RunLengthSlider> {
  late double _currentValue;

  @override
  void initState() {
    // TODO(brandon): Fix this hack
    final maxValue = widget.zone.lengthOfNextRunTimeOrTimeRemaining == 0
        ? 90
        : widget.zone.lengthOfNextRunTimeOrTimeRemaining / 60;
    _setCurrentValue(maxValue.toDouble());
    super.initState();
  }

  void _setCurrentValue(double value) {
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
      label: _currentValue.round().toString(),
      value: _currentValue,
      onChanged: _setCurrentValue,
    );
  }
}

class _ZoneButtons extends StatelessWidget {
  const _ZoneButtons({
    Key? key,
    required this.zone,
    required this.onRunPressed,
    required this.onStopPressed,
  }) : super(key: key);

  final Zone zone;
  final VoidCallback onRunPressed;
  final VoidCallback onStopPressed;

  List<Widget> _buildZoneButtons(BuildContext context) {
    if (zone.isRunning) {
      return [
        const Spacer(),
        _ZoneButton(
          text: 'Stop',
          onPressed: onStopPressed,
        ),
        const Spacer(),
      ];
    } else {
      return [
        const Spacer(),
        _ZoneButton(
          text: 'Suspend',
          onPressed: () {},
        ),
        const Spacer(),
        _ZoneButton(
          text: 'Run',
          onPressed: onRunPressed,
        ),
        const Spacer(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: _buildZoneButtons(context),
      ),
    );
  }
}

class _ZoneButton extends StatelessWidget {
  const _ZoneButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RunZoneCubit, RunZoneState>(
      builder: (_, state) {
        final isLoading = state.when(resting: () => false, loading: () => true);
        return ActionChip(
          onPressed: onPressed,
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: !isLoading,
                    child: Text(text),
                  ),
                  Visibility(
                    visible: isLoading,
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ZoneHeader extends StatelessWidget {
  const _ZoneHeader({
    Key? key,
    required this.zone,
  }) : super(key: key);

  final Zone zone;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Hero(
        tag: zone,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.lightGreen,
                    ],
                  ),
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    zone.physicalNumber.toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              if (zone.isRunning)
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextWaterText extends StatelessWidget {
  const _NextWaterText({
    Key? key,
    required this.zone,
  }) : super(key: key);

  final Zone zone;

  @override
  Widget build(BuildContext context) {
    final secondsUntilNextRun = zone.secondsUntilNextRun;
    if (secondsUntilNextRun == 1) {
      final endOfRun = DateTime.now().add(
        Duration(seconds: zone.lengthOfNextRunTimeOrTimeRemaining),
      );
      final difference = DateTime.now().difference(endOfRun).abs();
      if (difference.inHours > 1) {
        return Text('Running for ${difference.inHours} more hours');
      } else if (difference.inMinutes >= 1) {
        return Text('Running for ${difference.inMinutes} more minutes');
      } else {
        return Text('Running for ${difference.inSeconds} more seconds');
      }
    } else {
      final nextRun = zone.dateTimeOfNextRun;
      final difference = DateTime.now().difference(nextRun).abs();
      if (difference.inDays > 1) {
        return Text('Scheduled to water in ${difference.inDays} days');
      } else if (difference.inHours > 1) {
        return Text('Scheduled to water in ${difference.inHours} hours');
      } else if (difference.inMinutes > 1) {
        return Text('Scheduled to water in ${difference.inMinutes} minutes');
      } else {
        return Text('Scheduled to water in ${difference.inSeconds} seconds');
      }
    }
  }
}
