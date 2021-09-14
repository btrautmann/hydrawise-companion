import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/weather.dart';

part 'weather_details_state.freezed.dart';

@freezed
class WeatherDetailsState with _$WeatherDetailsState {
  factory WeatherDetailsState.noLocationInformation() = _NoLocationInformation;

  factory WeatherDetailsState.loading() = _Loading;

  factory WeatherDetailsState.complete({
    required List<Weather> fiveDayForecast,
  }) = _Complete;
}
