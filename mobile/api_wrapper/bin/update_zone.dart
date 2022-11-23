import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';

import 'postgres_extensions.dart';

class UpdateZone {
  UpdateZone(this.db);

  final PostgreSQLConnection Function() db;

  Future<Response> call(Request request) async {
    final body = await request.readAsString();
    final updateZoneRequest = UpdateZoneRequest.fromJson(
      json.decode(body),
    );

    return db().use((connection) async {
      await connection.query(
        _updateZoneSql(updateZoneRequest),
      );

      return Response(
        204,
        headers: {'Content-Type': 'application/json'},
      );
    });
  }
}

String _updateZoneSql(
  UpdateZoneRequest request,
) =>
    'UPDATE zone '
    'SET zone_name = \'${request.zoneName}\' '
    'WHERE zone_id = \'${request.zoneId}\';';
