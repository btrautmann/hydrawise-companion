import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';
import 'package:hydrawise/features/programs/programs.dart';

abstract class CreateProgram {
  Future<void> call({required Program program});
}

class AddProgramToRepository implements CreateProgram {
  final CustomerDetailsRepository _repository;

  AddProgramToRepository({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  @override
  Future<void> call({required Program program}) {
    return _repository.insertProgram(program);
  }
}
