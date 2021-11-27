part of 'push_notifications_cubit.dart';

@freezed
class PushNotificationsState with _$PushNotificationsState {
  factory PushNotificationsState({
    required bool pushNotificationsEnabled,
  }) = _PushNotificationsState;
}
