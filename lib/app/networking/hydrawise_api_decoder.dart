import 'dart:convert' as convert;

import 'package:dio/dio.dart';

/// A simple decoder that intercepts each response
/// from the Hydrawise API and checks for responses
/// that aren't valid JSON. The String it returns
/// is correct JSON so the rest of the networking
/// pipeline can digest it.
class HydrawiseApiDecoder {
  static String decode(
    List<int> responseBytes,
    RequestOptions options,
    ResponseBody responseBody,
  ) {
    final response = convert.utf8.decode(responseBytes);
    String transformedResponse = response;
    if (response == 'API key not valid') {
      transformedResponse = '{"error": "$response"}';
    }
    return transformedResponse;
  }
}
