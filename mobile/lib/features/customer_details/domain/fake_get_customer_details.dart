import 'package:irri/core/core.dart';
import 'package:irri/features/customer_details/customer_details.dart';
import 'package:result_type/result_type.dart';

class GetFakeCustomerDetails implements GetCustomerDetails {
  @override
  Future<UseCaseResult<CustomerDetails, String>> call() async {
    return Success(
      CustomerDetails(
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
      ),
    );
  }
}
