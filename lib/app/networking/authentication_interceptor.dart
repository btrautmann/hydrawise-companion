import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// An [Interceptor] that intercepts errors and checks
/// for a 404 error code which indicates the user is no
/// longer authenticated and should be routed back to login
class AuthenticationInterceptor extends Interceptor {
  final VoidCallback _onAuthenticationFailure;

  AuthenticationInterceptor({
    required VoidCallback onAuthenticationFailure,
  }) : _onAuthenticationFailure = onAuthenticationFailure;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 404) {
      _onAuthenticationFailure();
    }
    super.onError(err, handler);
  }
}
