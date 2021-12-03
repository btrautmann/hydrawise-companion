import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/programs/programs.dart';
import 'package:uuid/uuid.dart';

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
        return List<String>.from(data['fcm_tokens'] ?? List<String>.empty());
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
