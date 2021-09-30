import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:result_type/result_type.dart';

typedef NetworkResult<T> = Result<T, DioError>;

class HttpClient {
  HttpClient({
    required Dio dio,
    required String baseUrl,
  }) : _dio = dio {
    _dio.options.baseUrl = baseUrl;
  }

  final Dio _dio;

  Future<Response<T>> get<T extends Object>(
    String path, {
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @optionalTypeArgs
  Future<Response<T>>
      post<T extends Object, OperationFailureExceptionType extends Object>(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @optionalTypeArgs
  Future<Response<T>> put<T extends Object>(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    bool shouldTriggerMutation = true,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @optionalTypeArgs
  Future<Response<T>> delete<T extends Object>(
    String path, {
    Map<String, Object>? queryParameters,
    bool shouldTriggerMutation = true,
  }) {
    return _dio.delete(
      path,
      queryParameters: queryParameters,
    );
  }
}
