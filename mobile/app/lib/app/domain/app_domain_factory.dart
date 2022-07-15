import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:irri/app_theme_mode/app_theme_mode.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/configuration/domain/domain.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/developer/developer.dart';
import 'package:irri/programs/programs.dart';
import 'package:irri/push_notifications/push_notifications.dart';
import 'package:irri/run_zone/run_zone.dart';
import 'package:provider/provider.dart';
import 'package:weatherx/weather.dart';

// ignore: avoid_classes_with_only_static_members
abstract class ProductionDependencyFactory {
  static List<Provider> build({
    required HttpClient client,
    required DataStorage dataStorage,
    required CustomerDetailsRepository repository,
    required FirebaseMessaging firebaseMessaging,
    // ignore: prefer_void_to_null
    required StreamController<Null> authFailures,
    required bool inDeveloperMode,
  }) {
    final getApiKey = GetApiKey(dataStorage);
    final setApiKey = SetApiKey(dataStorage);
    final isLoggedIn = IsLoggedIn(
      getApiKey: getApiKey,
    );
    final logIn = LogIn(
      setApiKey: setApiKey,
      httpClient: client,
    );
    final logOut = LogOut(
      setApiKey: setApiKey,
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
    final getPrograms = GetPrograms(
      httpClient: client,
      repository: repository,
      getApiKey: getApiKey,
    );
    final createProgram = CreateProgram(
      httpClient: client,
      repository: repository,
      getApiKey: getApiKey,
    );
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
      Provider<GetNextPollTime>.value(value: getNextPollTime),
      Provider<SetNextPollTime>.value(value: setNextPollTime),
      Provider<GetPrograms>.value(value: getPrograms),
      Provider<CreateProgram>.value(value: createProgram),
      Provider<UpdateProgram>.value(value: updateProgram),
      Provider<DeleteProgram>.value(value: deleteProgram),
      Provider<GetApiKey>.value(value: getApiKey),
      Provider<SetApiKey>.value(value: setApiKey),
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
      Provider<GetAvailableTimezones>.value(value: GetAvailableTimezones()),
      Provider<GetLocalTimezone>.value(value: GetLocalTimezone()),
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
