import 'package:dio/dio.dart';
import 'package:hydrawise/app/domain/authentication_interceptor.dart';
import 'package:hydrawise/app/domain/demo_mode_interceptor.dart';

typedef BuildHttpInterceptors = Future<List<Interceptor>> Function();

class BuildProductionHttpInterceptors {
  final VoidCallback _onAuthenticationFailure;

  BuildProductionHttpInterceptors(
      {required VoidCallback onAuthenticationFailure})
      : _onAuthenticationFailure = onAuthenticationFailure;

  Future<List<Interceptor>> call() async {
    return [
      DemoModeInterceptor(),
      AuthenticationInterceptor(
        onAuthenticationFailure: _onAuthenticationFailure,
      ),
      LogInterceptor(),
    ];
  }
}

class BuildStagingHttpInterceptors {
  Future<List<Interceptor>> call() {
    return Future.value(List.empty());
  }
}

class BuildDevelopmentHttpInterceptors {
  Future<List<Interceptor>> call() {
    return Future.value(List.empty());
  }
}
