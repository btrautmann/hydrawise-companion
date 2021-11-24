import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateDatabase {
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
CREATE TABLE IF NOT EXISTS zones(
  relay_id INTEGER PRIMARY KEY,
  relay INTEGER,
  name TEXT,
  timestr TEXT,
  time INTEGER,
  run INTEGER
  )''',
    );
    await database.execute(
      '''
CREATE TABLE IF NOT EXISTS customers(
  customer_id INTEGER PRIMARY KEY,
  controller_id INTEGER,
  api_key TEXT,
  last_status_update INTEGER
  )''',
    );
    await database.execute(
      '''
CREATE TABLE IF NOT EXISTS programs(
  id TEXT PRIMARY KEY,
  name TEXT,
  monday INTEGER,
  tuesday INTEGER,
  wednesday INTEGER,
  thursday INTEGER,
  friday INTEGER,
  saturday INTEGER,
  sunday INTEGER
  )''',
    );
    await database.execute(
      '''
CREATE TABLE IF NOT EXISTS runs(
  id TEXT PRIMARY KEY,
  p_id TEXT,
  start_time TEXT,
  duration INTEGER,
  z_id INTEGER,
  FOREIGN KEY(p_id) REFERENCES programs(id),
  FOREIGN KEY(z_id) REFERENCES zones(relay_id)
  )''',
    );
    return database;
  }
}
