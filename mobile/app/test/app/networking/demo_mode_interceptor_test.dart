import 'package:api_models/api_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/app/networking/demo_mode_interceptor.dart';

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
  void resolve(
    Response response, [
    bool callFollowingResponseInterceptor = false,
  ]) {
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
      group('customer', () {
        test(
          'it invokes handler.resolve with dummy data when in demo mode',
          () {
            Response? response;
            interceptor.onRequest(
              RequestOptions(
                path: 'http://localhost:8080/customer',
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
              GetCustomerResponse.fromJson(
                response!.data as Map<String, dynamic>,
              ),
              isA<GetCustomerResponse>(),
            );
          },
        );
      });

      group('login', () {
        test(
          'it invokes handler.resolve with dummy data when in demo mode',
          () {
            Response? response;
            interceptor.onRequest(
              RequestOptions(
                path: 'http://localhost:8080/login',
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
              LoginResponse.fromJson(response!.data as Map<String, dynamic>),
              isA<LoginResponse>(),
            );
          },
        );
      });

      test('it invokes handler.next when not in demo mode', () {
        Response? response;
        RequestOptions? requestOptions;
        interceptor.onRequest(
          RequestOptions(
            path: 'http://localhost:8080/login',
          ),
          FakeRequestInterceptorHandler(
            onResolve: (r) {
              response = r;
            },
            onNext: (o) {
              requestOptions = o;
            },
          ),
        );

        expect(response, isNull);
        expect(requestOptions, isNotNull);
      });
    });
  });
}
