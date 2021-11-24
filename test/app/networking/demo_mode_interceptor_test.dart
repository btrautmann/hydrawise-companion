import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/networking/demo_mode_interceptor.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

class FakeRequestInterceptorHandler extends RequestInterceptorHandler {
  FakeRequestInterceptorHandler({
    this.onNext,
    this.onResolve,
    this.onReject,
  });

  final ValueSetter<RequestOptions>? onNext;
  final ValueSetter<Response>? onResolve;
  final ValueSetter<DioError>? onReject;

  @override
  void next(RequestOptions requestOptions) {
    onNext?.call(requestOptions);
  }

  @override
  void resolve(Response response, [bool callFollowingResponseInterceptor = false]) {
    onResolve?.call(response);
  }

  @override
  void reject(DioError error, [bool callFollowingErrorInterceptor = false]) {
    onReject?.call(error);
  }
}

void main() {
  group('DemoModeInterceptor', () {
    final interceptor = DemoModeInterceptor();
    group('onRequest', () {
      group('customerdetails.php', () {
        test(
          'it invokes handler.resolve with dummy data when in demo mode',
          () {
            Response? response;
            interceptor.onRequest(
              RequestOptions(
                path: 'http://api.hydrawise.com/api/v1/customerdetails.php',
                queryParameters: {'api_key': 'demo'},
              ),
              FakeRequestInterceptorHandler(
                onResolve: (r) {
                  response = r;
                },
              ),
            );

            expect(response, isNotNull);
            expect(
              CustomerDetails.fromJson(response!.data as Map<String, dynamic>),
              isA<CustomerDetails>(),
            );
          },
        );
      });

      group('statusschedule.php', () {
        test(
          'it invokes handler.resolve with dummy data when in demo mode',
          () {
            Response? response;
            interceptor.onRequest(
              RequestOptions(
                path: 'http://api.hydrawise.com/api/v1/statusschedule.php',
                queryParameters: {'api_key': 'demo'},
              ),
              FakeRequestInterceptorHandler(
                onResolve: (r) {
                  response = r;
                },
              ),
            );

            expect(response, isNotNull);
            expect(
              CustomerStatus.fromJson(response!.data as Map<String, dynamic>),
              isA<CustomerStatus>(),
            );
          },
        );
      });

      test('it invokes handler.next when not in demo mode', () {
        Response? response;
        RequestOptions? requestOptions;
        interceptor.onRequest(
          RequestOptions(
            path: 'http://api.hydrawise.com/api/v1/customerdetails.php',
          ),
          FakeRequestInterceptorHandler(onResolve: (r) {
            response = r;
          }, onNext: (o) {
            requestOptions = o;
          }),
        );

        expect(response, isNull);
        expect(requestOptions, isNotNull);
      });
    });
  });
}
