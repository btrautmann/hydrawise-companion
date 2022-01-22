import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/programs/programs.dart';

abstract class CustomerDetailsRepository {
  Future<void> insertCustomer(Customer customer);
  Future<void> updateCustomer(CustomerStatus customerStatus);
  Future<void> updateCustomerTimeZone(String timeZone);
  Future<Customer?> getCustomer();
  Future<void> addFcmToken(String token);
  Future<List<String>> getRegisteredFcmTokens();
  Future<void> updateTimeZone(String timeZone);
  Future<String?> getUserTimeZone();
  Future<void> insertZone(Zone zone);
  Future<void> updateZone(Zone zone);
  Future<List<Zone>> getZones();
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
  Future<void> clearAllData();
}
