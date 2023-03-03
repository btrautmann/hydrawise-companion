import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'postgres_extensions.dart';

Middleware authentication(PostgreSQLConnection Function() db) {
  return (innerHandler) {
    return (originalRequest) async {
      final headers = originalRequest.headers;
      final apiKey = headers['api_key'];
      print(originalRequest.url.path);
      if (originalRequest.url.path == 'ping' || originalRequest.url.path == 'test_tasks') {
        print('Returning innerHandler');
        return innerHandler(originalRequest);
      }
      print('Not returning innerHandler');
      if (apiKey == null) {
        return Response(401);
      } else {
        if (originalRequest.url.path == 'login') {
          return innerHandler(originalRequest);
        }
        return db().use((connection) async {
          final customerResult = await connection.query(
            _findCustomerSql(
              apiKey,
            ),
          );
          if (customerResult.isEmpty) {
            return Response(401);
          }
          final customerId = customerResult.single.toColumnMap()['customer_id'] as int;
          final changedRequest = originalRequest.change(headers: {'customer_id': '$customerId'});
          return innerHandler(changedRequest);
        });
      }
    };
  };
}

String _findCustomerSql(String apiKey) => 'SELECT customer_id FROM customer WHERE api_key=\'$apiKey\' LIMIT 1;';
