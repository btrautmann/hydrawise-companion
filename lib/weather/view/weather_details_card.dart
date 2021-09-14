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
      complete: (weather) => _WeatherDetailsView(weather: weather),
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
    required this.weather,
  }) : super(key: key) {
    _currentWeather = weather
        .firstWhere((element) => element.date?.day == DateTime.now().day);
  }

  final List<Weather> weather;

  late Weather _currentWeather;

  @override
  Widget build(BuildContext context) {
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
            currentWeather: _currentWeather,
          )
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Right now',
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }

  final Weather currentWeather;
}
