import 'package:charlatan/charlatan.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';

class FakeHttpClient extends HttpClient {
  FakeHttpClient(Charlatan charlatan)
      : super(
          baseUrl: 'http://localhost',
          dio: Dio(),
          customAdapter: charlatan.toFakeHttpClientAdapter(),
        );
}
