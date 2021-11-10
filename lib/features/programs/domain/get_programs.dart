import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';
import 'package:hydrawise/features/programs/programs.dart';

abstract class GetPrograms {
  Future<List<Program>> call();
}

class GetProgramsFromRepository implements GetPrograms {
  final CustomerDetailsRepository _repository;

  GetProgramsFromRepository({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  @override
  Future<List<Program>> call() {
    return _repository.getPrograms();
  }
}