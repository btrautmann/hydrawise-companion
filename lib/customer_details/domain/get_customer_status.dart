import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/domain/get_next_poll_time.dart';
import 'package:hydrawise/customer_details/domain/set_next_poll_time.dart';
import 'package:hydrawise/customer_details/models/customer_status.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/customer_details/repository/customer_details_repository.dart';

typedef GetCustomerStatus = Future<CustomerStatus> Function({
  int? activeControllerId,
});

class GetCustomerStatusFromNetwork {
  GetCustomerStatusFromNetwork({
    required CustomerDetailsRepository repository,
    required GetApiKey getApiKey,
    required SetNextPollTime setNextPollTime,
    required GetNextPollTime getNextPollTime,
  })  : _repository = repository,
        _getApiKey = getApiKey,
        _setNextPollTime = setNextPollTime,
        _getNextPollTime = getNextPollTime;

  final CustomerDetailsRepository _repository;
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

      await _repository.updateCustomer(customerStatus);

      final secondsUntilNextPoll =
          customerStatus.numberOfSecondsUntilNextRequest;
      await _setNextPollTime(secondsUntilNextPoll: secondsUntilNextPoll);

      return customerStatus;
    }

    final zones = await _repository.getZones();
    final customer = await _repository.getCustomer();

    return CustomerStatus(
      numberOfSecondsUntilNextRequest:
          DateTime.now().difference(nextPollTime).inSeconds.abs(),
      timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
      zones: zones,
    );
  }
}

class GetFakeCustomerStatus {
  GetFakeCustomerStatus({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<CustomerStatus> call({
    int? activeControllerId,
  }) async {
    final zones = <Zone>[];
    final queriedZones = await _repository.getZones();
    final customer = await _repository.getCustomer();
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
      await _repository.insertZone(fakeZone);
    } else {
      zones.addAll(queriedZones);
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    return CustomerStatus(
      numberOfSecondsUntilNextRequest: 5,
      timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
      zones: zones,
    );
  }
}
