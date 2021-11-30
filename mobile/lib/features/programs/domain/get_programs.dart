import 'package:irri/features/customer_details/repository/customer_details_repository.dart';
import 'package:irri/features/programs/programs.dart';

class GetPrograms {
  GetPrograms({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<List<Program>> call() {
    return _repository.getPrograms();
  }
}
