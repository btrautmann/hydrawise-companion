import 'package:shelf/shelf.dart';

extension RequestX on Request {
  // ignore: cast_nullable_to_non_nullable
  int get customerId => int.parse(headers['customer_id']!);

  String get apiKey => headers['api_key']!;
}
