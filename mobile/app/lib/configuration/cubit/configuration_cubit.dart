import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/push_notifications/push_notifications.dart';

part 'configuration_state.dart';
part 'configuration_cubit.freezed.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit({
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
    emit(
      state.copyWith(
        pushNotificationsEnabled: await _getPushNotificationsEnabled(),
        timeZone: await _getUserTimezone(),
        localTimezone: await _getLocalTimezone(),
        availableTimezones: await _getAvailableTimezones(),
      ),
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
