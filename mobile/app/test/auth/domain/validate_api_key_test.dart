import 'package:api_models/api_models.dart';
import 'package:charlatan/charlatan.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  late LogIn subject;
  final storage = InMemoryStorage();
  final setApiKey = SetApiKey(storage);
  final getApiKey = GetApiKey(storage);

  group('call(:apiKey)', () {
    Future<void> _buildSubject(Charlatan charlatan) async {
      final client = FakeHttpClient(charlatan);
      subject = LogIn(
        httpClient: client,
        setApiKey: setApiKey,
      );
    }

    setUp(() async {
      await storage.clearAll();
    });

    test('it hits the api with correct parameters', () async {
      late final LoginRequest loginRequest;
      late final RequestOptions options;

      final charlatan = Charlatan()
        ..whenPost('login', (request) {
          loginRequest =
              // ignore: cast_nullable_to_non_nullable
              LoginRequest.fromJson(request.body as Map<String, dynamic>);
          options = request.requestOptions;
          return Customer(
            activeControllerId: 1,
            customerId: 1,
            apiKey: 'fake-api-key',
          );
        });
      await _buildSubject(charlatan);

      await subject.call('fake-api-key');

      expect(loginRequest.apiKey, 'fake-api-key');
      expect(loginRequest.type, 'controllers');
      expect(options.extra['allow_auth_errors'], true);
    });

    group('when api call succeeds', () {
      setUp(() async {
        final charlatan = Charlatan()
          ..whenPost('login', (request) {
            return Customer(
              activeControllerId: 1,
              customerId: 1,
              apiKey: 'fake-api-key',
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
          ..whenPost(
            'login',
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
