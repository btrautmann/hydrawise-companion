import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/login/login.dart';

part 'customer_details_state.dart';
part 'customer_details_cubit.freezed.dart';

class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  CustomerDetailsCubit({
    required GetCustomerDetails getCustomerDetails,
    required GetCustomerStatus getCustomerStatus,
    required LoginCubit loginCubit,
  })  : _getCustomerDetails = getCustomerDetails,
        _getCustomerStatus = getCustomerStatus,
        _loginCubit = loginCubit,
        super(CustomerDetailsState.loading());

  final GetCustomerDetails _getCustomerDetails;
  final GetCustomerStatus _getCustomerStatus;
  final LoginCubit _loginCubit;

  Timer? _timer;

  void start() {
    if (_loginCubit.state.isLoggedIn()) {
      // Need to check initial login state because
      // LoginCubit stream will not emit logged in
      // if already logged in when we begin listening
      _loadCustomerDetails();
    }
    _loginCubit.stream.asBroadcastStream().listen((event) {
      event.when(loggedIn: (_) async {
        _loadCustomerDetails();
      }, loggedOut: () {
        _timer?.cancel();
        _timer = null;
      });
    });
  }

  void _loadCustomerDetails() async {
    emit(CustomerDetailsState.loading());
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
  }

  void _poll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
