import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hydrawise/app/networking/authentication_interceptor.dart';
import 'package:hydrawise/app/networking/demo_mode_interceptor.dart';

/// Contract for building the interceptors that will be
/// added to the HttpClient
// ignore: one_member_abstracts
abstract class BuildHttpInterceptors {
  Future<List<Interceptor>> call();
}

class BuildProductionHttpInterceptors implements BuildHttpInterceptors {
  BuildProductionHttpInterceptors({
    required VoidCallback onAuthenticationFailure,
  }) : _onAuthenticationFailure = onAuthenticationFailure;

  final VoidCallback _onAuthenticationFailure;

  @override
  Future<List<Interceptor>> call() async {
    return [
      DemoModeInterceptor(),
      AuthenticationInterceptor(
        onAuthenticationFailure: _onAuthenticationFailure,
      ),
      // Always place LogInterceptor at the end
      LogInterceptor(logPrint: (o) => debugPrint.call(o.toString())),
    ];
  }
}

class BuildStagingHttpInterceptors implements BuildHttpInterceptors {
  BuildStagingHttpInterceptors({
    required VoidCallback onAuthenticationFailure,
  }) : _onAuthenticationFailure = onAuthenticationFailure;

  final VoidCallback _onAuthenticationFailure;

  @override
  Future<List<Interceptor>> call() {
    return BuildProductionHttpInterceptors(
      onAuthenticationFailure: _onAuthenticationFailure,
    ).call();
  }
}
