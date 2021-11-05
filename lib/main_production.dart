import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrawise/app/domain/app_domain_factory.dart';
import 'package:hydrawise/app/networking/build_http_interceptors.dart';
import 'package:hydrawise/app/domain/build_router.dart';
import 'package:hydrawise/app/domain/create_database.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/hydrawise_companion_app.dart';
import 'package:hydrawise/app/app_bloc_observer.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
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
      // ignore: prefer_void_to_null
      final authFailures = StreamController<Null>();

      final router = await BuildStandardRouter().call();

      void onAuthenticationFailure() {
        authFailures.add(null);
      }

      final interceptors = await BuildProductionHttpInterceptors(
        onAuthenticationFailure: onAuthenticationFailure,
      ).call();

      final httpClient =
          HttpClient(dio: Dio(), baseUrl: 'http://api.hydrawise.com/api/v1/', interceptors: interceptors);

      final providers = ProductionDomainFactory.build(
        client: httpClient,
        dataStorage: dataStorage,
        repository: repository,
        authFailures: authFailures,
      );

      runApp(App(
        router: router,
        providers: providers,
      ));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
