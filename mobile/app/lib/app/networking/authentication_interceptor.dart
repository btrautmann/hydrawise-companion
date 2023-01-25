import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthenticationInterceptor extends Interceptor {
  AuthenticationInterceptor({
    required VoidCallback onAuthenticationFailure,
  }) : _onAuthenticationFailure = onAuthenticationFailure;

  final VoidCallback _onAuthenticationFailure;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 404) {
      _onAuthenticationFailure();
    }
    super.onError(err, handler);
  }
}
