// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrawise/app/domain/create_database.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/app.dart';
import 'package:hydrawise/app/app_bloc_observer.dart';
import 'package:hydrawise/customer_details/customer_details.dart';
import 'package:hydrawise/weather/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final database = await CreateHydrawiseDatabase().call(
        databaseName: 'hydrawise_companion_dev.db',
        version: 2,
      );

      final sharedPreferences = await SharedPreferences.getInstance();
      final DataStorage dataStorage =
          SharedPreferencesStorage(sharedPreferences);
      final getCustomerDetails = GetFakeCustomerDetails(database: database);
      final getCustomerStatus = GetFakeCustomerStatus(database: database);
      final getApiKey = GetApiKeyFromStorage(dataStorage);
      final setApiKey = SetApiKeyInStorage(dataStorage);
      final clearCustomerDetails = ClearCustomerDetailsFromStorage(dataStorage);
      final runZone = RunZoneLocally(database: database);
      final getWeather = GetWeatherFromNetwork();
      final getLocation = GetLocationFromStorage(dataStorage);
      final setLocation = SetLocationInStorage(dataStorage);

      runApp(App(
        getCustomerDetails: getCustomerDetails,
        getCustomerStatus: getCustomerStatus,
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        clearCustomerDetails: clearCustomerDetails,
        runZone: runZone,
        getLocation: getLocation,
        setLocation: setLocation,
        getWeather: getWeather,
      ));
    },
    (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
    },
  );
}
