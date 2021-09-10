// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/customer_details/api/get_api_key.dart';
import 'package:hydrawise/customer_details/api/set_api_key.dart';
import 'package:hydrawise/app/app.dart';
import 'package:hydrawise/core/data_storage.dart';
import 'package:hydrawise/customer_details/domain/clear_customer_details.dart';
import 'package:hydrawise/customer_details/view/customer_details_page.dart';
import 'package:hydrawise/customer_details/domain/get_customer_details.dart';

void main() {
  group('App', () {
    testWidgets('renders CustomerDetailsPage', (tester) async {
      final getCustomerDetails = GetFakeCustomerDetails();
      final dataStorage = InMemoryStorage();
      final getApiKey = GetApiKeyFromStorage(dataStorage);
      final setApiKey = SetApiKeyInStorage(dataStorage);
      final clearCustomerDetails = ClearCustomerDetailsFromStorage(dataStorage);

      await tester.pumpWidget(App(
        getCustomerDetails: getCustomerDetails,
        getApiKey: getApiKey,
        setApiKey: setApiKey,
        clearCustomerDetails: clearCustomerDetails,
      ));
      expect(find.byType(CustomerDetailsPage), findsOneWidget);
    });
  });
}
