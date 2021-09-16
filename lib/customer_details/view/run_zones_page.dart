import 'package:flutter/material.dart';
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
      body: Center(
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
                child: Row(
                  children: [
                    const Spacer(),
                    Chip(
                      label: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Center(child: Text('Suspend')),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Chip(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
