import 'package:api_models/api_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/app/app.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/customer_details/customer_details.dart';

part 'providers.freezed.dart';

@freezed
class CustomerDetailsState with _$CustomerDetailsState {
  factory CustomerDetailsState.loading() = _Loading;

  factory CustomerDetailsState.complete({
    required Customer customerDetails,
    required List<Zone> zones,
  }) = _Complete;
}

final customerDetailsRepositoryProvider = Provider<CustomerDetailsRepository>((ref) {
  return InMemoryCustomerDetailsRepository();
});

final getCustomerDetailsProvider = Provider<GetCustomerDetails>((ref) {
  return GetCustomerDetails(
    httpClient: ref.watch(httpClientProvider),
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

final getNextPollTimeProvider = Provider<GetNextPollTime>((ref) {
  return GetNextPollTime(ref.watch(storageProvider));
});

final setNextPollTimeProvider = Provider<SetNextPollTime>((ref) {
  return SetNextPollTime(ref.watch(storageProvider));
});

class CustomerNotifier extends StateNotifier<CustomerDetailsState> {
  CustomerNotifier({
    required GetCustomerDetails getCustomerDetails,
    required AuthState authState,
  })  : _getCustomerDetails = getCustomerDetails,
        _authState = authState,
        super(CustomerDetailsState.loading()) {
    _init();
  }

  final GetCustomerDetails _getCustomerDetails;
  final AuthState _authState;

  Future<void> _init() async {
    if (_authState.isLoggedIn()) {
      await _loadCustomerDetails();
    }
  }

  Future<void> _loadCustomerDetails() async {
    state = CustomerDetailsState.loading();
    final customerDetails = await _getCustomerDetails();

    // TODO(brandon): Handle failure
    if (customerDetails.isSuccess) {
      state = CustomerDetailsState.complete(
        customerDetails: customerDetails.success.customer,
        zones: customerDetails.success.zones,
      );
    }
  }
}

final customerDetailsStateProvider = StateNotifierProvider<CustomerNotifier, CustomerDetailsState>((ref) {
  return CustomerNotifier(
    getCustomerDetails: ref.watch(getCustomerDetailsProvider),
    authState: ref.watch(authProvider),
  );
});
