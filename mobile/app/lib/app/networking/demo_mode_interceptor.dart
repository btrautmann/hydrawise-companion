import 'package:api_models/api_models.dart';
import 'package:dio/dio.dart';

/// An [Interceptor] that intercepts requests and checks for the
/// existence of a `demo` API key. If that key is present, we're
/// in demo mode and this interceptor will return fake data for
/// the purpose of navigating the app and demonstrating its features
class DemoModeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = options.queryParameters['api_key'];
    if (apiKey != null && apiKey == 'demo') {
      if (options.uri.pathSegments.contains('login')) {
        handler.resolve(
          Response(
            statusCode: 200,
            requestOptions: options,
            data: LoginResponse(
              customer: Customer(
                activeControllerId: 1,
                customerId: 1,
              ),
            ).toJson(),
          ),
        );
      } else if (options.uri.pathSegments.contains('customer')) {
        handler.resolve(
          Response(
            statusCode: 200,
            requestOptions: options,
            data: GetCustomerResponse(
              customer: Customer(
                activeControllerId: 1,
                customerId: 1,
              ),
              zones: List.of(
                [
                  Zone(
                    id: 12345,
                    number: 1,
                    name: 'Fake Zone',
                    timeUntilNextRunSec: 60,
                    runLengthSec: 60,
                  )
                ],
              ),
            ).toJson(),
          ),
        );
      }
    } else {
      handler.next(options);
    }
  }
}
