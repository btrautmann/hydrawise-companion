import 'package:api_models/api_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/programs/create_program/create_program.dart';
import 'package:irri/programs/delete_program/delete_program.dart';
import 'package:irri/programs/get_programs.dart';
import 'package:irri/programs/update_program/update_program.dart';

final getProgramsProvider = Provider<GetPrograms>((ref) {
  return GetPrograms(
    httpClient: ref.watch(httpClientProvider),
  );
});

final createProgramProvider = Provider<CreateProgram>((ref) {
  return CreateProgram(
    httpClient: ref.watch(httpClientProvider),
  );
});

final updateProgramProvider = Provider<UpdateProgram>((ref) {
  return UpdateProgram(
    client: ref.watch(httpClientProvider),
  );
});

final deleteProgramProvider = Provider<DeleteProgram>((ref) {
  return DeleteProgram(
    client: ref.watch(httpClientProvider),
  );
});

FutureProvider<Program?> existingProgramProvider(int? programId) {
  return FutureProvider(
    (ref) {
      if (programId == null) {
        return null;
      }
      final programs = ref.read(programsProvider);
      return programs.maybeWhen(
        data: (programs) {
          return programs.singleWhere((p) => p.id == programId);
        },
        orElse: () => null,
      );
    },
  );
}

final programsProvider = FutureProvider<List<Program>>((ref) async {
  final getPrograms = ref.watch(getProgramsProvider);
  return getPrograms();
});
