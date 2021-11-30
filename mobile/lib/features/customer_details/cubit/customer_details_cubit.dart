import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/features/auth/auth.dart';
import 'package:irri/features/customer_details/customer_details.dart';

part 'customer_details_cubit.freezed.dart';
part 'customer_details_state.dart';

class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  CustomerDetailsCubit({
    required GetCustomerDetails getCustomerDetails,
    required GetCustomerStatus getCustomerStatus,
    required AuthCubit authCubit,
  })  : _getCustomerDetails = getCustomerDetails,
        _getCustomerStatus = getCustomerStatus,
        _authCubit = authCubit,
        super(CustomerDetailsState.loading());

  final GetCustomerDetails _getCustomerDetails;
  final GetCustomerStatus _getCustomerStatus;
  final AuthCubit _authCubit;

  Timer? _timer;

  void start() {
    if (_authCubit.state.isLoggedIn()) {
      // Need to check initial login state because
      // LoginCubit stream will not emit logged in
      // if already logged in when we begin listening
      _loadCustomerDetails();
    }
    _authCubit.stream.asBroadcastStream().listen((event) {
      event.when(
        loggedIn: () async {
          await _loadCustomerDetails();
        },
        loggedOut: () {
          _timer?.cancel();
          _timer = null;
        },
      );
    });
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  void resumePolling() {
    if (_authCubit.state.isLoggedIn()) {
      _poll();
    }
  }

  Future<void> _loadCustomerDetails() async {
    emit(CustomerDetailsState.loading());
    final customerDetails = await _getCustomerDetails();

    // TODO(brandon): Handle failure
    if (customerDetails.isSuccess) {
      final customerStatus = await _getCustomerStatus(
        activeControllerId: customerDetails.success.activeControllerId,
      );
      if (customerStatus.isSuccess) {
        emit(
          CustomerDetailsState.complete(
            customerDetails: customerDetails.success,
            customerStatus: customerStatus.success,
          ),
        );
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
            final status = customerStatus.success;
            status.zones.sort(
              (z1, z2) => z1.physicalNumber.compareTo(
                z2.physicalNumber,
              ),
            );
            emit(
              CustomerDetailsState.complete(
                customerDetails: details,
                customerStatus: status,
              ),
            );
          }
        },
        orElse: () {},
      );
    });
  }
}
