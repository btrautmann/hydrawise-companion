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
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  final Dio _dio;

  Future<NetworkResult<T?>> get<T extends Object>(
    String path, {
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! > 300) {
      return Failure(DioError(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        response: response,
      ));
    }
    return Success(response.data);
  }

  @optionalTypeArgs
  Future<Response<T>> post<T extends Object>(
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
