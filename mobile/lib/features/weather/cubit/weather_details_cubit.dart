import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:irri/features/weather/weather.dart';
import 'package:weather/weather.dart';

part 'weather_details_cubit.freezed.dart';
part 'weather_details_state.dart';

class WeatherDetailsCubit extends Cubit<WeatherDetailsState> {
  WeatherDetailsCubit({
    required GetWeather getWeather,
    required GetLocation getLocation,
    required SetLocation setLocation,
  })  : _getWeather = getWeather,
        _getLocation = getLocation,
        _setLocation = setLocation,
        super(WeatherDetailsState.loading()) {
    _fetchWeather();
  }

  final GetWeather _getWeather;
  final GetLocation _getLocation;
  final SetLocation _setLocation;

  Future<void> _fetchWeather() async {
    final location = await _getLocation();
    if (location != null && location.isNotEmpty) {
      emit(WeatherDetailsState.loading());
      final weather = await _getWeather(location);
      if (weather.isSuccess) {
        emit(WeatherDetailsState.complete(fiveDayForecast: weather.success));
      } else {
        emit(WeatherDetailsState.error(weather.failure));
      }
    } else {
      emit(WeatherDetailsState.noLocationInformation());
    }
  }

  Future<void> setLocation(String cityName) async {
    await _setLocation(cityName);
    await _fetchWeather();
  }
}
