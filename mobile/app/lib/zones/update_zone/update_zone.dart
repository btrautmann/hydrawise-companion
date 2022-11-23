import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/zones/providers.dart';

part 'update_zone_controller.dart';

class UpdateZone {
  UpdateZone({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  Future<bool> call({
    required Zone zone,
    required String name,
  }) async {
    final response = await _httpClient.put<String>(
      'zone',
      data: UpdateZoneRequest(zoneId: zone.id, zoneName: name),
    );
    return response.isSuccess;
  }
}
