import 'package:api_models/api_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/app.dart';
import 'package:irri/programs/programs.dart';

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

FutureProvider<Program?> existingProgramProvider(int? programId) {
  return FutureProvider(
    (ref) {
      if (programId == null) {
        return null;
      }
      final programs = ref.watch(programsProvider);
      return programs.when(
        data: (programs) {
          return programs.singleWhere((p) => p.id == programId);
        },
        error: (_, __) => null,
        loading: () => null,
      );
    },
  );
}

final programsProvider = FutureProvider<List<Program>>((ref) async {
  final getPrograms = ref.watch(getProgramsProvider);
  return getPrograms();
});
