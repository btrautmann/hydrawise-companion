import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrawise/app/networking/build_http_interceptors.dart';
import 'package:hydrawise/app/domain/build_router.dart';
import 'package:hydrawise/app/domain/create_database.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/app.dart';
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

      final sharedPreferences = await SharedPreferences.getInstance();
      final dataStorage = SharedPreferencesStorage(sharedPreferences);
      final database = await CreateHydrawiseDatabase().call(
        databaseName: 'hydrawise_companion_prod.db',
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
      final getNextPollTime = GetNextPollTimeFromStorage(dataStorage);
      final setNextPollTime = SetNextPollTimeInStorage(dataStorage);

      final router = await BuildStandardRouter().call();

      final httpClient = HttpClient(
        dio: Dio(),
        baseUrl: 'http://api.hydrawise.com/api/v1/',
      );

      final getCustomerDetails = GetCustomerDetailsFromNetwork(
        httpClient: httpClient,
        repository: repository,
        getApiKey: getApiKey,
      );
      final getCustomerStatus = GetCustomerStatusFromNetwork(
        httpClient: httpClient,
        repository: repository,
        getApiKey: getApiKey,
        getNextPollTime: getNextPollTime,
        setNextPollTime: setNextPollTime,
      );

      final runZone = RunZoneOverNetwork(
        httpClient: httpClient,
        getApiKey: getApiKey,
      );
      final stopZone = StopZoneOverNetwork(
        httpClient: httpClient,
        getApiKey: getApiKey,
      );

      final loginCubit = LoginCubit(
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        getCustomerDetails: getCustomerDetails,
        clearCustomerDetails: clearCustomerDetails,
      );

      final setAppThemeMode = SetAppThemeModeInStorage(dataStorage);
      final getAppThemeMode = GetAppThemeModeFromStorage(dataStorage);

      void onAuthenticationFailure() {
        loginCubit.logOut();
      }

      final interceptors = await BuildProductionHttpInterceptors(
        onAuthenticationFailure: onAuthenticationFailure,
      ).call();

      httpClient.addInterceptors(interceptors);

      runApp(App(
        router: router,
        loginCubit: loginCubit,
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
