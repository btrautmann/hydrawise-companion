import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrawise/features/push_notifications/push_notifications.dart';

part 'push_notifications_state.dart';
part 'push_notifications_cubit.freezed.dart';

class PushNotificationsCubit extends Cubit<PushNotificationsState> {
  PushNotificationsCubit({
    required GetPushNotificationsEnabled getPushNotificationsEnabled,
    required RegisterForPushNotifications registerForPushNotifications,
  })  : _getPushNotificationsEnabled = getPushNotificationsEnabled,
        _registerForPushNotifications = registerForPushNotifications,
        super(
          PushNotificationsState(
            pushNotificationsEnabled: false,
          ),
        ) {
    _initState();
  }

  final GetPushNotificationsEnabled _getPushNotificationsEnabled;
  final RegisterForPushNotifications _registerForPushNotifications;

  Future<void> _initState() async {
    final enabled = await _getPushNotificationsEnabled();
    emit(state.copyWith(pushNotificationsEnabled: enabled));
  }

  Future<void> registerForPushNotifications() async {
    await _registerForPushNotifications();
    await _initState();
  }
}
