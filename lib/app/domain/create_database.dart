import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Contract for creating the [Database] that the app
/// will use to store complex, relational data
abstract class CreateDatabase {
  Future<Database> call({
    required String databaseName,
    required int version,
  });
}

class CreateHydrawiseDatabase implements CreateDatabase {
  @override
  Future<Database> call({
    required String databaseName,
    required int version,
  }) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
    );
    await database.execute(
      '''
CREATE TABLE IF NOT EXISTS zones(relay_id INTEGER PRIMARY KEY, relay INTEGER, name TEXT, timestr TEXT, time INTEGER, run INTEGER)''',
    );
    await database.execute(
      '''
CREATE TABLE IF NOT EXISTS customers(customer_id INTEGER PRIMARY KEY, controller_id INTEGER, api_key TEXT, last_status_update INTEGER)''',
    );
    return database;
  }
}
