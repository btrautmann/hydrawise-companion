import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/customer_details/cubit/run_zone_cubit.dart';
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

class _RunZonesView extends StatelessWidget {
  const _RunZonesView({
    Key? key,
    required this.zone,
  }) : super(key: key);

  final Zone zone;
  @override
  Widget build(BuildContext context) {
    final isLoading = context.read<RunZoneCubit>().state.when(
          resting: () => false,
          loading: () => true,
        );
    print('isLoading? $isLoading');
    return context
        .select((CustomerDetailsCubit cubit) => cubit.state)
        .maybeWhen(
      complete: (details, status) {
        final selectedZone =
            status.zones.singleWhere((element) => element.id == zone.id);
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
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: _RunLengthSlider(),
                  ),
                _ZoneButtons(
                  zone: selectedZone,
                  isLoading: isLoading,
                  onRunPressed: () {
                    // TODO(brandon): Figure out correct way to get time from
                    // slider
                    context.read<RunZoneCubit>().runZone(runLengthMinutes: 1);
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
        return const SizedBox.shrink();
      },
    );
  }
}

class _RunLengthSlider extends StatefulWidget {
  const _RunLengthSlider({
    Key? key,
  }) : super(key: key);

  @override
  __RunLengthSliderState createState() => __RunLengthSliderState();
}

class __RunLengthSliderState extends State<_RunLengthSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 1,
      max: 90,
      divisions: 90,
      value: 5,
      onChanged: (value) {},
    );
  }
}

class _ZoneButtons extends StatelessWidget {
  const _ZoneButtons({
    Key? key,
    required this.zone,
    required this.onRunPressed,
    required this.onStopPressed,
    required this.isLoading,
  }) : super(key: key);

  final Zone zone;
  final VoidCallback onRunPressed;
  final VoidCallback onStopPressed;
  final bool isLoading;

  List<Widget> _buildZoneButtons(BuildContext context) {
    if (zone.isRunning) {
      return [
        const Spacer(),
        _ZoneButton(
          text: 'Stop',
          onPressed: onStopPressed,
          isLoading: isLoading,
        ),
        const Spacer(),
      ];
    } else {
      return [
        const Spacer(),
        _ZoneButton(
          text: 'Suspend',
          onPressed: () {},
          isLoading: isLoading,
        ),
        const Spacer(),
        _ZoneButton(
          text: 'Run',
          onPressed: onRunPressed,
          isLoading: isLoading,
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
    required this.isLoading,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onPressed,
      label: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(text),
              Visibility(
                visible: isLoading,
                child: const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
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
