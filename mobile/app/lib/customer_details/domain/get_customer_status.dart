import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class GetCustomerStatus {
  GetCustomerStatus({
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

    if (clock.now().isAfter(nextPollTime)) {
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
    }

    final zones = await _repository.getZones();
    final customer = await _repository.getCustomer();

    if (customer != null) {
      return Success(
        CustomerStatus(
          numberOfSecondsUntilNextRequest:
              clock.now().difference(nextPollTime).inSeconds.abs(),
          timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
          zones: zones,
        ),
      );
    }

    return Failure("Can't fetch customer status");
  }
}
