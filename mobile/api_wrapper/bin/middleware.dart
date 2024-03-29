import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'utils/_postgresql_connection.dart';

Middleware authentication(PostgreSQLConnection Function() db) {
  return (innerHandler) {
    return (originalRequest) async {
      final headers = originalRequest.headers;
      final apiKey = headers['api_key'];
      // TODO(brandon): Find a better way to annotate/list un-authenticated end-points
      // TODO(brandon): Add static token for authentication on trigger end-points
      final unauthenticatedEndpoints = ['ping', 'trigger_group', 'trigger_run'];
      if (unauthenticatedEndpoints.contains(originalRequest.url.path)) {
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
