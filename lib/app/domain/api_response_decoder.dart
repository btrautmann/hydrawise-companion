import 'dart:convert' as convert;

import 'package:dio/dio.dart';

String apiDecoder(
  List<int> responseBytes,
  RequestOptions options,
  ResponseBody responseBody,
) {
  final response = convert.utf8.decode(responseBytes);
  String massagedResponse;
  if (response == 'API key not valid') {
    massagedResponse = '{"error" : "$response"}';
  } else {
    massagedResponse = response;
  }
  return massagedResponse;
}
