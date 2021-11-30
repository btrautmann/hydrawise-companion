import 'package:irri/features/customer_details/repository/customer_details_repository.dart';

class DeleteProgram {
  DeleteProgram({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<void> call({required String programId}) {
    return _repository.deleteProgram(programId: programId);
  }
}
