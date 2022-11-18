import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/domain/build_router.dart';
import 'package:irri/app/irri_app.dart';
import 'package:irri/app/provider_logging.dart';
import 'package:irri/app/providers.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final sharedPreferences = (await SharedPreferences.getInstance()).rx;

      runApp(
        ProviderScope(
          observers: [
            ProviderLogger(),
          ],
          overrides: [
            sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          ],
          child: IrriApp(
            router: BuildAppRouter().call(),
          ),
        ),
      );
    },
    (error, stackTrace) => log(error.toString()),
  );
}
