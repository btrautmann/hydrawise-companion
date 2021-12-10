import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/features/push_notifications/push_notifications.dart';

part 'configuration_state.dart';
part 'configuration_cubit.freezed.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit({
    required GetPushNotificationsEnabled getPushNotificationsEnabled,
    required RegisterForPushNotifications registerForPushNotifications,
  })  : _getPushNotificationsEnabled = getPushNotificationsEnabled,
        _registerForPushNotifications = registerForPushNotifications,
        super(ConfigurationState()) {
    _initState();
  }

  final GetPushNotificationsEnabled _getPushNotificationsEnabled;
  final RegisterForPushNotifications _registerForPushNotifications;

  Future<void> _initState() async {
    final pushEnabled = _getPushNotificationsEnabled();
    final userTimeZone = () {};
  }
}
