import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/core-ui/widgets/h_stretch.dart';
import 'package:hydrawise/weather/cubit/weather_details_cubit.dart';
import 'package:hydrawise/weather/domain/get_location.dart';
import 'package:hydrawise/weather/domain/get_weather.dart';
import 'package:hydrawise/weather/domain/set_location.dart';
import 'package:weather/weather.dart';

class WeatherDetailsCard extends StatelessWidget {
  const WeatherDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherDetailsCubit(
        getWeather: context.read<GetWeather>(),
        getLocation: context.read<GetLocation>(),
        setLocation: context.read<SetLocation>(),
      ),
      child: const WeatherDetailsStateView(),
    );
  }
}

class WeatherDetailsStateView extends StatelessWidget {
  const WeatherDetailsStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherState =
        context.select((WeatherDetailsCubit cubit) => cubit.state);
    return weatherState.when(
      noLocationInformation: () => _NoLocationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      complete: (weather) => _WeatherDetailsView(weatherForecast: weather),
    );
  }
}

class _NoLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('No location');
  }
}

class _WeatherDetailsView extends StatelessWidget {
  _WeatherDetailsView({
    Key? key,
    required this.weatherForecast,
  }) : super(key: key);

  final List<Weather> weatherForecast;

  @override
  Widget build(BuildContext context) {
    final currentWeather = weatherForecast
        .firstWhere((element) => element.date?.day == DateTime.now().day);
    final tomorrowWeather = weatherForecast
        .firstWhere((element) => element.date!.day > currentWeather.date!.day);
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HStretch(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue,
                    Colors.blue,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Weather',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          _CurrentWeather(
            currentWeather: currentWeather,
          ),
          const Divider(
            indent: 16,
          ),
          _OtherWeatherRow(
            weather: tomorrowWeather,
            title: const Text('Tomorrow'),
          ),
        ],
      ),
    );
  }
}

class _CurrentWeather extends StatelessWidget {
  const _CurrentWeather({
    Key? key,
    required this.currentWeather,
  }) : super(key: key);

  String _currentTempString() {
    final rawTemp = currentWeather.temperature!.fahrenheit!;
    final roundedTemp = rawTemp.round();
    return '${roundedTemp.toString()}\u00B0';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Right now',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentWeather.weatherIcon != null)
                Image.network(
                  'http://openweathermap.org/img/w/${currentWeather.weatherIcon!}.png',
                ),
              Text(
                _currentTempString(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          if (currentWeather.weatherDescription != null) ...[
            Text(currentWeather.weatherDescription!)
          ],
        ],
      ),
    );
  }

  final Weather currentWeather;
}

class _OtherWeatherRow extends StatelessWidget {
  const _OtherWeatherRow({
    Key? key,
    required this.weather,
    required this.title,
  }) : super(key: key);

  final Widget title;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'http://openweathermap.org/img/w/${weather.weatherIcon!}.png',
      ),
      title: title,
      subtitle: Text(weather.weatherDescription!),
    );
  }
}
