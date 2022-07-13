import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

class GetCustomer {
  GetCustomer(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final queryParameters = request.url.queryParameters;

    // TODO(brandon): Auth interception
    final apiKey = queryParameters['api_key'];
    if (apiKey == null) {
      return Response(401);
    }
    final queryResults = await db.query(_findCustomerSql(apiKey));
    if (queryResults.isEmpty) {
      return Response(401);
    }
    final customerId = queryResults.single.toColumnMap()['customer_id'] as int?;
    if (customerId == null) {
      return Response(401);
    }

    final customer = Customer(
      customerId: customerId,
      apiKey: apiKey,
      activeControllerId:
          queryResults.single.toColumnMap()['active_controller_id'],
    );

    final zones = <Zone>[];

    await db.transaction((connection) async {
      final zonesResult = await connection.query(_getZonesSql(customerId));
      for (final result in zonesResult) {
        final map = result.toColumnMap();
        zones.add(
          Zone(
            id: map['zone_id'],
            number: map['zone_num'],
            name: map['zone_name'],
            timeUntilNextRunSec: map['time_until_run_sec'],
            runLengthSec: map['run_length_sec'],
          ),
        );
      }
    });
    return Response.ok(
      jsonEncode(
        GetCustomerResponse(
          customer: customer,
          zones: zones,
        ).toJson(),
      ),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

String _findCustomerSql(String apiKey) =>
    'SELECT * FROM customer WHERE api_key=\'$apiKey\' LIMIT 1;';

String _getZonesSql(int customerId) =>
    'SELECT * FROM zone WHERE customer_id=$customerId;';
