import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

abstract class CustomerDetailsRepository {
  // Customer
  Future<void> insertCustomer(CustomerIdentification customer);
  Future<void> updateCustomer(CustomerStatus customerStatus);
  Future<List<CustomerIdentification>> getCustomers();
  Future<CustomerIdentification> getCustomer();

  // Zone
  Future<void> insertZone(Zone zone);
  Future<void> updateZone(Zone zone);
  // TODO(brandon): Do we need to support get by id?
  Future<List<Zone>> getZones();

  // Program
  Future<Program> createProgram(
    String name,
    Frequency frequency,
    List<Run> runs,
  );
  Future<void> updateProgram(Program program);
  Future<List<Program>> getPrograms();

  // Utility
  Future<void> clearAllData();
}

class DatabaseBackedCustomerDetailsRepository implements CustomerDetailsRepository {
  DatabaseBackedCustomerDetailsRepository(this._database);

  final Database _database;

  @override
  Future<void> insertCustomer(CustomerIdentification customer) {
    return _database.insert(
      'customers',
      customer.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateCustomer(CustomerStatus customerStatus) async {
    final batch = _database.batch();

    customerStatus.zones.map((z) => z.toJson()).forEach((zone) {
      batch.insert(
        'zones',
        zone,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    final customers = await _database.query('customers');
    final customer = CustomerIdentification.fromJson(customers.first);

    batch.update(
      'customers',
      customer
          .copyWith(
            lastStatusUpdate: customerStatus.timeOfLastStatusUnixEpoch,
          )
          .toJson(),
      where: 'customer_id = ?',
      whereArgs: [customer.customerId],
    );

    await batch.commit();
  }

  @override
  Future<void> updateZone(Zone zone) {
    return _database.update(
      'zones',
      zone.toJson(),
      where: 'relay_id = ?',
      whereArgs: [zone.id],
    );
  }

  @override
  Future<List<CustomerIdentification>> getCustomers() async {
    final customers = await _database.query('customers');
    return customers.map((e) => CustomerIdentification.fromJson(e)).toList();
  }

  @override
  Future<CustomerIdentification> getCustomer() async {
    final customers = await _database.query('customers');
    return CustomerIdentification.fromJson(customers.first);
  }

  @override
  Future<List<Zone>> getZones() async {
    final zones = await _database.query('zones');
    return zones.map((e) => Zone.fromJson(e)).toList();
  }

  @override
  Future<void> insertZone(Zone zone) {
    return _database.insert('zones', zone.toJson());
  }

  @override
  Future<Program> createProgram(
    String name,
    Frequency frequency,
    List<Run> runs,
  ) async {
    final programId = const Uuid().v4().toString();
    final program = Program(
      id: programId,
      name: name,
      frequency: frequency,
      runs: runs,
    );
    await _database.insert('programs', ProgramX.toJson(program));
    return program;
  }

  @override
  Future<void> updateProgram(Program program) {
    // TODO: implement updateProgram
    throw UnimplementedError();
  }

  @override
  Future<List<Program>> getPrograms() async {
    final programsRaw = await _database.query('programs');
    final programs = <Program>[];
    for (int i = 0; i < programsRaw.length; i++) {
      final program = ProgramX.fromJson(programsRaw[i]);
      final runs = await _database.query(
        'runs',
        where: 'p_id = ?',
        whereArgs: [program.id],
      );
      programs.add(
        program.copyWith(
          runs: runs.map((e) => Run.fromJson(e)).toList(),
        ),
      );
    }
    return programs;
  }

  @override
  Future<void> clearAllData() async {
    await _database.delete('zones');
    await _database.delete('customers');
  }
}

class InMemoryCustomerDetailsRepository implements CustomerDetailsRepository {
  final customers = <CustomerIdentification>[];
  final zones = <Zone>[];

  @override
  Future<CustomerIdentification> getCustomer() async {
    return customers.first;
  }

  @override
  Future<List<CustomerIdentification>> getCustomers() async {
    return customers;
  }

  @override
  Future<List<Zone>> getZones() async {
    return zones;
  }

  @override
  Future<void> insertCustomer(CustomerIdentification customer) async {
    customers.add(customer);
  }

  @override
  Future<void> insertZone(Zone zone) async {
    zones.add(zone);
  }

  @override
  Future<void> updateCustomer(CustomerStatus customerStatus) async {
    zones
      ..clear()
      ..addAll(customerStatus.zones);
    final customer = await getCustomer();
    customers
      ..clear()
      ..add(
        customer.copyWith(
          lastStatusUpdate: customerStatus.timeOfLastStatusUnixEpoch,
        ),
      );
  }

  @override
  Future<void> updateZone(Zone zone) async {
    zones
      ..retainWhere((element) => element.id != zone.id)
      ..add(zone);
  }

  @override
  Future<Program> createProgram(
    String name,
    Frequency frequency,
    List<Run> runs,
  ) {
    // TODO: implement createProgram
    throw UnimplementedError();
  }

  @override
  Future<void> updateProgram(Program program) {
    // TODO: implement updateProgram
    throw UnimplementedError();
  }

  @override
  Future<List<Program>> getPrograms() {
    // TODO: implement getPrograms
    throw UnimplementedError();
  }

  @override
  Future<void> clearAllData() async {
    zones.clear();
    customers.clear();
  }
}
