import 'package:api_models/api_models.dart';

abstract class CustomerDetailsRepository {
  // Customer
  Future<void> insertCustomer(Customer customer);
  Future<Customer?> getCustomer();
  Future<void> updateCustomerTimeZone(String timeZone);

  // FCM Tokens
  Future<void> addFcmToken(String token);
  Future<void> removeFcmToken(String token);
  Future<List<String>> getRegisteredFcmTokens();

  // Timezone
  Future<void> updateTimeZone(String timeZone);
  Future<String?> getUserTimeZone();

  // Zones
  Future<void> insertZone(Zone zone);
  Future<void> updateZone(Zone zone);
  Future<List<Zone>> getZones();

  // Programs
  Future<void> insertProgram(Program program);
  Future<void> updateProgram(Program program);
  Future<Program> getProgram({required int programId});
  Future<List<Program>> getPrograms();
  Future<void> deleteProgram({required int programId});
  Future<List<Run>> getRunsForProgram({required int programId});

  // Misc.
  Future<void> clearAllData();
}
