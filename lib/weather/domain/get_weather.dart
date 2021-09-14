import 'package:weather/weather.dart';

typedef GetWeather = Future<List<Weather>> Function(String cityName);

class GetWeatherFromNetwork {
  Future<List<Weather>> call(String cityName) async {
    const openWeatherMapApiKey =
        String.fromEnvironment('OPEN_WEATHER_MAP_API_KEY');
    final weatherFactory = WeatherFactory(openWeatherMapApiKey);
    // TODO(brandon): Handle error case
    return weatherFactory.fiveDayForecastByCityName(cityName);
  }
}
