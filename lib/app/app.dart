// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrawise/customer_details/api/get_api_key.dart';
import 'package:hydrawise/customer_details/api/set_api_key.dart';
import 'package:hydrawise/customer_details/customer_details.dart';
import 'package:hydrawise/customer_details/domain/clear_customer_details.dart';
import 'package:hydrawise/customer_details/view/customer_details_page.dart';
import 'package:hydrawise/customer_details/domain/get_customer_details.dart';
import 'package:hydrawise/l10n/l10n.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required GetCustomerDetails getCustomerDetails,
    required GetCustomerStatus getCustomerStatus,
    required GetApiKey getApiKey,
    required SetApiKey setApiKey,
    required ClearCustomerDetails clearCustomerDetails,
  })  : _getCustomerDetails = getCustomerDetails,
        _getCustomerStatus = getCustomerStatus,
        _getApiKey = getApiKey,
        _setApiKey = setApiKey,
        _clearCustomerDetails = clearCustomerDetails,
        super(key: key);

  final GetCustomerDetails _getCustomerDetails;
  final GetCustomerStatus _getCustomerStatus;
  final GetApiKey _getApiKey;
  final SetApiKey _setApiKey;
  final ClearCustomerDetails _clearCustomerDetails;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GetCustomerDetails>.value(value: _getCustomerDetails),
        Provider<GetCustomerStatus>.value(value: _getCustomerStatus),
        Provider<GetApiKey>.value(value: _getApiKey),
        Provider<SetApiKey>.value(value: _setApiKey),
        Provider<ClearCustomerDetails>.value(value: _clearCustomerDetails),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const CustomerDetailsPage(),
      ),
    );
  }
}
