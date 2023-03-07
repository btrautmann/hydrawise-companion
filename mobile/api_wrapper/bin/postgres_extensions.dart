import 'package:postgres/postgres.dart';

extension PostgreSQLConnectionX on PostgreSQLConnection {
  Future<T> use<T>(Future<T> Function(PostgreSQLConnection connection) block) async {
    await open();
    final result = await block(this);
    await close();
    return result;
  }
}
