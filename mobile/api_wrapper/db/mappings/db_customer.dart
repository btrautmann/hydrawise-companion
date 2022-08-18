import 'package:api_models/api_models.dart';

import '../models/db_customer.dart';

extension DbCustomerMappings on DbCustomer {
  Customer toCustomer() => Customer(
        customerId: id,
        activeControllerId: activeControllerId,
      );
}
