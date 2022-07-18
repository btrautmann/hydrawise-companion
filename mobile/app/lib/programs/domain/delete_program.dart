import 'package:irri/customer_details/repository/customer_details_repository.dart';

class DeleteProgram {
  DeleteProgram({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<void> call({required int programId}) {
    return _repository.deleteProgram(programId: programId);
  }
}
