import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrawise/app/app_bloc_observer.dart';
import 'package:hydrawise/app/domain/app_domain_factory.dart';
import 'package:hydrawise/app/domain/build_router.dart';
import 'package:hydrawise/app/hydrawise_companion_app.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);

      final dataStorage = InMemoryStorage();
      final repository = InMemoryCustomerDetailsRepository();
      final providers = DevelopmentDomainFactory.build(
        dataStorage: dataStorage,
        repository: repository,
      );

      final router = await BuildAppRouter().call();

      runApp(
        App(
          router: router,
          providers: providers,
        ),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
