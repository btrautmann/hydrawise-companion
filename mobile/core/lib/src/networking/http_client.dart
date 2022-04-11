import 'package:dio/dio.dart';
import 'package:result_type/result_type.dart';

typedef NetworkResult<T> = Result<T, DioError>;

class HttpClient {
  HttpClient({
    required Dio dio,
    required String baseUrl,
    List<Interceptor>? interceptors,
    HttpClientAdapter? customAdapter,
    ResponseDecoder? responseDecoder,
  }) : _dio = dio {
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

  Future<NetworkResult<T?>> _request<T extends Object>(
    String path,
    String method,
    Map<String, Object>? queryParameters,
    Options? options,
  ) async {
    try {
      final optionsWithMethod = options?..copyWith(method: method);
      final response = await _dio.request(
        path,
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
    return _request(path, 'GET', queryParameters, options);
  }

  Future<NetworkResult<T?>> post<T extends Object>(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _request(path, 'POST', queryParameters, options);
  }

  Future<NetworkResult<T?>> put<T extends Object>(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _request(path, 'PUT', queryParameters, options);
  }

  Future<NetworkResult<T?>> delete<T extends Object>(
    String path, {
    Map<String, Object>? queryParameters,
    Options? options,
  }) async {
    return _request(path, 'DELETE', queryParameters, options);
  }
}