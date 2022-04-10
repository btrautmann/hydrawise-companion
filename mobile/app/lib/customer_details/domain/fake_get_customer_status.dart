import 'package:core/core.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class GetFakeCustomerStatus implements GetCustomerStatus {
  GetFakeCustomerStatus({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  @override
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

    if (customer != null) {
      return Success(
        CustomerStatus(
          numberOfSecondsUntilNextRequest: 5,
          timeOfLastStatusUnixEpoch: customer.lastStatusUpdate,
          zones: zones,
        ),
      );
    }

    return Failure("Can't fetch customer status");
  }
}
