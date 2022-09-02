import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

Middleware authentication(Future<PostgreSQLConnection> Function() connection) => (innerHandler) => (originalRequest) async {
      final headers = originalRequest.headers;
      final apiKey = headers['api_key'];
      if (originalRequest.url.path == 'check_runs') {
        return innerHandler(originalRequest);
      }
      if (apiKey == null) {
        return Response(401);
      } else {
        if (originalRequest.url.path == 'login') {
          return innerHandler(originalRequest);
        }
        final db = await connection();
        final customerResult = await db.query(_findCustomerSql(apiKey));
        if (customerResult.isEmpty) {
          return Response(401);
        }
        final customerId = customerResult.single.toColumnMap()['customer_id'] as int;
        final changedRequest = originalRequest.change(headers: {'customer_id': '$customerId'});
        return innerHandler(changedRequest);
      }
    };

String _findCustomerSql(String apiKey) => 'SELECT customer_id FROM customer WHERE api_key=\'$apiKey\' LIMIT 1;';
