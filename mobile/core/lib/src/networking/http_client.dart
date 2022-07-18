import 'dart:async';

import 'package:dio/dio.dart';
import 'package:result_type/result_type.dart';

typedef NetworkResult<T> = Result<T, DioError>;

typedef AuthenticationGetter = FutureOr<String?> Function();

class HttpClient {
  HttpClient({
    required Dio dio,
    required String baseUrl,
    required AuthenticationGetter getAuthentication,
    List<Interceptor>? interceptors,
    HttpClientAdapter? customAdapter,
    ResponseDecoder? responseDecoder,
  })  : _dio = dio,
        _getAuthentication = getAuthentication {
    _dio.options.baseUrl = baseUrl;
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
    if (customAdapter != null) {
      dio.httpClientAdapter = customAdapter;
    }
    if (responseDecoder != null) {
      _dio.options.responseDecoder = responseDecoder;
    }
  }

  final Dio _dio;
  final AuthenticationGetter _getAuthentication;

  Future<NetworkResult<T?>> _request<T extends Object>(
    String path,
    String method,
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
  ) async {
    try {
      late final Map<String, dynamic> headers;
      final nonNullOptions = options ?? Options();
      final authentication = await _getAuthentication();
      if (nonNullOptions.headers?['api_key'] == null && authentication != null) {
        headers = nonNullOptions.headers ?? <String, dynamic>{}
          ..addAll({'api_key': authentication});
      } else {
        headers = nonNullOptions.headers ?? <String, String>{};
      }
      final optionsWithMethod = DioMixin.checkOptions(
        method,
        nonNullOptions.copyWith(
          headers: headers,
        ),
      );
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: optionsWithMethod,
      );
      return Success(response.data);
    } on DioError catch (e) {
      return Failure(e);
    }
  }

  Future<NetworkResult<T?>> get<T extends Object>(
    String path, {
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _request(path, 'GET', null, queryParameters, options);
  }

  Future<NetworkResult<T?>> post<T extends Object>(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _request(path, 'POST', data, queryParameters, options);
  }

  Future<NetworkResult<T?>> put<T extends Object>(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _request(path, 'PUT', data, queryParameters, options);
  }

  Future<NetworkResult<T?>> delete<T extends Object>(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _request(path, 'DELETE', data, queryParameters, options);
  }
}
