import 'package:api_models/api_models.dart';

class DbCustomer {
  DbCustomer({
    required this.id,
    required this.apiKey,
    required this.activeControllerId,
  });

  final int id;
  final int activeControllerId;
  final String apiKey;
}

extension DbCustomerX on DbCustomer {
  Customer toCustomer() => Customer(
        customerId: id,
        activeControllerId: activeControllerId,
      );
}
