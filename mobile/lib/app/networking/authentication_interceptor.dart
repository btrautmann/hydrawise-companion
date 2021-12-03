import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// An [Interceptor] that intercepts errors and checks
/// for a 404 error code which indicates the user is no
/// longer authenticated and should be routed back to login
class AuthenticationInterceptor extends Interceptor {
  AuthenticationInterceptor({
    required VoidCallback onAuthenticationFailure,
  }) : _onAuthenticationFailure = onAuthenticationFailure;

  final VoidCallback _onAuthenticationFailure;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final allowAuthErrors =
        err.requestOptions.extra['allow_auth_errors'] as bool? ?? false;
    if (err.response?.statusCode == 404 && !allowAuthErrors) {
      _onAuthenticationFailure();
    }
    super.onError(err, handler);
  }
}
