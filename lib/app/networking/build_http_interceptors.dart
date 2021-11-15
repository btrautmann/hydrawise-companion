import 'package:dio/dio.dart' hide VoidCallback;
import 'package:flutter/material.dart';
import 'package:hydrawise/app/networking/authentication_interceptor.dart';
import 'package:hydrawise/app/networking/demo_mode_interceptor.dart';

/// Contract for building the interceptors that will be
/// added to the HttpClient
abstract class BuildHttpInterceptors {
  Future<List<Interceptor>> call();
}

class BuildProductionHttpInterceptors implements BuildHttpInterceptors {
  final VoidCallback _onAuthenticationFailure;

  BuildProductionHttpInterceptors({
    required VoidCallback onAuthenticationFailure,
  }) : _onAuthenticationFailure = onAuthenticationFailure;

  @override
  Future<List<Interceptor>> call() async {
    return [
      DemoModeInterceptor(),
      AuthenticationInterceptor(
        onAuthenticationFailure: _onAuthenticationFailure,
      ),
      // Always place LogInterceptor at the end
      LogInterceptor(),
    ];
  }
}

class BuildStagingHttpInterceptors implements BuildHttpInterceptors {
  final VoidCallback _onAuthenticationFailure;

  BuildStagingHttpInterceptors({
    required VoidCallback onAuthenticationFailure,
  }) : _onAuthenticationFailure = onAuthenticationFailure;

  @override
  Future<List<Interceptor>> call() {
    return BuildProductionHttpInterceptors(
      onAuthenticationFailure: _onAuthenticationFailure,
    ).call();
  }
}
