import 'package:result_type/result_type.dart';
import 'package:weather/weather.dart';

class GetWeather {
  Future<Result<List<Weather>, String>> call(String cityName) async {
    const openWeatherMapApiKey = String.fromEnvironment('OPEN_WEATHER_MAP_API_KEY');
    final weatherFactory = WeatherFactory(openWeatherMapApiKey);
    try {
      final weather = await weatherFactory.fiveDayForecastByCityName(cityName);
      return Success(weather);
    } on OpenWeatherAPIException catch (err) {
      return Failure(err.toString());
    }
  }
}
