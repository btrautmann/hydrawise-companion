import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrawise/app/domain/api_response_decoder.dart';
import 'package:result_type/result_type.dart';

typedef NetworkResult<T> = Result<T, DioError>;

class HttpClient {
  HttpClient({
    required Dio dio,
    required String baseUrl,
    List<Interceptor>? interceptors,
  }) : _dio = dio {
    _dio.options.baseUrl = baseUrl;
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
    _dio.options.responseDecoder = (
      responseBytes,
      options,
      responseBody,
    ) =>
        apiDecoder(responseBytes, options, responseBody);
  }

  final Dio _dio;

  void addInterceptors(List<Interceptor> interceptors) {
    _dio.interceptors.addAll(interceptors);
  }

  Future<NetworkResult<T?>> get<T extends Object>(
    String path, {
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    try {
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
    } on DioError catch (e) {
      return Failure(e);
    }
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
  }) {
    return _dio.delete(
      path,
      queryParameters: queryParameters,
    );
  }
}
