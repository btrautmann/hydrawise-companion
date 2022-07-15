import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:bloc/bloc.dart';
import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/customer_details/customer_details.dart';

part 'customer_details_cubit.freezed.dart';
part 'customer_details_state.dart';

class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  CustomerDetailsCubit({
    required GetCustomerDetails getCustomerDetails,
    required SetNextPollTime setNextPollTime,
    required GetNextPollTime getNextPollTime,
    required AuthCubit authCubit,
  })  : _getCustomerDetails = getCustomerDetails,
        _setNextPollTime = setNextPollTime,
        _getNextPollTime = getNextPollTime,
        _authCubit = authCubit,
        super(CustomerDetailsState.loading());

  final GetCustomerDetails _getCustomerDetails;
  final SetNextPollTime _setNextPollTime;
  final GetNextPollTime _getNextPollTime;
  final AuthCubit _authCubit;

  Timer? _timer;

  Future<void> start() async {
    if (_authCubit.state.isLoggedIn()) {
      // Need to check initial login state because
      // LoginCubit stream will not emit logged in
      // if already logged in when we begin listening
      await _loadCustomerDetails();
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
      emit(
        CustomerDetailsState.complete(
          customerDetails: customerDetails.success.customer,
          zones: customerDetails.success.zones,
        ),
      );
      _poll();
    }
  }

  void _poll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      state.maybeWhen(
        complete: (details, zones) async {
          final nextPollTime = await _getNextPollTime();
          if (clock.now().isAfter(nextPollTime)) {
            final response = await _getCustomerDetails();
            if (response.isSuccess) {
              // TODO(brandon): Build this back into the API
              await _setNextPollTime(secondsUntilNextPoll: 60);
              final getCustomerResponse = response.success;
              List.of(getCustomerResponse.zones).sort(
                (z1, z2) => z1.number.compareTo(
                  z2.number,
                ),
              );
              emit(
                CustomerDetailsState.complete(
                  customerDetails: getCustomerResponse.customer,
                  zones: getCustomerResponse.zones,
                ),
              );
            }
          }
        },
        orElse: () {},
      );
    });
  }
}
