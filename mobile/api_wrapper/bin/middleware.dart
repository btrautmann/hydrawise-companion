import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'postgres_extensions.dart';

Middleware authentication(PostgreSQLConnection Function() db) {
  return (innerHandler) {
    return (originalRequest) async {
      final headers = originalRequest.headers;
      final apiKey = headers['api_key'];
      // TODO(brandon): Find a better way to annotate/list un-authenticated end-points
      // TODO(brandon): `run_group` should probably be authentictated, but I'm not sure
      // whether we should pass API key to `tasks` api or find a different way to authenticate
      if (originalRequest.url.path == 'ping' || originalRequest.url.path == 'run_group') {
        return innerHandler(originalRequest);
      }
      if (apiKey == null) {
        return Response(401);
      } else {
        if (originalRequest.url.path == 'login') {
          return innerHandler(originalRequest);
        }
        return db().use((connection) async {
          final customerResult = await connection.query(_findCustomerSql(apiKey));
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
