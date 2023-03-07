import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';

class GetNextRunForRunGroup {
  GetNextRunForRunGroup(this.db);

  final PostgreSQLConnection Function() db;

  DateTime call({
    required RunGroup group,
    required Program program,
  }) {
    // TODO(brandon): Return correct `DateTime` object
    return DateTime.now().add(const Duration(seconds: 10));
  }
}
