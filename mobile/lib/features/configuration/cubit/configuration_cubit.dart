import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/features/configuration/domain/get_user_timezone.dart';
import 'package:irri/features/configuration/domain/update_user_timezone.dart';
import 'package:irri/features/push_notifications/push_notifications.dart';

part 'configuration_state.dart';
part 'configuration_cubit.freezed.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit({
    required GetPushNotificationsEnabled getPushNotificationsEnabled,
    required RegisterForPushNotifications registerForPushNotifications,
    required GetUserTimezone getUserTimezone,
    required UpdateUserTimeZone updateUserTimeZone,
  })  : _getPushNotificationsEnabled = getPushNotificationsEnabled,
        _registerForPushNotifications = registerForPushNotifications,
        _getUserTimezone = getUserTimezone,
        _updateUserTimeZone = updateUserTimeZone,
        super(ConfigurationState()) {
    _initState();
  }

  final GetPushNotificationsEnabled _getPushNotificationsEnabled;
  final RegisterForPushNotifications _registerForPushNotifications;
  final GetUserTimezone _getUserTimezone;
  final UpdateUserTimeZone _updateUserTimeZone;

  Future<void> _initState() async {
    final pushEnabled = await _getPushNotificationsEnabled();
    final userTimeZone = await _getUserTimezone();

    emit(
      state.copyWith(
        pushNotificationsEnabled: pushEnabled,
        timeZone: userTimeZone,
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
}
