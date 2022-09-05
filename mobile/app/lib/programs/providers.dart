import 'package:api_models/api_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/app/app.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/programs/programs.dart';

part 'providers.freezed.dart';

@freezed
class ProgramsState with _$ProgramsState {
  factory ProgramsState({
    required List<Program> programs,
  }) = _ProgramsState;
}

final getProgramsProvider = Provider<GetPrograms>((ref) {
  return GetPrograms(
    httpClient: ref.watch(httpClientProvider),
  );
});

final createProgramProvider = Provider<CreateProgram>((ref) {
  return CreateProgram(
    httpClient: ref.watch(httpClientProvider),
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

final updateProgramProvider = Provider<UpdateProgram>((ref) {
  return UpdateProgram(
    client: ref.watch(httpClientProvider),
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

final programsProvider = FutureProvider<List<Program>>((ref) async {
  final getPrograms = ref.watch(getProgramsProvider);
  return getPrograms();
});
