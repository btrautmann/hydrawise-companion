import 'package:api_models/api_models.dart';
import 'package:clock/clock.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/extensions.dart';
import 'package:irri/zones/providers.dart';
import 'package:irri/zones/run_zone/run_zone.dart';
import 'package:irri/zones/stop_zone/stop_zone.dart';

class RunZonePage extends ConsumerWidget {
  const RunZonePage({
    Key? key,
    required this.zoneId,
  }) : super(key: key);

  final int zoneId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zonesState = ref.watch(zonesProvider);
    return zonesState.maybeWhen(
      data: (zones) {
        final zone = zones.singleWhere((element) => element.id == zoneId);
        return Scaffold(
          appBar: AppBar(title: Text(zone.name)),
          body: _RunZoneView(zone: zone),
        );
      },
      orElse: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _RunZoneView extends ConsumerStatefulWidget {
  const _RunZoneView({
    Key? key,
    required this.zone,
  }) : super(key: key);

  final Zone zone;

  @override
  ConsumerState<_RunZoneView> createState() => _RunZonesViewState();
}

class _RunZonesViewState extends ConsumerState<_RunZoneView> {
  Duration selectedRunLength = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _ZoneHeader(zone: widget.zone),
          const VSpace(spacing: 16),
          _NextWaterText(zone: widget.zone),
          if (!widget.zone.isRunning) ...[
            const VSpace(spacing: 16),
            _RunLengthSlider(
              zone: widget.zone,
              onChanged: (value) {
                selectedRunLength = value;
              },
            ),
          ],
          _ZoneButtons(
            zone: widget.zone,
            onRunZone: () {
              ref.read(runZoneControllerProvider.notifier).runZone(
                    zone: widget.zone,
                    runLength: selectedRunLength,
                  );
            },
            onStopZone: () {
              ref.read(stopZoneControllerProvider.notifier).stopZone(
                    zone: widget.zone,
                  );
            },
          ),
        ],
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                zone.number.toString(),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
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
    if (zone.isRunning) {
      final endOfRun = clock.now().add(Duration(seconds: zone.timeRemainingSec));
      final difference = clock.now().difference(endOfRun).abs();
      if (difference.inHours > 1) {
        return Text('Running for ${difference.inHours} more hours');
      } else if (difference.inMinutes >= 1) {
        final pluralized = difference.inMinutes == 1 ? 'minute' : 'minutes';
        return Text('Running for ${difference.inMinutes} more $pluralized');
      } else {
        return Text('Running for ${difference.inSeconds} more seconds');
      }
    } else {
      final nextRun = zone.dateTimeOfNextRun;
      final difference = clock.now().difference(nextRun).abs();
      if (difference.inDays > 1000) {
        return const Text('Not scheduled to water');
      }
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

class _ZoneButtons extends StatelessWidget {
  const _ZoneButtons({
    Key? key,
    required this.zone,
    required this.onStopZone,
    required this.onRunZone,
  }) : super(key: key);

  final Zone zone;
  final VoidCallback onStopZone;
  final VoidCallback onRunZone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (zone.isRunning) ...[
            _ZoneButton(
              text: 'Stop',
              onPressed: onStopZone,
            ),
          ],
          if (!zone.isRunning) ...[
            _ZoneButton(
              text: 'Run',
              onPressed: onRunZone,
            ),
          ]
        ],
      ),
    );
  }
}

class _ZoneButton extends ConsumerWidget {
  const _ZoneButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runZoneState = ref.watch(runZoneControllerProvider);
    final isLoading = runZoneState.maybeMap(loading: (_) => true, orElse: () => false);

    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: !isLoading,
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Text(text),
              ),
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
    );
  }
}
