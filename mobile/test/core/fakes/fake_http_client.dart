import 'package:charlatan/charlatan.dart';
import 'package:dio/dio.dart';
import 'package:irri/core/core.dart';

class FakeHttpClient extends HttpClient {
  FakeHttpClient(Charlatan charlatan)
      : super(
          baseUrl: 'http://localhost',
          dio: Dio(),
          customAdapter: charlatan.toFakeHttpClientAdapter(),
        );
}
