import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';

class DeleteProgram {
  final CustomerDetailsRepository _repository;

  DeleteProgram({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  Future<void> call({required String programId}) {
    return _repository.deleteProgram(programId: programId);
  }
}
