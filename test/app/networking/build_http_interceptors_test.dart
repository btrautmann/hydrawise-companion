import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/networking/authentication_interceptor.dart';
import 'package:hydrawise/app/networking/build_http_interceptors.dart';
import 'package:hydrawise/app/networking/demo_mode_interceptor.dart';

void main() {
  group('BuildHttpInterceptors', () {
    final buildProductionHttpInterceptors = BuildProductionHttpInterceptors(
      onAuthenticationFailure: () {},
    );
    final buildStagingHttpInterceptors = BuildStagingHttpInterceptors(
      onAuthenticationFailure: () {},
    );

    group('BuildProductionHttpInterceptors', () {
      test('the correct interceptors are returned', () async {
        final interceptors = await buildProductionHttpInterceptors();

        expect(interceptors.length, 3);
        expect(interceptors[0], isA<DemoModeInterceptor>());
        expect(interceptors[1], isA<AuthenticationInterceptor>());
        expect(interceptors[2], isA<LogInterceptor>());
      });
    });

    group('BuildStagingHttpInterceptors', () {
      test('the correct interceptors are returned', () async {
        final interceptors = await buildStagingHttpInterceptors();

        expect(interceptors.length, 3);
        expect(interceptors[0], isA<DemoModeInterceptor>());
        expect(interceptors[1], isA<AuthenticationInterceptor>());
        expect(interceptors[2], isA<LogInterceptor>());
      });
    });
  });
}
