import 'package:bloc/bloc.dart';
import 'package:hydrawise/weather/cubit/weather_details_state.dart';
import 'package:hydrawise/weather/domain/get_location.dart';
import 'package:hydrawise/weather/domain/get_weather.dart';
import 'package:hydrawise/weather/domain/set_location.dart';

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
    // TODO(brandon): Fetch location from preferences
    final weather = await _getWeather('Newark, Delaware');
    emit(WeatherDetailsState.complete(fiveDayForecast: weather));
  }

  Future<void> setLocation(String cityName) async {
    await _setLocation(cityName);
    await _fetchWeather();
  }
}
