import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/networking/authentication_interceptor.dart';

class FakeErrorInterceptorHandler extends ErrorInterceptorHandler {
  @override
  void next(DioError err) {
    // Do nothing
  }

  @override
  void resolve(Response response) {
    // Do nothing
  }

  @override
  void reject(DioError error) {
    // Do nothing
  }
}

void main() {
  group('AuthenticationInterceptor', () {
    test('it invokes the callback when a 404 is encountered', () async {
      bool authenticationFailure = false;
      final authInterceptor = AuthenticationInterceptor(
        onAuthenticationFailure: () {
          authenticationFailure = true;
        },
      );

      authInterceptor.onError(
        DioError(
          requestOptions: RequestOptions(path: 'fake-path'),
          response: Response(
            requestOptions: RequestOptions(path: 'fake-path'),
            statusCode: 404,
          ),
        ),
        FakeErrorInterceptorHandler(),
      );
      expect(authenticationFailure, isTrue);
    });
  });
}
