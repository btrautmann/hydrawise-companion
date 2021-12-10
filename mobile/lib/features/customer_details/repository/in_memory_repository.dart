import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/programs/programs.dart';
import 'package:uuid/uuid.dart';

class InMemoryCustomerDetailsRepository implements CustomerDetailsRepository {
  final customers = <Customer>[];
  final zones = <Zone>[];
  final programs = <Program>[];
  final runs = <Run>[];
  final fcmTokens = <String>[];
  String? _timeZone;

  @override
  Future<void> addFcmToken(String token) async {
    fcmTokens.add(token);
  }

  @override
  Future<List<String>> getRegisteredFcmTokens() async {
    return fcmTokens;
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
  Future<Customer> getCustomer() async {
    return customers.first;
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
