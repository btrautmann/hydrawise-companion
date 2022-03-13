import 'package:flutter/material.dart';
import 'package:irri/core-ui/core_ui.dart';
import 'package:irri/features/customer_details/customer_details.dart';

class ZoneCell extends StatelessWidget {
  const ZoneCell({
    Key? key,
    required this.zone,
    required this.onZoneTapped,
  }) : super(key: key);

  final Zone zone;
  final ValueSetter<Zone> onZoneTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onZoneTapped(zone),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 52,
                maxWidth: 52,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Center(
                child: Text(zone.physicalNumber.toString()),
              ),
            ),
          ),
        ),
        const VSpace(spacing: 6),
        Text(zone.name),
      ],
    );
  }
}
