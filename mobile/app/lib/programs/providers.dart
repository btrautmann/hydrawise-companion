import 'package:api_models/api_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final programsProvider = FutureProvider<List<Program>>((ref) async {
  final getPrograms = ref.watch(getProgramsProvider);
  return getPrograms();
});
