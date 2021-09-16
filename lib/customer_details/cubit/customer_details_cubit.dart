// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrawise/customer_details/api/domain/get_api_key.dart';
import 'package:hydrawise/customer_details/api/domain/set_api_key.dart';
import 'package:hydrawise/customer_details/cubit/customer_details_state.dart';
import 'package:hydrawise/customer_details/customer_details.dart';
import 'package:hydrawise/customer_details/domain/clear_customer_details.dart';
import 'package:hydrawise/customer_details/domain/get_customer_details.dart';

class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  CustomerDetailsCubit({
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
        super(CustomerDetailsState.loading()) {
    _loadCustomerDetails();
  }

  final GetCustomerDetails _getCustomerDetails;
  final GetCustomerStatus _getCustomerStatus;
  final GetApiKey _getApiKey;
  final SetApiKey _setApiKey;
  final ClearCustomerDetails _clearCustomerDetails;

  Future<void> _loadCustomerDetails() async {
    emit(CustomerDetailsState.loading());
    final apiKey = await _getApiKey();
    if (apiKey != null && apiKey.isNotEmpty) {
      final customerDetails = await _getCustomerDetails();
      final customerStatus = await _getCustomerStatus(
        activeControllerId: customerDetails.activeControllerId,
      );
      emit(CustomerDetailsState.complete(
        customerDetails: customerDetails,
        customerStatus: customerStatus,
      ));
      _poll();
    } else {
      emit(CustomerDetailsState.empty());
    }
  }

  void _poll() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      state.when(
          loading: () {},
          empty: () {},
          complete: (details, status) async {
            final customerStatus = await _getCustomerStatus();
            emit(
              CustomerDetailsState.complete(
                customerDetails: details,
                customerStatus: customerStatus,
              ),
            );
          });
    });
  }

  Future<void> updateApiKey(String apiKey) async {
    await _setApiKey(apiKey);
    await _loadCustomerDetails();
  }

  Future<void> logOut() async {
    await _clearCustomerDetails();
    await _loadCustomerDetails();
  }
}
