import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/app/networking/authentication_interceptor.dart';

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
    group('onError', () {
      test('it invokes the callback when a 404 is encountered', () async {
        var authenticationFailure = false;
        AuthenticationInterceptor(
          onAuthenticationFailure: () {
            authenticationFailure = true;
          },
        ).onError(
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
  });
}
