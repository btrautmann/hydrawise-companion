import 'package:core/core.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class GetFakeCustomerDetails implements GetCustomerDetails {
  GetFakeCustomerDetails({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  @override
  Future<UseCaseResult<CustomerDetails, String>> call() async {
    final customer = CustomerDetails(
      activeControllerId: 1,
      customerId: 1,
      controllers: [
        Controller(
          name: 'Fake Controller',
          lastContact: 1631616496,
          serialNumber: '123456789',
          id: 1234,
          status: 'All good!',
        ),
      ],
    );

    await _repository.insertCustomer(customer.toCustomer('fake-api-key'));

    return Success(customer);
  }
}
