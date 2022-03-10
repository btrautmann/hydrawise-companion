import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:irri/app/app_bloc_observer.dart';
import 'package:irri/app/domain/app_domain_factory.dart';
import 'package:irri/app/domain/build_router.dart';
import 'package:irri/app/irri_app.dart';
import 'package:irri/core/core.dart';
import 'package:irri/features/customer_details/customer_details.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString());
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          // await Firebase.initializeApp();
          // await FirebaseCrashlytics.instance
          //     .setCrashlyticsCollectionEnabled(false);

          final dataStorage = InMemoryStorage();
          final repository = InMemoryCustomerDetailsRepository();
          final providers = DevelopmentDomainFactory.build(
            dataStorage: dataStorage,
            repository: repository,
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
