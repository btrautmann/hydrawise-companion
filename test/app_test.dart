import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/domain/build_router.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/hydrawise_companion_app.dart';
import 'package:hydrawise/features/app_theme_mode/app_theme_mode.dart';
import 'package:hydrawise/features/app_theme_mode/domain/set_app_theme_mode.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';
import 'package:hydrawise/features/login/login.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:hydrawise/features/splash_page.dart';
import 'package:hydrawise/features/weather/weather.dart';

void main() {
  group('App', () {
    testWidgets('renders SplashPage', (tester) async {
      final repository = InMemoryCustomerDetailsRepository();

      final getCustomerDetails = GetFakeCustomerDetails(repository: repository);
      final getCustomerStatus = GetFakeCustomerStatus(repository: repository);
      final dataStorage = InMemoryStorage();
      final getApiKey = GetApiKeyFromStorage(dataStorage);
      final setApiKey = SetApiKeyInStorage(dataStorage);
      final clearCustomerDetails = ClearCustomerDetailsFromStorage(
        dataStorage: dataStorage,
        customerDetailsRepository: repository,
      );
      final runZone = RunZoneLocally(repository: repository);
      final stopZone = StopZoneLocally(repository: repository);
      final getWeather = GetWeatherFromNetwork();
      final getLocation = GetLocationFromStorage(dataStorage);
      final setLocation = SetLocationInStorage(dataStorage);
      final setAppThemeMode = SetAppThemeModeInStorage(dataStorage);
      final getAppThemeMode = GetAppThemeModeFromStorage(dataStorage);

      final router = await BuildStandardRouter().call();

      await tester.pumpWidget(App(
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
      expect(find.byType(SplashPage), findsOneWidget);
    });
  });
}
