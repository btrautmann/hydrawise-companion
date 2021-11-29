import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hydrawise/features/auth/auth.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

abstract class CustomerDetailsRepository {
  // Customer
  Future<void> insertCustomer(Customer customer);
  Future<void> updateCustomer(CustomerStatus customerStatus);
  Future<List<Customer>> getCustomers();
  Future<Customer> getCustomer();
  Future<void> addFcmToken(String token);
  Future<List<String>> getRegisteredFcmTokens();

  // Zone
  Future<void> insertZone(Zone zone);
  Future<void> updateZone(Zone zone);
  // TODO(brandon): Do we need to support get by id?
  Future<List<Zone>> getZones();
  // Program
  Future<String> createProgram({
    required String name,
    required List<int> frequency,
  });
  Future<Program> getProgram({
    required String programId,
  });
  Future<List<Program>> getPrograms();
  Future<void> updateProgram({
    required String programId,
    required String name,
    required List<int> frequency,
  });
  Future<void> deleteProgram({
    required String programId,
  });
  Future<void> insertRuns({
    required String programId,
    required List<Run> runs,
  });
  Future<void> updateRuns({
    required String programId,
    required List<Run> runs,
  });
  Future<List<Run>> getRunsForProgram({
    required String programId,
  });
  Future<void> deleteRun({
    required String runId,
    required String programId,
  });

  // Utility
  Future<void> clearAllData();
}

class FirebaseBackedCustomerDetailsRepository
    implements CustomerDetailsRepository {
  FirebaseBackedCustomerDetailsRepository({
    required FirebaseFirestore firestore,
    required GetFirebaseUid getFirebaseUid,
  })  : _firestore = firestore,
        _getFirebaseUid = getFirebaseUid;

  final FirebaseFirestore _firestore;
  final GetFirebaseUid _getFirebaseUid;

  Future<DocumentReference> _getUserDocument() async {
    final uId = await _getFirebaseUid();
    assert(
      uId != null && uId.isNotEmpty,
      'Firebase uId was $uId when using $runtimeType',
    );
    return _firestore.collection('users').doc(uId);
  }

  @override
  Future<void> clearAllData() async {
    final uId = await _getFirebaseUid();
    if (uId == null) {
      log('clearAllData invoked when uId was null');
    }
    log('Need to clearAllData for uId $uId');
  }

  @override
  Future<void> addFcmToken(String token) async {
    return _getUserDocument().then(
      (value) => value.update({
        'fcm_tokens': FieldValue.arrayUnion([token])
      }),
    );
  }

  @override
  Future<List<String>> getRegisteredFcmTokens() {
    return _getUserDocument().then(
      (d) => d.get().then((user) {
        // ignore: cast_nullable_to_non_nullable
        final data = user.data() as Map<String, dynamic>;
        return List<String>.from(data['fcm_tokens']);
      }),
    );
  }

  @override
  Future<String> createProgram({
    required String name,
    required List<int> frequency,
  }) async {
    final program = Program(
      id: const Uuid().v4(),
      name: name,
      frequency: frequency,
      // Runs aren't serialized, so pass empty list
      // TODO(brandon): This isn't great, possibly
      // introduce ProgramDraft
      runs: [],
    );
    await _getUserDocument().then(
      (d) => d.collection('programs').doc(program.id).set(program.toJson()),
    );
    return program.id;
  }

  @override
  Future<void> deleteProgram({required String programId}) {
    return _getUserDocument().then(
      (d) => d.collection('programs').doc(programId).delete(),
    );
  }

  @override
  Future<void> deleteRun({
    required String runId,
    required String programId,
  }) {
    return _getUserDocument().then(
      (d) => d
          .collection('programs')
          .doc(programId)
          .collection('runs')
          .doc(runId)
          .delete(),
    );
  }

  @override
  Future<Customer> getCustomer() {
    return _getUserDocument().then(
      (d) => d.get().then(
        (s) {
          // ignore: cast_nullable_to_non_nullable
          final json = s.data() as Map<String, dynamic>;
          return Customer.fromJson(json);
        },
      ),
    );
  }

  @override
  Future<List<Customer>> getCustomers() async {
    final customer = await getCustomer();
    return [customer];
  }

  @override
  Future<Program> getProgram({required String programId}) {
    return _getUserDocument().then(
      (d) => d.collection('programs').doc(programId).get().then(
        (s) {
          // ignore: cast_nullable_to_non_nullable
          final json = s.data() as Map<String, dynamic>;
          return Program.fromJson(json);
        },
      ),
    );
  }

  @override
  Future<List<Program>> getPrograms() async {
    final programs = await _getUserDocument().then(
      (d) => d.collection('programs').get().then(
        (s) {
          return s.docs.map((e) => Program.fromJson(e.data())).toList();
        },
      ),
    );
    final programsWithRuns = <Program>[];
    for (final program in programs) {
      await _getUserDocument().then(
        (d) => d
            .collection('programs')
            .doc(program.id)
            .collection('runs')
            .get()
            .then(
              (s) => programsWithRuns.add(
                program.copyWith(
                  runs: s.docs.map((e) => Run.fromJson(e.data())).toList(),
                ),
              ),
            ),
      );
    }
    return programsWithRuns;
  }

  @override
  Future<List<Run>> getRunsForProgram({required String programId}) {
    return _getUserDocument().then(
      (d) =>
          d.collection('programs').doc(programId).collection('runs').get().then(
        (s) {
          return s.docs.map((e) => Run.fromJson(e.data())).toList();
        },
      ),
    );
  }

  @override
  Future<List<Zone>> getZones() {
    return _getUserDocument().then(
      (d) => d.collection('zones').get().then(
        (s) {
          return s.docs.map((e) => Zone.fromJson(e.data())).toList();
        },
      ),
    );
  }

  @override
  Future<void> insertCustomer(Customer customer) {
    return _getUserDocument().then(
      (d) => d.set(
        customer.toJson(),
        SetOptions(merge: true),
      ),
    );
  }

  @override
  Future<void> insertRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    final batch = _firestore.batch();
    for (final run in runs) {
      final doc = await _getUserDocument().then(
        (d) => d
            .collection('programs')
            .doc(programId)
            .collection('runs')
            .doc(run.id),
      );
      batch.set(doc, run.toJson());
    }
    return batch.commit();
  }

  @override
  Future<void> insertZone(Zone zone) {
    return _getUserDocument().then(
      (d) => d.collection('zones').doc(zone.id.toString()).set(zone.toJson()),
    );
  }

  @override
  Future<void> updateCustomer(CustomerStatus customerStatus) async {
    for (final zone in customerStatus.zones) {
      await _getUserDocument().then(
        (d) => d
            .collection('zones')
            .doc(zone.id.toString())
            // Use `set` instead of `update` because this gets called
            // when first fetching a customer status and inserting zones
            .set(zone.toJson(), SetOptions(merge: true)),
      );
    }
    final customer = await getCustomer();
    return _getUserDocument().then(
      (d) => d.update(
        customer
            .copyWith(
              lastStatusUpdate: customerStatus.timeOfLastStatusUnixEpoch,
            )
            .toJson(),
      ),
    );
  }

  @override
  Future<void> updateProgram({
    required String programId,
    required String name,
    required List<int> frequency,
  }) {
    return _getUserDocument().then(
      (d) => d.collection('programs').doc(programId).set(
            Program(
              id: programId,
              name: name,
              frequency: frequency,
              // Runs aren't serialized, so pass empty list
              // TODO(brandon): This isn't great, possibly
              // introduce ProgramDraft
              runs: [],
            ).toJson(),
          ),
    );
  }

  @override
  Future<void> updateRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    final batch = _firestore.batch();
    for (final run in runs) {
      await _getUserDocument().then(
        (d) => d
            .collection('programs')
            .doc(programId)
            .collection('runs')
            .doc(run.id)
            .update(
              run.toJson(),
            ),
      );
      return batch.commit();
    }
  }

  @override
  Future<void> updateZone(Zone zone) {
    return _getUserDocument().then(
      (d) => d.collection('zones').doc(zone.id.toString()).update(
            zone.toJson(),
          ),
    );
  }
}

class DatabaseBackedCustomerDetailsRepository
    implements CustomerDetailsRepository {
  DatabaseBackedCustomerDetailsRepository(this._database);

  final Database _database;

  @override
  Future<void> addFcmToken(String token) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getRegisteredFcmTokens() {
    throw UnimplementedError();
  }

  @override
  Future<void> insertCustomer(Customer customer) {
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
    final customer = Customer.fromJson(customers.first);

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
  Future<List<Customer>> getCustomers() async {
    final customers = await _database.query('customers');
    return customers.map((e) => Customer.fromJson(e)).toList();
  }

  @override
  Future<Customer> getCustomer() async {
    final customers = await _database.query('customers');
    return Customer.fromJson(customers.first);
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
  Future<String> createProgram({
    required String name,
    required List<int> frequency,
  }) async {
    final program = Program(
      id: const Uuid().v4(),
      name: name,
      frequency: frequency,
      // Runs aren't serialized, so pass empty list
      // TODO(brandon): This isn't great, possibly
      // introduce ProgramDraft
      runs: [],
    );
    await _database.insert(
      'programs',
      program.toJson(),
    );
    return program.id;
  }

  @override
  Future<void> updateProgram({
    required String programId,
    required String name,
    required List<int> frequency,
  }) {
    return _database.update(
      'programs',
      Program(
        id: programId,
        name: name,
        frequency: frequency,
        // Runs aren't serialized, so pass empty list
        // TODO(brandon): This isn't great, possibly
        // introduce ProgramDraft
        runs: [],
      ).toJson(),
      where: 'id = ?',
      whereArgs: [programId],
    );
  }

  @override
  Future<void> deleteProgram({required String programId}) {
    return _database.delete(
      'programs',
      where: 'id = ?',
      whereArgs: [programId],
    );
  }

  @override
  Future<Program> getProgram({required String programId}) {
    return _database.query(
      'programs',
      where: 'id = ?',
      whereArgs: [programId],
    ).then((value) => value.map((p) => Program.fromJson(p)).single);
  }

  @override
  Future<List<Program>> getPrograms() async {
    final programsRaw = await _database.query('programs');
    final programs = <Program>[];
    for (var i = 0; i < programsRaw.length; i++) {
      final program = Program.fromJson(programsRaw[i]);
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
  Future<void> insertRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    final batch = _database.batch();
    for (final run in runs) {
      batch.insert('runs', run.toJson());
    }
    await batch.commit();
  }

  @override
  Future<void> updateRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    final batch = _database.batch();
    for (final run in runs) {
      batch.update(
        'runs',
        run.toJson(),
        where: 'id = ?',
        whereArgs: [run.id],
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Run>> getRunsForProgram({required String programId}) {
    return _database.query(
      'runs',
      where: 'p_id = ?',
      whereArgs: [programId],
    ).then((value) => value.map((e) => Run.fromJson(e)).toList());
  }

  @override
  Future<void> deleteRun({
    required String runId,
    required String programId,
  }) {
    return _database.delete('runs', where: 'id = ?', whereArgs: [runId]);
  }

  @override
  Future<void> clearAllData() async {
    await _database.delete('zones');
    await _database.delete('customers');
    await _database.delete('programs');
    await _database.delete('runs');
  }
}

class InMemoryCustomerDetailsRepository implements CustomerDetailsRepository {
  final customers = <Customer>[];
  final zones = <Zone>[];
  final programs = <Program>[];
  final runs = <Run>[];
  final fcmTokens = <String>[];

  @override
  Future<void> addFcmToken(String token) async {
    fcmTokens.add(token);
  }

  @override
  Future<List<String>> getRegisteredFcmTokens() async {
    return fcmTokens;
  }

  @override
  Future<Customer> getCustomer() async {
    return customers.first;
  }

  @override
  Future<List<Customer>> getCustomers() async {
    return customers;
  }

  @override
  Future<List<Zone>> getZones() async {
    return zones;
  }

  @override
  Future<void> insertCustomer(Customer customer) async {
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
  Future<String> createProgram({
    required String name,
    required List<int> frequency,
  }) async {
    final program = Program(
      id: const Uuid().v4(),
      name: name,
      frequency: frequency,
      runs: [],
    );
    programs.add(program);
    return program.id;
  }

  @override
  Future<void> deleteProgram({required String programId}) async {
    programs.removeWhere((element) => element.id == programId);
  }

  @override
  Future<void> updateProgram({
    required String programId,
    required String name,
    required List<int> frequency,
  }) async {
    final index = programs.indexWhere((element) => element.id == programId);
    programs[index] = programs[index].copyWith(
      name: name,
      frequency: frequency,
    );
  }

  @override
  Future<List<Program>> getPrograms() async {
    return programs;
  }

  @override
  Future<Program> getProgram({required String programId}) async {
    return programs.singleWhere((element) => element.id == programId);
  }

  @override
  Future<void> insertRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    this.runs.addAll(runs);
  }

  @override
  Future<void> updateRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    for (final run in runs) {
      final index = runs.indexWhere((element) => run.id == element.id);
      this.runs[index] = run;
    }
  }

  @override
  Future<List<Run>> getRunsForProgram({required String programId}) async {
    return runs.where((element) => element.programId == programId).toList();
  }

  @override
  Future<void> deleteRun({
    required String runId,
    required String programId,
  }) async {
    runs.removeWhere((element) => element.id == runId);
  }

  @override
  Future<void> clearAllData() async {
    zones.clear();
    customers.clear();
    programs.clear();
    runs.clear();
  }
}
