import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/domain/get_next_poll_time.dart';
import 'package:hydrawise/customer_details/domain/set_next_poll_time.dart';
import 'package:hydrawise/customer_details/models/customer_identification.dart';
import 'package:hydrawise/customer_details/models/customer_status.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:sqflite/sqlite_api.dart';

typedef GetCustomerStatus = Future<CustomerStatus> Function({
  int? activeControllerId,
});

class GetCustomerStatusFromNetwork {
  GetCustomerStatusFromNetwork({
    required Database database,
    required GetApiKey getApiKey,
    required SetNextPollTime setNextPollTime,
    required GetNextPollTime getNextPollTime,
  })  : _database = database,
        _getApiKey = getApiKey,
        _setNextPollTime = setNextPollTime,
        _getNextPollTime = getNextPollTime;

  final Database _database;
  final GetApiKey _getApiKey;
  final SetNextPollTime _setNextPollTime;
  final GetNextPollTime _getNextPollTime;

  Future<CustomerStatus> call({
    int? activeControllerId,
  }) async {
    final nextPollTime = await _getNextPollTime();

    if (DateTime.now().isAfter(nextPollTime)) {
      final apiKey = await _getApiKey();
      final queryParameters = {
        'api_key': apiKey,
      };
      if (activeControllerId != null) {
        queryParameters['controller_id'] = activeControllerId.toString();
      }
      final uri = Uri.https(
        'api.hydrawise.com',
        '/api/v1/statusschedule.php',
        queryParameters,
      );
      final response = await http.get(uri);

      final decodedCustomerStatus =
          json.decode(response.body) as Map<String, dynamic>;

      final customerStatus = CustomerStatus.fromJson(decodedCustomerStatus);

      final batch = _database.batch();

      customerStatus.zones.map((z) => z.toJson()).forEach((zone) {
        batch.insert(
          'zones',
          zone,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

      final customers = await _database.query('customers');
      final customer = CustomerIdentification.fromJson(customers.first);

      batch.update(
        'customers',
        customer
            .copyWith(
              lastStatusUpdate: customerStatus.timeOfLastStatusUnixEpoch,
            )
            .toJson(),
        where: 'customer_id = ?',
        whereArgs: [customer.customerId],
      );

      await batch.commit();

      final secondsUntilNextPoll =
          customerStatus.numberOfSecondsUntilNextRequest;
      await _setNextPollTime(secondsUntilNextPoll: secondsUntilNextPoll);

      return customerStatus;
    }

    final zones = await _database.query('zones');
    final customers = await _database.query('customers');
    final customer = CustomerIdentification.fromJson(customers.first);

    return CustomerStatus(
      numberOfSecondsUntilNextRequest:
          DateTime.now().difference(nextPollTime).inSeconds.abs(),
      timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
      zones: zones.map((e) => Zone.fromJson(e)).toList(),
    );
  }
}

class GetFakeCustomerStatus {
  GetFakeCustomerStatus({
    required Database database,
  }) : _database = database;

  final Database _database;

  Future<CustomerStatus> call({
    int? activeControllerId,
  }) async {
    final zones = <Zone>[];
    final queriedZones = await _database.query('zones');
    final customers = await _database.query('customers');
    final customer = CustomerIdentification.fromJson(customers.first);
    if (queriedZones.isEmpty) {
      // Insert some dummy zones
      final fakeZone = Zone(
        id: 1,
        physicalNumber: 1,
        name: 'Fake Zone',
        nextTimeOfWaterFriendly: '7:00',
        secondsUntilNextRun: 60,
        lengthOfNextRunTimeOrTimeRemaining: 60,
      );
      await _database.insert('zones', fakeZone.toJson());
    } else {
      zones.addAll(queriedZones.map((e) => Zone.fromJson(e)).toList());
    }

    return CustomerStatus(
      numberOfSecondsUntilNextRequest: 60,
      timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
      zones: zones,
    );
  }
}
