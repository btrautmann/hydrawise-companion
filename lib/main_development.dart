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
import 'package:hydrawise/customer_details/api/get_api_key.dart';
import 'package:hydrawise/customer_details/api/set_api_key.dart';

import 'package:hydrawise/app/app.dart';
import 'package:hydrawise/app/app_bloc_observer.dart';
import 'package:hydrawise/core/data_storage.dart';
import 'package:hydrawise/customer_details/domain/clear_customer_details.dart';
import 'package:hydrawise/customer_details/domain/get_customer_details.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final dataStorage = InMemoryStorage();
      final getCustomerDetails = GetFakeCustomerDetails();
      final getApiKey = GetApiKeyFromStorage(dataStorage);
      final setApiKey = SetApiKeyInStorage(dataStorage);
      final clearCustomerDetails = ClearCustomerDetailsFromStorage(dataStorage);

      runApp(App(
        getCustomerDetails: getCustomerDetails,
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        clearCustomerDetails: clearCustomerDetails,
      ));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
