import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';
import 'package:hydrawise/features/programs/programs.dart';

abstract class CreateProgram {
  Future<Program> call({
    required String name,
    required Frequency frequency,
    required List<Run> runs,
  });
}

class AddProgramToRepository implements CreateProgram {
  final CustomerDetailsRepository _repository;

  AddProgramToRepository({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  @override
  Future<Program> call({
    required String name,
    required Frequency frequency,
    required List<Run> runs,
  }) {
    return _repository.createProgram(name, frequency, runs);
  }
}
