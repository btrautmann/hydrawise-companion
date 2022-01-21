part of 'configuration_cubit.dart';

@freezed
class ConfigurationState with _$ConfigurationState {
  factory ConfigurationState({
    @Default(false) bool pushNotificationsEnabled,
    String? timeZone,
  }) = _ConfigurationState;
}
