import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ConfigurationView(),
      ),
    );
  }
}

class ConfigurationView extends StatelessWidget {
  const ConfigurationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Configuration',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        BlocBuilder<CustomerDetailsCubit, CustomerDetailsState>(
          builder: (context, state) {
            return state.maybeWhen(
              complete: (details, status) {
                return _ZoneList(
                  zones: status.zones,
                  onZoneTapped: (zone) {},
                );
              },
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        )
      ],
    );
  }
}

class _ZoneList extends StatelessWidget {
  const _ZoneList({
    Key? key,
    required this.zones,
    required this.onZoneTapped,
  }) : super(key: key);

  final List<Zone> zones;
  final ValueSetter<Zone> onZoneTapped;

  @override
  Widget build(BuildContext context) {
    zones.sort(
      (z1, z2) => z1.secondsUntilNextRun.compareTo(
        z2.secondsUntilNextRun,
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: ListView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: zones.length,
              itemBuilder: (_, index) {
                return _ZoneCell(
                  zone: zones[index],
                  shouldShowDivider: index != zones.length - 1,
                  onZoneTapped: onZoneTapped,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoneCell extends StatelessWidget {
  const _ZoneCell({
    Key? key,
    required this.zone,
    required this.shouldShowDivider,
    required this.onZoneTapped,
  }) : super(key: key);

  final Zone zone;
  final bool shouldShowDivider;
  final ValueSetter<Zone> onZoneTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onZoneTapped(zone),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Hero(
                    tag: zone,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
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
                          child: Text(zone.physicalNumber.toString()),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(zone.name),
                const Spacer(),
              ],
            ),
          ),
        ),
        if (shouldShowDivider)
          const Divider(
            indent: 16,
          ),
      ],
    );
  }
}
