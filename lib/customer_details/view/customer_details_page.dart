// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/core-ui/widgets/h_stretch.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/customer_details/customer_details.dart';
import 'package:hydrawise/customer_details/models/controller.dart';
import 'package:hydrawise/customer_details/models/customer_details.dart';
import 'package:hydrawise/customer_details/models/customer_status.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/customer_details/view/run_zones_page.dart';
import 'package:hydrawise/weather/weather.dart';
import 'package:intl/intl.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomerDetailsView();
  }
}

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(child: _CustomerDetailsStateView()),
      // TODO(brandon): Bottom bar should only show when we have details
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_outlined),
            label: 'Programs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Utilities',
          ),
        ],
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<CustomerDetailsCubit>().logOut();
      },
      icon: const Icon(Icons.exit_to_app_rounded),
    );
  }
}

class _CustomerDetailsStateView extends StatelessWidget {
  const _CustomerDetailsStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerDetails =
        context.select((CustomerDetailsCubit cubit) => cubit.state);
    return customerDetails.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      empty: () {
        return Center(child: _ApiKeyInput());
      },
      complete: (details, status) {
        return _AllCustomerContent(
          customerDetails: details,
          customerStatus: status,
        );
      },
    );
  }
}

class _ApiKeyInput extends StatefulWidget {
  @override
  __ApiKeyInputState createState() => __ApiKeyInputState();
}

class __ApiKeyInputState extends State<_ApiKeyInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your Hydrawise API key',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<CustomerDetailsCubit>()
                  .updateApiKey(_controller.text);
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}

class _AllCustomerContent extends StatelessWidget {
  const _AllCustomerContent({
    Key? key,
    required this.customerDetails,
    required this.customerStatus,
  }) : super(key: key);

  final CustomerDetails customerDetails;
  final CustomerStatus customerStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Greeting(
            unixEpochMilliseconds:
                customerStatus.timeOfLastStatusUnixEpoch * 1000,
          ),
          _ZoneList(
            zones: customerStatus.zones,
            onZoneTapped: (zone) {
              // TODO(brandon): Figure out navigation pattern
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => RunZonesPage(
                    zone: zone,
                  ),
                ),
              );
            },
          ),
          const WeatherDetailsCard(),
        ],
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({
    Key? key,
    required this.unixEpochMilliseconds,
  }) : super(key: key);

  final int unixEpochMilliseconds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateTime = DateTime.fromMillisecondsSinceEpoch(unixEpochMilliseconds);
    String text;
    if (dateTime.hour <= 12) {
      text = 'Good morning';
    } else if (dateTime.hour <= 18) {
      text = 'Good afternoon';
    } else {
      text = 'Good evening';
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: theme.textTheme.headline5,
      ),
    );
  }
}

class _ActiveControllerView extends StatelessWidget {
  const _ActiveControllerView({
    Key? key,
    required this.controllers,
    required this.activeControllerId,
  }) : super(key: key);

  final List<Controller> controllers;
  final int activeControllerId;

  @override
  Widget build(BuildContext context) {
    final activeController =
        controllers.singleWhere((element) => element.id == activeControllerId);
    return HStretch(
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.lightGreen,
              ],
            ),
            color: Colors.green,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text('👍', style: Theme.of(context).textTheme.headline4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        activeController.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HStretch(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.lightBlue,
                      Colors.blue,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Watering Schedule',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
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

  String formattedTimeOfNextRun(Zone zone) {
    // TODO(brandon): Show 12/24hr time based on device setting
    final formatter = DateFormat('h:mm a');
    return formatter.format(zone.dateTimeOfNextRun);
  }

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
                Text(formattedTimeOfNextRun(zone)),
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
