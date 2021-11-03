import 'package:dio/dio.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

class DemoModeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = options.queryParameters['api_key'];
    if (apiKey != null && apiKey == 'demo') {
      if (options.uri.pathSegments.contains('customerdetails.php')) {
        handler.resolve(
          Response(
            statusCode: 200,
            requestOptions: options,
            data: CustomerDetails(
              activeControllerId: 1,
              customerId: 1,
              controllers: [
                Controller(
                  id: 1,
                  name: 'Fake Controller',
                  lastContact: DateTime.now().millisecondsSinceEpoch,
                  serialNumber: 'fake-serial-number',
                  status: 'All good!',
                )
              ],
            ).toJson(),
          ),
        );
      } else if (options.uri.pathSegments.contains('statusschedule.php')) {
        handler.resolve(
          Response(
            statusCode: 200,
            requestOptions: options,
            data: CustomerStatus(
              numberOfSecondsUntilNextRequest: 60,
              timeOfLastStatusUnixEpoch: 1635901976,
              zones: [
                Zone(
                  id: 1,
                  physicalNumber: 1,
                  name: 'Fake Zone',
                  nextTimeOfWaterFriendly: '7:00',
                  secondsUntilNextRun: 10000,
                  lengthOfNextRunTimeOrTimeRemaining: 900,
                ),
              ],
            ).toJson(),
          ),
        );
      }
    } else {
      handler.next(options);
    }
  }
}
