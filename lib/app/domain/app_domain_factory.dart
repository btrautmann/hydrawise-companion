import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/app_theme_mode/app_theme_mode.dart';
import 'package:hydrawise/features/auth/domain/domain.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:hydrawise/features/weather/weather.dart';
import 'package:provider/provider.dart';

// ignore: avoid_classes_with_only_static_members
abstract class ProductionDomainFactory {
  static List<Provider> build({
    required HttpClient client,
    required DataStorage dataStorage,
    required CustomerDetailsRepository repository,
    // ignore: prefer_void_to_null
    required StreamController<Null> authFailures,
  }) {
    final getApiKey = GetApiKey(dataStorage);
    final setApiKey = SetApiKey(dataStorage);
    final getFirebaseUid = GetFirebaseUid(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    final clearCustomerDetails = ClearCustomerDetails(
      setApiKey: setApiKey,
      setFirebaseUid: setFirebaseUid,
      customerDetailsRepository: repository,
    );
    final authenticateWithFirebase = AuthenticateWithFirebase(
      FirebaseFirestore.instance,
      FirebaseAuth.instance,
    );
    final getWeather = GetWeather();
    final getLocation = GetLocation(dataStorage);
    final setLocation = SetLocation(dataStorage);
    final getNextPollTime = GetNextPollTimeFromStorage(dataStorage);
    final setNextPollTime = SetNextPollTimeInStorage(dataStorage);

    final getCustomerDetails = GetCustomerDetailsFromHydrawise(
      httpClient: client,
      repository: repository,
      getApiKey: getApiKey,
    );
    final getCustomerStatus = GetCustomerStatusFromHydrawise(
      httpClient: client,
      repository: repository,
      getApiKey: getApiKey,
      getNextPollTime: getNextPollTime,
      setNextPollTime: setNextPollTime,
    );
    final getPrograms = GetPrograms(repository: repository);
    final createProgram = CreateProgram(repository: repository);
    final updateProgram = UpdateProgram(repository: repository);
    final deleteProgram = DeleteProgram(repository: repository);

    final runZone = RunZoneOverNetwork(
      httpClient: client,
      getApiKey: getApiKey,
      setNextPollTime: setNextPollTime,
      repository: repository,
    );

    final stopZone = StopZoneOverNetwork(
      httpClient: client,
      getApiKey: getApiKey,
    );

    final setAppThemeMode = SetAppThemeMode(dataStorage);
    final getAppThemeMode = GetAppThemeMode(dataStorage);
    final getAuthFailures = GetAuthFailures(
      authFailuresController: authFailures,
    );

    return [
      Provider<GetCustomerDetails>.value(value: getCustomerDetails),
      Provider<GetCustomerStatus>.value(value: getCustomerStatus),
      Provider<GetPrograms>.value(value: getPrograms),
      Provider<CreateProgram>.value(value: createProgram),
      Provider<UpdateProgram>.value(value: updateProgram),
      Provider<DeleteProgram>.value(value: deleteProgram),
      Provider<GetApiKey>.value(value: getApiKey),
      Provider<SetApiKey>.value(value: setApiKey),
      Provider<GetFirebaseUid>.value(value: getFirebaseUid),
      Provider<SetFirebaseUid>.value(value: setFirebaseUid),
      Provider<AuthenticateWithFirebase>.value(value: authenticateWithFirebase),
      Provider<ClearCustomerDetails>.value(value: clearCustomerDetails),
      Provider<RunZone>.value(value: runZone),
      Provider<StopZone>.value(value: stopZone),
      Provider<GetLocation>.value(value: getLocation),
      Provider<SetLocation>.value(value: setLocation),
      Provider<GetWeather>.value(value: getWeather),
      Provider<SetAppThemeMode>.value(value: setAppThemeMode),
      Provider<GetAppThemeMode>.value(value: getAppThemeMode),
      Provider<GetAuthFailures>.value(value: getAuthFailures),
    ];
  }
}

// ignore: avoid_classes_with_only_static_members
abstract class DevelopmentDomainFactory {
  static List<Provider> build({
    required DataStorage dataStorage,
    required CustomerDetailsRepository repository,
  }) {
    final getApiKey = GetApiKey(dataStorage);
    final setApiKey = SetApiKey(dataStorage);
    final getFirebaseUid = GetFirebaseUid(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    final clearCustomerDetails = ClearCustomerDetails(
      setApiKey: setApiKey,
      setFirebaseUid: setFirebaseUid,
      customerDetailsRepository: repository,
    );
    final authenticateWithFirebase = FakeAuthenticateWithFirebase();
    final getWeather = GetWeather();
    final getLocation = GetLocation(dataStorage);
    final setLocation = SetLocation(dataStorage);
    final runZone = RunZoneLocally(repository: repository);
    final stopZone = StopZoneLocally(repository: repository);
    final getCustomerDetails = GetFakeCustomerDetails(repository: repository);
    final getCustomerStatus = GetFakeCustomerStatus(repository: repository);
    final getPrograms = GetPrograms(repository: repository);
    final createProgram = CreateProgram(repository: repository);
    final updateProgram = UpdateProgram(repository: repository);
    final deleteProgram = DeleteProgram(repository: repository);
    final setAppThemeMode = SetAppThemeMode(dataStorage);
    final getAppThemeMode = GetAppThemeMode(dataStorage);
    final getAuthFailures = GetAuthFailures(
      // We need to inject this to fulfill our dependency
      // injection contract, but we just create the controller
      // here because we'll never fail auth while in development
      // mode
      authFailuresController: StreamController(),
    );

    return [
      Provider<GetCustomerDetails>.value(value: getCustomerDetails),
      Provider<GetCustomerStatus>.value(value: getCustomerStatus),
      Provider<GetPrograms>.value(value: getPrograms),
      Provider<CreateProgram>.value(value: createProgram),
      Provider<UpdateProgram>.value(value: updateProgram),
      Provider<DeleteProgram>.value(value: deleteProgram),
      Provider<GetApiKey>.value(value: getApiKey),
      Provider<SetApiKey>.value(value: setApiKey),
      Provider<GetFirebaseUid>.value(value: getFirebaseUid),
      Provider<SetFirebaseUid>.value(value: setFirebaseUid),
      Provider<AuthenticateWithFirebase>.value(value: authenticateWithFirebase),
      Provider<ClearCustomerDetails>.value(value: clearCustomerDetails),
      Provider<RunZone>.value(value: runZone),
      Provider<StopZone>.value(value: stopZone),
      Provider<GetLocation>.value(value: getLocation),
      Provider<SetLocation>.value(value: setLocation),
      Provider<GetWeather>.value(value: getWeather),
      Provider<SetAppThemeMode>.value(value: setAppThemeMode),
      Provider<GetAppThemeMode>.value(value: getAppThemeMode),
      Provider<GetAuthFailures>.value(value: getAuthFailures),
    ];
  }
}
