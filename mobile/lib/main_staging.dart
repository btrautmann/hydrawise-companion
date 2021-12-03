import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:irri/app/app.dart';
import 'package:irri/app/app_bloc_observer.dart';
import 'package:irri/app/domain/build_router.dart';
import 'package:irri/app/irri_app.dart';
import 'package:irri/app/networking/build_http_interceptors.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';
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

      final firebaseFirestore = FirebaseFirestore.instance;
      final firebaseAuth = FirebaseAuth.instance;
      final firebaseMessaging = FirebaseMessaging.instance;

      final sharedPreferences = await SharedPreferences.getInstance();
      final dataStorage = SharedPreferencesStorage(sharedPreferences);

      final repository = FirebaseBackedCustomerDetailsRepository(
        firestore: FirebaseFirestore.instance,
        // TODO(brandon): This is the only use case utilized outside
        // of the widget tree -- see how we can refactor this
        getFirebaseUid: GetFirebaseUid(dataStorage),
      );
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
        baseUrl: 'http://api.hydrawise.com/api/v1/',
        interceptors: interceptors,
      );

      final providers = ProductionDomainFactory.build(
        client: httpClient,
        dataStorage: dataStorage,
        repository: repository,
        firebaseFirestore: firebaseFirestore,
        firebaseAuth: firebaseAuth,
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
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
