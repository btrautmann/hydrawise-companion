part of 'configuration_cubit.dart';

@freezed
class ConfigurationState with _$ConfigurationState {
  factory ConfigurationState({
    @Default(false) bool pushNotificationsEnabled,
    @Default(null) String? localTimezone,
    @Default([]) List<String> availableTimezones,
    String? timeZone,
  }) = _ConfigurationState;
}
