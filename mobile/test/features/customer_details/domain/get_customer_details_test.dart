import 'package:charlatan/charlatan.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';

void main() {
  group('call()', () {
    group('when api call succeeds', () {
      late GetCustomerDetails subject;
      setUp(() async {
        final charlatan = Charlatan()
          ..whenGet(
            'customerdetails.php',
            (request) => CustomerDetails(
              activeControllerId: 1,
              customerId: 1,
              controllers: [],
            ),
          );
        final dio = Dio()
          ..httpClientAdapter = charlatan.toFakeHttpClientAdapter();
        final client = HttpClient(
          dio: dio,
          baseUrl: 'http://api.hydrawise.com/api/v1/',
        );
        final storage = InMemoryStorage();
        await storage.setString('api_key', 'fake-api-key');
        subject = GetCustomerDetails(
          httpClient: client,
          getApiKey: GetApiKey(storage),
          repository: InMemoryCustomerDetailsRepository(),
        );
      });

      test('it returns customer details', () async {
        final result = await subject.call();
        expect(result.isSuccess, isTrue);
        expect(
          result.success,
          CustomerDetails(
            activeControllerId: 1,
            customerId: 1,
            controllers: [],
          ),
        );
      });
    });
  });
}
