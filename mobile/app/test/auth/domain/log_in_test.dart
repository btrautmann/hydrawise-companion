import 'package:api_models/api_models.dart';
import 'package:charlatan/charlatan.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

import '../../core/fakes/fake_http_client.dart';

void main() {
  group('LogIn', () {
    final storage = InMemoryStorage();
    final setApiKey = SetApiKey(storage);
    final charlatan = Charlatan();
    late LogIn subject;

    setUp(storage.clearAll);

    group('when api key is valid', () {
      setUp(() {
        charlatan.whenPost(
          'login',
          (request) => CharlatanHttpResponse(
            body: LoginResponse(
              customer: Customer(
                customerId: 1,
                activeControllerId: 1,
              ),
            ),
          ),
        );
        subject = LogIn(
          httpClient: FakeHttpClient(charlatan),
          setApiKey: setApiKey,
        );
      });

      test('it returns true', () async {
        final isLoggedIn = await subject.call('fake-api-key', 'fake-timezone');
        expect(isLoggedIn, isTrue);
      });
    });

    group('when api key is invalid', () {
      setUp(() {
        charlatan.whenPost(
          'login',
          (request) => CharlatanHttpResponse(
            statusCode: 401,
          ),
        );
        subject = LogIn(
          httpClient: FakeHttpClient(charlatan),
          setApiKey: setApiKey,
        );
      });

      test('it returns false', () async {
        final isLoggedIn = await subject.call('apiKey', 'fake-timezone');
        expect(isLoggedIn, isFalse);
      });
    });
  });
}
