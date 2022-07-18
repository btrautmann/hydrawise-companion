import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:irri/app/app_bloc_observer.dart';
import 'package:irri/app/domain/app_domain_factory.dart';
import 'package:irri/app/domain/build_router.dart';
import 'package:irri/app/irri_app.dart';
import 'package:irri/app/networking/networking.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
    FirebaseCrashlytics.instance.recordError(details.exception, details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          await Firebase.initializeApp();

          final dotEnv = DotEnv(includePlatformEnvironment: true);
          final isProduction = dotEnv['IS_PROD'] == 'true';
          late final String baseUrl;
          // TODO(brandon): Inject these during build
          if (isProduction) {
            baseUrl = 'https://apiwrapper-5rvb357uza-uc.a.run.app/';
          } else {
            baseUrl = 'http://10.0.2.2:8080/';
          }

          final firebaseMessaging = FirebaseMessaging.instance;

          final sharedPreferences = await SharedPreferences.getInstance();
          final dataStorage = SharedPreferencesStorage(sharedPreferences);
          final repository = InMemoryCustomerDetailsRepository();

          // ignore: prefer_void_to_null, close_sinks
          final authFailures = StreamController<Null>();
          void onAuthenticationFailure() {
            authFailures.add(null);
          }

          final interceptors = await BuildProductionHttpInterceptors(
            onAuthenticationFailure: onAuthenticationFailure,
          ).call();

          final httpClient = HttpClient(
            dio: Dio(),
            baseUrl: baseUrl,
            getAuthentication: GetApiKey(dataStorage),
            interceptors: interceptors,
          );

          final providers = ProductionDependencyFactory.build(
            client: httpClient,
            dataStorage: dataStorage,
            repository: repository,
            firebaseMessaging: firebaseMessaging,
            authFailures: authFailures,
            inDeveloperMode: kDebugMode,
          );

          final router = await BuildAppRouter().call();

          runApp(
            IrriApp(
              router: router,
              providers: providers,
            ),
          );
        },
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString()),
  );
}
