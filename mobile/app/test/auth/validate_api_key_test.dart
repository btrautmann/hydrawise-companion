import 'package:charlatan/charlatan.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/hydrawise.dart';
import 'package:irri/auth/auth.dart';

import '../core/fakes/fake_http_client.dart';

void main() {
  late ValidateApiKey subject;
  final storage = InMemoryStorage();
  final setApiKey = SetApiKey(storage);
  final getApiKey = GetApiKey(storage);

  group('call(:apiKey)', () {
    Future<void> _buildSubject(Charlatan charlatan) async {
      final client = FakeHttpClient(charlatan);
      subject = ValidateApiKey(
        httpClient: client,
        setApiKey: setApiKey,
      );
    }

    setUp(() async {
      await storage.clearAll();
    });

    test('it hits the api with correct parameters', () async {
      late Map<String, Object?> queryParameters;
      late RequestOptions options;

      final charlatan = Charlatan()
        ..whenGet('customerdetails.php', (request) {
          queryParameters = request.queryParameters;
          options = request.requestOptions;
          return CustomerDetails(
            activeControllerId: 1,
            customerId: 1,
            controllers: [],
          );
        });
      await _buildSubject(charlatan);

      await subject.call('fake-api-key');

      expect(queryParameters['api_key'], 'fake-api-key');
      expect(queryParameters['type'], 'controllers');
      expect(options.extra['allow_auth_errors'], true);
    });

    group('when api call succeeds', () {
      setUp(() async {
        final charlatan = Charlatan()
          ..whenGet('customerdetails.php', (request) {
            return CustomerDetails(
              activeControllerId: 1,
              customerId: 1,
              controllers: [],
            );
          });
        await _buildSubject(charlatan);
      });

      test('it sets the api key in storage', () async {
        final apiKeyBefore = await getApiKey();
        expect(apiKeyBefore, isNull);

        await subject.call('fake-api-key');

        final apiKeyAfter = await getApiKey();
        expect(apiKeyAfter, 'fake-api-key');
      });

      test('it returns true', () async {
        final result = await subject.call('fake-api-key');

        expect(result, isTrue);
      });
    });

    group('when api call fails', () {
      setUp(() async {
        final charlatan = Charlatan()
          ..whenGet(
            'customerdetails.php',
            (request) => CharlatanHttpResponse(statusCode: 500),
          );
        await _buildSubject(charlatan);
      });
      test('it does not set api key in storage', () async {
        final apiKeyBefore = await getApiKey();
        expect(apiKeyBefore, isNull);

        await subject.call('fake-api-key');

        final apiKeyAfter = await getApiKey();
        expect(apiKeyAfter, isNull);
      });

      test('it returns false', () async {
        final result = await subject.call('fake-api-key');

        expect(result, isFalse);
      });
    });
  });
}
