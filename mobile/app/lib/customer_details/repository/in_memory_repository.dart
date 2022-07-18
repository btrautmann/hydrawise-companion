import 'package:api_models/api_models.dart';
import 'package:irri/customer_details/customer_details.dart';

class InMemoryCustomerDetailsRepository implements CustomerDetailsRepository {
  Customer? _customer;
  final _zones = <Zone>[];
  final _programs = <Program>[];
  final _fcmTokens = <String>[];
  String? _timeZone;

  @override
  Future<void> addFcmToken(String token) async {
    _fcmTokens.add(token);
  }

  @override
  Future<void> removeFcmToken(String token) async {
    _fcmTokens.remove(token);
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
    return updateZone(zone);
  }

  @override
  Future<void> updateZone(Zone zone) async {
    _zones
      ..retainWhere((element) => element.id != zone.id)
      ..add(zone);
  }

  @override
  Future<void> insertProgram(Program program) async {
    return updateProgram(program);
  }

  @override
  Future<void> updateProgram(Program program) async {
    _programs
      ..retainWhere((element) => element.id != program.id)
      ..add(program);
  }

  @override
  Future<void> deleteProgram({required int programId}) async {
    _programs.removeWhere((element) => element.id == programId);
  }

  @override
  Future<List<Program>> getPrograms() async {
    return _programs;
  }

  @override
  Future<Program> getProgram({required int programId}) async {
    return _programs.singleWhere((element) => element.id == programId);
  }

  @override
  Future<List<Run>> getRunsForProgram({required int programId}) async {
    return _programs.singleWhere((element) => element.id == programId).runs;
  }

  @override
  Future<void> clearAllData() async {
    _zones.clear();
    _customer = null;
    _programs.clear();
    _fcmTokens.clear();
  }
}
