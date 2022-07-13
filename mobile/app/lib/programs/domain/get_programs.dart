import 'package:api_models/api_models.dart';
import 'package:irri/customer_details/repository/customer_details_repository.dart';

class GetPrograms {
  GetPrograms({
    required CustomerDetailsRepository repository,
  }) : _repository = repository;

  final CustomerDetailsRepository _repository;

  Future<List<Program>> call() {
    return _repository.getPrograms();
  }
}
