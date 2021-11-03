import 'package:dio/dio.dart';

class AuthenticationInterceptor extends Interceptor {
  final VoidCallback _onAuthenticationFailure;

  AuthenticationInterceptor({required VoidCallback onAuthenticationFailure})
      : _onAuthenticationFailure = onAuthenticationFailure;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 404) {
      _onAuthenticationFailure();
    }
    super.onError(err, handler);
  }
}
