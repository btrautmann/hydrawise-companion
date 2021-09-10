// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:hydrawise/customer_details/api/get_api_key.dart';
import 'package:hydrawise/customer_details/api/set_api_key.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_state.dart';
import 'package:hydrawise/customer_details/domain/clear_customer_details.dart';
import 'package:hydrawise/customer_details/domain/get_customer_details.dart';
import 'package:hydrawise/customer_details/models/customer_details.dart';

class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  CustomerDetailsCubit({
    required GetCustomerDetails getCustomerDetails,
    required GetApiKey getApiKey,
    required SetApiKey setApiKey,
    required ClearCustomerDetails clearCustomerDetails,
  })  : _getCustomerDetails = getCustomerDetails,
        _getApiKey = getApiKey,
        _setApiKey = setApiKey,
        _clearCustomerDetails = clearCustomerDetails,
        super(CustomerDetailsState.loading()) {
    _init();
  }

  final GetCustomerDetails _getCustomerDetails;
  final GetApiKey _getApiKey;
  final SetApiKey _setApiKey;
  final ClearCustomerDetails _clearCustomerDetails;

  /// Should be called when this Cubit is created
  ///
  /// Fetches the customer's API key and uses it to populate
  /// state with the [CustomerDetails].
  Future<void> _init() async {
    final apiKey = await _getApiKey();
    if (apiKey != null && apiKey.isNotEmpty) {
      final customerDetails = await _getCustomerDetails(apiKey);
      emit(CustomerDetailsState.complete(
        customerDetails: customerDetails,
      ));
    } else {
      emit(CustomerDetailsState.empty());
    }
  }

  Future<void> updateApiKey(String apiKey) async {
    await _setApiKey(apiKey);
    await _init();
  }

  Future<void> logOut() async {
    await _clearCustomerDetails();
    await _init();
  }
}
