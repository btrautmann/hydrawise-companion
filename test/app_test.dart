// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/domain/create_database.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/app.dart';
import 'package:hydrawise/customer_details/customer_details.dart';
import 'package:hydrawise/weather/weather.dart';

void main() {
  group('App', () {
    testWidgets('renders CustomerDetailsPage', (tester) async {
      final database = await CreateHydrawiseDatabase().call(
        databaseName: 'in_memory.db',
        version: 1,
      );

      final getCustomerDetails = GetFakeCustomerDetails(database: database);
      final getCustomerStatus = GetFakeCustomerStatus(database: database);
      final dataStorage = InMemoryStorage();
      final getApiKey = GetApiKeyFromStorage(dataStorage);
      final setApiKey = SetApiKeyInStorage(dataStorage);
      final clearCustomerDetails = ClearCustomerDetailsFromStorage(dataStorage);
      final runZone = RunZoneLocally(database: database);
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
        getLocation: getLocation,
        setLocation: setLocation,
        getWeather: getWeather,
      ));
      expect(find.byType(CustomerDetailsPage), findsOneWidget);
    });
  }, skip: 'Database requires real device.');
}
