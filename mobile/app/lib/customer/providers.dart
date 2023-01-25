import 'package:api_models/api_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/app/providers.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/customer/get_customer.dart';

final getCustomerProvider = Provider<GetCustomer>((ref) {
  return GetCustomer(
    httpClient: ref.watch(httpClientProvider),
  );
});

class CustomerNotifier extends StateNotifier<AsyncValue<Customer>> {
  CustomerNotifier({
    required GetCustomer getCustomer,
    required AuthState authState,
  })  : _getCustomer = getCustomer,
        _authState = authState,
        super(const AsyncValue.loading()) {
    _init();
  }

  final GetCustomer _getCustomer;
  final AuthState _authState;

  Future<void> _init() async {
    if (_authState.isAuthenticated) {
      await _loadCustomer();
    }
  }

  Future<void> _loadCustomer() async {
    state = const AsyncValue.loading();
    try {
      final customer = await _getCustomer();
      state = AsyncValue.data(customer);
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final customerProvider =
    StateNotifierProvider<CustomerNotifier, AsyncValue<Customer>>((ref) {
  return CustomerNotifier(
    getCustomer: ref.watch(getCustomerProvider),
    authState: ref.watch(authProvider),
  );
});
