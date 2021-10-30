part of 'weather_details_cubit.dart';

@freezed
class WeatherDetailsState with _$WeatherDetailsState {
  factory WeatherDetailsState.noLocationInformation() = _NoLocationInformation;

  factory WeatherDetailsState.loading() = _Loading;

  factory WeatherDetailsState.error(String message) = _Error;

  factory WeatherDetailsState.complete({
    required List<Weather> fiveDayForecast,
  }) = _Complete;
}
