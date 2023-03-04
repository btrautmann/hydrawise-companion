import 'package:api_models/api_models.dart';
import 'package:core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/programs/providers.dart';
import 'package:irri/zones/providers.dart';

part 'delete_program_controller.dart';

class DeleteProgram {
  DeleteProgram({
    required HttpClient client,
  }) : _client = client;

  final HttpClient _client;

  Future<bool> call({required int programId}) async {
    final response = await _client.delete<Map<String, dynamic>>(
      'program',
      data: DeleteProgramRequest(programId: programId),
    );

    if (response.isSuccess) {
      return true;
    } else {
      throw Exception(response.failure);
    }
  }
}
