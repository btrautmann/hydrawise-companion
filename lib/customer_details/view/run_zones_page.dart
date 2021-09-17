import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_cubit.dart';
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
      body: _RunZonesView(zone: zone),
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
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Hero(
                    tag: zone,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _NextWaterText(zone: selectedZone),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Slider(
                    min: 5,
                    max: 100,
                    value: 10,
                    onChanged: print,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      const Spacer(),
                      ActionChip(
                        onPressed: () {
                          print('Suspend');
                        },
                        label: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Center(child: Text('Suspend')),
                          ),
                        ),
                      ),
                      const Spacer(),
                      ActionChip(
                        onPressed: () {
                          print('Run');
                        },
                        label: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Center(child: Text('Run')),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
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
