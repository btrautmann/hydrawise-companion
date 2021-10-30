import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

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
        super(CustomerDetailsState.loading()) {
    _loadCustomerDetails();
  }

  final GetCustomerDetails _getCustomerDetails;
  final GetCustomerStatus _getCustomerStatus;
  final GetApiKey _getApiKey;

  Future<void> _loadCustomerDetails() async {
    emit(CustomerDetailsState.loading());
    final apiKey = await _getApiKey();
    if (apiKey != null && apiKey.isNotEmpty) {
      final customerDetails = await _getCustomerDetails();
      // TODO(brandon): Handle failure
      if (customerDetails.isSuccess) {
        final customerStatus = await _getCustomerStatus(
          activeControllerId: customerDetails.success.activeControllerId,
        );
        if (customerStatus.isSuccess) {
          emit(CustomerDetailsState.complete(
            customerDetails: customerDetails.success,
            customerStatus: customerStatus.success,
          ));
        }
        _poll();
      }
    } else {
      emit(CustomerDetailsState.empty());
    }
  }

  void _poll() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      state.maybeWhen(
          complete: (details, status) async {
            final customerStatus = await _getCustomerStatus();
            if (customerStatus.isSuccess) {
              emit(
                CustomerDetailsState.complete(
                  customerDetails: details,
                  customerStatus: customerStatus.success,
                ),
              );
            }
          },
          orElse: () {});
    });
  }
}
