import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/domain/get_next_poll_time.dart';
import 'package:hydrawise/customer_details/domain/set_next_poll_time.dart';
import 'package:hydrawise/customer_details/models/customer_status.dart';
import 'package:hydrawise/customer_details/models/zone.dart';
import 'package:hydrawise/customer_details/repository/customer_details_repository.dart';
import 'package:result_type/result_type.dart';

typedef GetCustomerStatus = Future<UseCaseResult<CustomerStatus, String>>
    Function({
  int? activeControllerId,
});

class GetCustomerStatusFromNetwork {
  GetCustomerStatusFromNetwork({
    required HttpClient httpClient,
    required CustomerDetailsRepository repository,
    required GetApiKey getApiKey,
    required SetNextPollTime setNextPollTime,
    required GetNextPollTime getNextPollTime,
  })  : _httpClient = httpClient,
        _repository = repository,
        _getApiKey = getApiKey,
        _setNextPollTime = setNextPollTime,
        _getNextPollTime = getNextPollTime;

  final HttpClient _httpClient;
  final CustomerDetailsRepository _repository;
  final GetApiKey _getApiKey;
  final SetNextPollTime _setNextPollTime;
  final GetNextPollTime _getNextPollTime;

  Future<UseCaseResult<CustomerStatus, String>> call({
    int? activeControllerId,
  }) async {
    final nextPollTime = await _getNextPollTime();

    if (DateTime.now().isAfter(nextPollTime)) {
      final apiKey = await _getApiKey();
      final queryParameters = {
        'api_key': apiKey!,
      };
      if (activeControllerId != null) {
        queryParameters['controller_id'] = activeControllerId.toString();
      }

      final response = await _httpClient.get<Map<String, dynamic>>(
        'statusschedule.php',
        queryParameters: queryParameters,
      );

      if (response.isSuccess) {
        final customerStatus = CustomerStatus.fromJson(response.success!);

        await _repository.updateCustomer(customerStatus);

        final secondsUntilNextPoll =
            customerStatus.numberOfSecondsUntilNextRequest;
        await _setNextPollTime(secondsUntilNextPoll: secondsUntilNextPoll);

        return Success(customerStatus);
      }

      return Failure("Can't fetch customer status");
    }

    final zones = await _repository.getZones();
    final customer = await _repository.getCustomer();

    return Success(CustomerStatus(
      numberOfSecondsUntilNextRequest:
          DateTime.now().difference(nextPollTime).inSeconds.abs(),
      timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
      zones: zones,
    ));
  }
}

class GetFakeCustomerStatus {
  GetFakeCustomerStatus({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<UseCaseResult<CustomerStatus, String>> call({
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

    return Success(CustomerStatus(
      numberOfSecondsUntilNextRequest: 5,
      timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
      zones: zones,
    ));
  }
}
