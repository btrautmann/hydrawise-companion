import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/app.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/customer_details/repository/customer_details_repository.dart';
import 'package:hydrawise/features/login/login.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:hydrawise/features/splash_page.dart';
import 'package:hydrawise/weather/weather.dart';

void main() {
  group('App', () {
    testWidgets('renders SplashPage', (tester) async {
      final repository = InMemoryCustomerDetailsRepository();

      final getCustomerDetails = GetFakeCustomerDetails(repository: repository);
      final getCustomerStatus = GetFakeCustomerStatus(repository: repository);
      final dataStorage = InMemoryStorage();
      final getApiKey = GetApiKeyFromStorage(dataStorage);
      final setApiKey = SetApiKeyInStorage(dataStorage);
      final clearCustomerDetails = ClearCustomerDetailsFromStorage(dataStorage);
      final runZone = RunZoneLocally(repository: repository);
      final stopZone = StopZoneLocally(repository: repository);
      final getWeather = GetWeatherFromNetwork();
      final getLocation = GetLocationFromStorage(dataStorage);
      final setLocation = SetLocationInStorage(dataStorage);

      await tester.pumpWidget(App(
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
