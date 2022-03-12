import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/app_theme_mode/app_theme_mode.dart';
import 'package:irri/features/auth/domain/domain.dart';
import 'package:irri/features/configuration/domain/domain.dart';
import 'package:irri/features/customer_details/customer_details.dart';
import 'package:irri/features/developer/developer.dart';
import 'package:irri/features/programs/programs.dart';
import 'package:irri/features/push_notifications/push_notifications.dart';
import 'package:irri/features/run_zone/run_zone.dart';
import 'package:irri/features/weather/weather.dart';
import 'package:provider/provider.dart';

// ignore: avoid_classes_with_only_static_members
abstract class ProductionDomainFactory {
  static List<Provider> build({
    required HttpClient client,
    required DataStorage dataStorage,
    required CustomerDetailsRepository repository,
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required FirebaseMessaging firebaseMessaging,
    // ignore: prefer_void_to_null
    required StreamController<Null> authFailures,
    required bool inDeveloperMode,
  }) {
    final getApiKey = GetApiKey(dataStorage);
    final setApiKey = SetApiKey(dataStorage);
    final getFirebaseUid = GetFirebaseUid(dataStorage);
    final setFirebaseUid = SetFirebaseUid(dataStorage);
    final validateApiKey = ValidateApiKey(
      httpClient: client,
      setApiKey: setApiKey,
    );
    final authenticateWithFirebase = AuthenticateWithFirebase(
      firestore: firebaseFirestore,
      auth: firebaseAuth,
      setFirebaseUid: setFirebaseUid,
    );
    final isLoggedIn = IsLoggedIn(
      getApiKey: getApiKey,
      getFirebaseUid: getFirebaseUid,
    );
    final logIn = LogIn(
      validateApiKey: validateApiKey,
      authenticateWithFirebase: authenticateWithFirebase,
    );
    final logOut = LogOut(
      setApiKey: setApiKey,
      unauthenticateWithFirebase: FakeUnauthenticateWithFirebase(
        setFirebaseUid: setFirebaseUid,
      ),
      customerDetailsRepository: repository,
    );
    final getWeather = GetWeather();
    final getLocation = GetLocation(dataStorage);
    final setLocation = SetLocation(dataStorage);
    final getNextPollTime = GetNextPollTimeFromStorage(dataStorage);
    final setNextPollTime = SetNextPollTimeInStorage(dataStorage);

    final getCustomerDetails = GetCustomerDetails(
      httpClient: client,
      repository: repository,
      getApiKey: getApiKey,
    );
    final getCustomerStatus = GetCustomerStatus(
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

    final getPushNotificationsEnabled = GetPushNotificationsEnabled(
      firebaseMessaging: firebaseMessaging,
      repository: repository,
    );

    final registerForPushNotifications = RegisterForPushNotifications(
      firebaseMessaging: firebaseMessaging,
      repository: repository,
    );

    final unregisterForPushNotifications = UnregisterForPushNotifications(
      firebaseMessaging: firebaseMessaging,
      repository: repository,
    );

    final getUserTimezone = GetUserTimezone(repository: repository);
    final updateUserTimezone = UpdateUserTimeZone(repository: repository);

    final shouldShowDeveloperUi = ShouldShowDeveloperEntryPoint(
      inDeveloperMode,
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
      Provider<LogOut>.value(value: logOut),
      Provider<LogIn>.value(value: logIn),
      Provider<IsLoggedIn>.value(value: isLoggedIn),
      Provider<RunZone>.value(value: runZone),
      Provider<StopZone>.value(value: stopZone),
      Provider<GetLocation>.value(value: getLocation),
      Provider<SetLocation>.value(value: setLocation),
      Provider<GetWeather>.value(value: getWeather),
      Provider<SetAppThemeMode>.value(value: setAppThemeMode),
      Provider<GetAppThemeMode>.value(value: getAppThemeMode),
      Provider<GetAuthFailures>.value(value: getAuthFailures),
      Provider<GetPushNotificationsEnabled>.value(
        value: getPushNotificationsEnabled,
      ),
      Provider<RegisterForPushNotifications>.value(
        value: registerForPushNotifications,
      ),
      Provider<UnregisterForPushNotifications>.value(
        value: unregisterForPushNotifications,
      ),
      Provider<GetUserTimezone>.value(value: getUserTimezone),
      Provider<UpdateUserTimeZone>.value(value: updateUserTimezone),
      Provider<ShouldShowDeveloperEntryPoint>.value(
        value: shouldShowDeveloperUi,
      ),
      if (inDeveloperMode) ...[
        Provider<GetAllStorage>.value(
          value: GetAllStorage(dataStorage),
        ),
      ]
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
    final validateApiKey = FakeValidateApiKey(
      setApiKey: setApiKey,
    );
    final authenticateWithFirebase = FakeAuthenticateWithFirebase(
      setFirebaseUid: setFirebaseUid,
    );
    final isLoggedIn = IsLoggedIn(
      getApiKey: getApiKey,
      getFirebaseUid: getFirebaseUid,
    );
    final logIn = LogIn(
      validateApiKey: validateApiKey,
      authenticateWithFirebase: authenticateWithFirebase,
    );
    final logOut = LogOut(
      setApiKey: setApiKey,
      unauthenticateWithFirebase: FakeUnauthenticateWithFirebase(
        setFirebaseUid: setFirebaseUid,
      ),
      customerDetailsRepository: repository,
    );
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
    final getPushNotificationsEnabled = FakeGetPushNotificationsEnabled(
      repository: repository,
    );

    final registerForPushNotifications = FakeRegisterForPushNotifications(
      repository: repository,
    );
    final unregisterForPushNotifications = FakeUnregisterForPushNotifications(
      repository: repository,
    );

    final getUserTimezone = GetUserTimezone(repository: repository);
    final updateUserTimezone = UpdateUserTimeZone(repository: repository);

    final shouldShowDeveloperUi = ShouldShowDeveloperEntryPoint(true);

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
      Provider<LogOut>.value(value: logOut),
      Provider<LogIn>.value(value: logIn),
      Provider<IsLoggedIn>.value(value: isLoggedIn),
      Provider<RunZone>.value(value: runZone),
      Provider<StopZone>.value(value: stopZone),
      Provider<GetLocation>.value(value: getLocation),
      Provider<SetLocation>.value(value: setLocation),
      Provider<GetWeather>.value(value: getWeather),
      Provider<SetAppThemeMode>.value(value: setAppThemeMode),
      Provider<GetAppThemeMode>.value(value: getAppThemeMode),
      Provider<GetAuthFailures>.value(value: getAuthFailures),
      Provider<GetPushNotificationsEnabled>.value(
        value: getPushNotificationsEnabled,
      ),
      Provider<RegisterForPushNotifications>.value(
        value: registerForPushNotifications,
      ),
      Provider<UnregisterForPushNotifications>.value(
        value: unregisterForPushNotifications,
      ),
      Provider<GetUserTimezone>.value(value: getUserTimezone),
      Provider<UpdateUserTimeZone>.value(value: updateUserTimezone),
      Provider<ShouldShowDeveloperEntryPoint>.value(
        value: shouldShowDeveloperUi,
      ),
      Provider<GetAllStorage>.value(
        value: GetAllStorage(dataStorage),
      ),
    ];
  }
}
