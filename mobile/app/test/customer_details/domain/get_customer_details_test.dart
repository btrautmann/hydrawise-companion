import 'package:api_models/api_models.dart';
import 'package:charlatan/charlatan.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('call()', () {
    late GetCustomerDetails subject;
    final storage = InMemoryStorage();
    final repository = InMemoryCustomerDetailsRepository();
    final setApiKey = SetApiKey(storage);

    Future<void> _buildSubject(Charlatan charlatan) async {
      await repository.clearAllData();
      final client = FakeHttpClient(charlatan);
      await setApiKey('fake_api_key');
      subject = GetCustomerDetails(
        httpClient: client,
        getApiKey: GetApiKey(storage),
        repository: repository,
      );
    }

    group('when api call succeeds', () {
      setUp(() async {
        final charlatan = Charlatan()
          ..whenGet(
            'customer',
            (request) => GetCustomerResponse(
              customer: Customer(
                activeControllerId: 1,
                customerId: 1,
                apiKey: 'fake-api-key',
              ),
              zones: [
                Zone(
                  id: 1,
                  number: 1,
                  name: 'Fake Zone',
                  timeUntilNextRunSec: 60,
                  runLengthSec: 600,
                ),
              ],
            ),
          );
        await _buildSubject(charlatan);
      });

      test('it returns customer details', () async {
        final result = await subject.call();
        expect(result.isSuccess, isTrue);
        expect(
          result.success,
          GetCustomerResponse(
            customer: Customer(
              activeControllerId: 1,
              customerId: 1,
              apiKey: 'fake-api-key',
            ),
            zones: [
              Zone(
                id: 1,
                number: 1,
                name: 'Fake Zone',
                timeUntilNextRunSec: 60,
                runLengthSec: 600,
              ),
            ],
          ),
        );
      });

      test('it inserts customer', () async {
        final customerBefore = await repository.getCustomer();
        expect(customerBefore, isNull);
        await subject.call();
        final customerAfter = await repository.getCustomer();
        expect(customerAfter, isNotNull);
      });

      test('it inserts zones', () async {
        final zonesBefore = await repository.getZones();
        expect(zonesBefore, isEmpty);
        await subject.call();
        final zonesAfter = await repository.getZones();
        expect(zonesAfter, isNotEmpty);
      });
    });

    group('when api call fails', () {
      setUp(() async {
        final charlatan = Charlatan()
          ..whenGet(
            'customer',
            (request) => CharlatanHttpResponse(statusCode: 500),
          );
        await _buildSubject(charlatan);
      });

      test('it returns customer details', () async {
        final result = await subject.call();
        expect(result.isFailure, isTrue);
        expect(
          result.failure,
          'Http status error [500]',
        );
      });
    });
  });
}
