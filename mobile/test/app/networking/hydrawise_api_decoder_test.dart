import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/app.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';

void main() {
  group('HydrawiseApiDecoder.decode', () {
    test('it transforms invalid API key response to json', () {
      const invalidApiKeyResponse = 'API key not valid';
      final bytes = utf8.encode(invalidApiKeyResponse);

      final output = HydrawiseApiDecoder.decode(
        bytes,
        RequestOptions(path: 'fake-path'),
        ResponseBody.fromString(invalidApiKeyResponse, 404),
      );

      expect(output, '{"error": "API key not valid"}');
    });

    test('it leaves valid response alone', () {
      final validJsonResponse = RunZoneResponse(
        message: 'It works',
        typeOfMessage: 'info',
      ).toJson();
      final bytes = utf8.encode(validJsonResponse.toString());

      final output = HydrawiseApiDecoder.decode(
        bytes,
        RequestOptions(path: 'fake-path'),
        ResponseBody.fromString(validJsonResponse.toString(), 200),
      );

      expect(output, utf8.decode(bytes));
    });
  });
}
