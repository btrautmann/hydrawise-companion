// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/core-ui/widgets/h_stretch.dart';
import 'package:hydrawise/customer_details/api/get_api_key.dart';
import 'package:hydrawise/customer_details/api/set_api_key.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/customer_details/customer_details.dart';
import 'package:hydrawise/customer_details/domain/clear_customer_details.dart';
import 'package:hydrawise/customer_details/domain/get_customer_details.dart';
import 'package:hydrawise/customer_details/models/controller.dart';
import 'package:hydrawise/customer_details/models/customer_details.dart';
import 'package:hydrawise/customer_details/models/customer_status.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/l10n/l10n.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerDetailsCubit(
        getCustomerDetails: context.read<GetCustomerDetails>(),
        getCustomerStatus: context.read<GetCustomerStatus>(),
        getApiKey: context.read<GetApiKey>(),
        setApiKey: context.read<SetApiKey>(),
        clearCustomerDetails: context.read<ClearCustomerDetails>(),
      ),
      child: const CustomerDetailsView(),
    );
  }
}

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterAppBarTitle),
        actions: [_LogOutButton()],
      ),
      body: const _CustomerDetailsStateView(),
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
        return const CircularProgressIndicator();
      },
      empty: () {
        return _ApiKeyInput();
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Greeting(
          unixEpochMilliseconds:
              customerStatus.timeOfLastStatusUnixEpoch * 1000,
        ),
        _ActiveControllerView(
          controllers: customerDetails.controllers,
          activeControllerId: customerDetails.activeControllerId,
        ),
        _ZoneGrid(zones: customerStatus.zones),
      ],
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(text, style: theme.textTheme.headline4),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: HStretch(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(activeController.name),
                  Text(activeController.status),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ZoneGrid extends StatelessWidget {
  const _ZoneGrid({Key? key, required this.zones}) : super(key: key);

  final List<Zone> zones;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.count(
          shrinkWrap: true,
          primary: false,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(16),
          crossAxisCount: 3,
          children: zones.map((e) => _ZoneCell(zone: e)).toList(),
        )
      ],
    );
  }
}

class _ZoneCell extends StatelessWidget {
  const _ZoneCell({
    Key? key,
    required this.zone,
  }) : super(key: key);

  final Zone zone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightGreen,
            Colors.green,
          ],
        ),
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Center(
        child: Text(
          zone.physicalNumber.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
