import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrawise/app/domain/build_router.dart';
import 'package:hydrawise/app/domain/create_database.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/hydrawise_companion_app.dart';
import 'package:hydrawise/app/app_bloc_observer.dart';
import 'package:hydrawise/features/app_theme_mode/app_theme_mode.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/login/login.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:hydrawise/features/weather/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);

      final sharedPreferences = await SharedPreferences.getInstance();
      final dataStorage = SharedPreferencesStorage(sharedPreferences);
      final database = await CreateHydrawiseDatabase().call(
        databaseName: 'hydrawise_companion_dev.db',
        version: 2,
      );

      final repository = DatabaseBackedCustomerDetailsRepository(database);
      final clearCustomerDetails = ClearCustomerDetailsFromStorage(
        dataStorage: dataStorage,
        customerDetailsRepository: repository,
      );
      final getApiKey = GetApiKeyFromStorage(dataStorage);
      final setApiKey = SetApiKeyInStorage(dataStorage);
      final getWeather = GetWeatherFromNetwork();
      final getLocation = GetLocationFromStorage(dataStorage);
      final setLocation = SetLocationInStorage(dataStorage);
      final runZone = RunZoneLocally(repository: repository);
      final stopZone = StopZoneLocally(repository: repository);
      final getCustomerDetails = GetFakeCustomerDetails(repository: repository);
      final getCustomerStatus = GetFakeCustomerStatus(repository: repository);
      final setAppThemeMode = SetAppThemeModeInStorage(dataStorage);
      final getAppThemeMode = GetAppThemeModeFromStorage(dataStorage);

      final router = await BuildStandardRouter().call();

      runApp(App(
        router: router,
        loginCubit: LoginCubit(
          getApiKey: getApiKey,
          setApiKey: setApiKey,
          getCustomerDetails: getCustomerDetails,
          clearCustomerDetails: clearCustomerDetails,
        ),
        setAppThemeMode: setAppThemeMode,
        getAppThemeMode: getAppThemeMode,
        getCustomerDetails: getCustomerDetails,
        getCustomerStatus: getCustomerStatus,
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        clearCustomerDetails: clearCustomerDetails,
        runZone: runZone,
        stopZone: stopZone,
        getLocation: getLocation,
        setLocation: setLocation,
        getWeather: getWeather,
      ));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
