import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class GetFakeCustomerDetails implements GetCustomerDetails {
  GetFakeCustomerDetails({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  @override
  Future<UseCaseResult<GetCustomerResponse, String>> call() async {
    final customer = Customer(
      activeControllerId: 1,
      customerId: 1,
      apiKey: 'fake-api-key',
    );

    await _repository.insertCustomer(customer);

    return Success(
      GetCustomerResponse(
        customer: customer,
        zones: List.empty(),
      ),
    );
  }
}
