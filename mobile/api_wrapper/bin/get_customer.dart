import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'extensions.dart';

class GetCustomer {
  GetCustomer(this.db);

  final PostgreSQLConnection db;

  Future<Response> call(Request request) async {
    final customerId = request.customerId;

    late final Customer customer;
    final zones = <Zone>[];
    await db.transaction((connection) async {
      final customerResult = await connection.query(_findCustomerSql(customerId));

      customer = Customer(
        customerId: customerId,
        activeControllerId: customerResult.single.toColumnMap()['active_controller_id'],
      );

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
        ),
      ),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

String _findCustomerSql(int customerId) => 'SELECT * FROM customer WHERE customer_id=$customerId LIMIT 1;';

String _getZonesSql(int customerId) => 'SELECT * FROM zone WHERE customer_id=$customerId;';
