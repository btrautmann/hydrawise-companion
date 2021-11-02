import 'package:dio/dio.dart';

class DemoModeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = options.queryParameters['api_key'];
    if (apiKey != null && apiKey == 'demo') {
      // User is in demo mode, return dummy data
      handler.next(options);
    } else {
      handler.next(options);
    }
  }
}
