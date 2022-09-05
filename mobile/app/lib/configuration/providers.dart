import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/push_notifications/domain/domain.dart';

part 'providers.freezed.dart';

@freezed
class ConfigurationState with _$ConfigurationState {
  factory ConfigurationState({
    @Default(false) bool pushNotificationsEnabled,
    @Default(null) String? localTimezone,
    @Default([]) List<String> availableTimezones,
    String? timeZone,
  }) = _ConfigurationState;
}

final getPushNotificationsEnabledProvider = Provider<GetPushNotificationsEnabled>((ref) {
  return GetPushNotificationsEnabled(
    firebaseMessaging: FirebaseMessaging.instance,
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

final getLocalTimezoneProvider = Provider<GetLocalTimezone>((ref) {
  return GetLocalTimezone();
});

final getAvailableTimezones = Provider<GetAvailableTimezones>((ref) {
  return GetAvailableTimezones();
});

final getUserTimezoneProvider = Provider<GetUserTimezone>((ref) {
  return GetUserTimezone(repository: ref.watch(customerDetailsRepositoryProvider));
});

final updateUserTimezoneProvider = Provider<UpdateUserTimeZone>((ref) {
  return UpdateUserTimeZone(repository: ref.watch(customerDetailsRepositoryProvider));
});

final registerForPushNotificationsProvider = Provider<RegisterForPushNotifications>((ref) {
  return RegisterForPushNotifications(
    firebaseMessaging: FirebaseMessaging.instance,
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

final unregisterForPushNotificationsProvider = Provider<UnregisterForPushNotifications>((ref) {
  return UnregisterForPushNotifications(
    firebaseMessaging: FirebaseMessaging.instance,
    repository: ref.watch(customerDetailsRepositoryProvider),
  );
});

class ConfigurationNotifier extends StateNotifier<ConfigurationState> {
  ConfigurationNotifier({
    required GetPushNotificationsEnabled getPushNotificationsEnabled,
    required GetLocalTimezone getLocalTimezone,
    required GetAvailableTimezones getAvailableTimezones,
    required RegisterForPushNotifications registerForPushNotifications,
    required UnregisterForPushNotifications unregisterForPushNotifications,
    required GetUserTimezone getUserTimezone,
    required UpdateUserTimeZone updateUserTimeZone,
  })  : _getPushNotificationsEnabled = getPushNotificationsEnabled,
        _getLocalTimezone = getLocalTimezone,
        _getAvailableTimezones = getAvailableTimezones,
        _registerForPushNotifications = registerForPushNotifications,
        _unregisterForPushNotifications = unregisterForPushNotifications,
        _getUserTimezone = getUserTimezone,
        _updateUserTimeZone = updateUserTimeZone,
        super(ConfigurationState()) {
    _initState();
  }

  final GetPushNotificationsEnabled _getPushNotificationsEnabled;
  final GetLocalTimezone _getLocalTimezone;
  final GetAvailableTimezones _getAvailableTimezones;
  final RegisterForPushNotifications _registerForPushNotifications;
  final UnregisterForPushNotifications _unregisterForPushNotifications;
  final GetUserTimezone _getUserTimezone;
  final UpdateUserTimeZone _updateUserTimeZone;

  Future<void> _initState() async {
    state = state.copyWith(
      pushNotificationsEnabled: await _getPushNotificationsEnabled(),
      timeZone: await _getUserTimezone(),
      localTimezone: await _getLocalTimezone(),
      availableTimezones: await _getAvailableTimezones(),
    );
  }

  Future<void> updateUserTimezone(String timezone) async {
    await _updateUserTimeZone(timezone);
    return _initState();
  }

  Future<void> registerForPushNotifications() async {
    await _registerForPushNotifications();
    return _initState();
  }

  Future<void> unregisterForPushNotifications() async {
    await _unregisterForPushNotifications();
    return _initState();
  }
}

final configurationProvider = StateNotifierProvider<ConfigurationNotifier, ConfigurationState>((ref) {
  return ConfigurationNotifier(
    getPushNotificationsEnabled: ref.watch(getPushNotificationsEnabledProvider),
    getLocalTimezone: ref.watch(getLocalTimezoneProvider),
    getAvailableTimezones: ref.watch(getAvailableTimezones),
    registerForPushNotifications: ref.watch(registerForPushNotificationsProvider),
    unregisterForPushNotifications: ref.watch(unregisterForPushNotificationsProvider),
    getUserTimezone: ref.watch(getUserTimezoneProvider),
    updateUserTimeZone: ref.watch(updateUserTimezoneProvider),
  );
});
