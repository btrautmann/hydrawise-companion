import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/programs/programs.dart';
import 'package:uuid/uuid.dart';

class InMemoryCustomerDetailsRepository implements CustomerDetailsRepository {
  Customer? _customer;
  final _zones = <Zone>[];
  final _programs = <Program>[];
  final _runs = <Run>[];
  final _fcmTokens = <String>[];
  String? _timeZone;

  @override
  Future<void> addFcmToken(String token) async {
    _fcmTokens.add(token);
  }

  @override
  Future<List<String>> getRegisteredFcmTokens() async {
    return _fcmTokens;
  }

  @override
  Future<void> updateTimeZone(String timeZone) async {
    _timeZone = timeZone;
  }

  @override
  Future<String?> getUserTimeZone() async {
    return _timeZone;
  }

  @override
  Future<Customer?> getCustomer() async {
    return _customer;
  }

  @override
  Future<List<Zone>> getZones() async {
    return _zones;
  }

  @override
  Future<void> insertCustomer(Customer customer) async {
    _customer = customer;
  }

  @override
  Future<void> updateCustomerTimeZone(String timeZone) {
    throw UnimplementedError();
  }

  @override
  Future<void> insertZone(Zone zone) async {
    _zones.add(zone);
  }

  @override
  Future<void> updateCustomer(CustomerStatus customerStatus) async {
    _zones
      ..clear()
      ..addAll(customerStatus.zones);
    _customer = _customer!.copyWith(
      lastStatusUpdate: customerStatus.timeOfLastStatusUnixEpoch,
    );
  }

  @override
  Future<void> updateZone(Zone zone) async {
    _zones
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
    _programs.add(program);
    return program.id;
  }

  @override
  Future<void> deleteProgram({required String programId}) async {
    _programs.removeWhere((element) => element.id == programId);
  }

  @override
  Future<void> updateProgram({
    required String programId,
    required String name,
    required List<int> frequency,
  }) async {
    final index = _programs.indexWhere((element) => element.id == programId);
    _programs[index] = _programs[index].copyWith(
      name: name,
      frequency: frequency,
    );
  }

  @override
  Future<List<Program>> getPrograms() async {
    return _programs;
  }

  @override
  Future<Program> getProgram({required String programId}) async {
    return _programs.singleWhere((element) => element.id == programId);
  }

  @override
  Future<void> insertRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    _runs.addAll(runs);
  }

  @override
  Future<void> updateRuns({
    required String programId,
    required List<Run> runs,
  }) async {
    for (final run in runs) {
      final index = runs.indexWhere((element) => run.id == element.id);
      _runs[index] = run;
    }
  }

  @override
  Future<List<Run>> getRunsForProgram({required String programId}) async {
    return _runs.where((element) => element.programId == programId).toList();
  }

  @override
  Future<void> deleteRun({
    required String runId,
    required String programId,
  }) async {
    _runs.removeWhere((element) => element.id == runId);
  }

  @override
  Future<void> clearAllData() async {
    _zones.clear();
    _customer = null;
    _programs.clear();
    _runs.clear();
    _fcmTokens.clear();
  }
}
