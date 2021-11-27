import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/core-ui/widgets/h_stretch.dart';
import 'package:hydrawise/features/weather/weather.dart';

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
      noLocationInformation: () => const _NoLocationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      complete: (weather) => _WeatherDetailsView(weatherForecast: weather),
      error: (message) => _NoLocationView(
        message: message,
      ),
    );
  }
}

class _NoLocationView extends StatefulWidget {
  const _NoLocationView({
    Key? key,
    this.message,
  }) : super(key: key);

  // This is sort of a hack right now to avoid defining another
  // view for the error state. In theory the API may just be down,
  // and we would be acting as if they need to re-enter location.
  // TODO(brandon): Define a real error view
  final String? message;

  @override
  __NoLocationViewState createState() => __NoLocationViewState();
}

class __NoLocationViewState extends State<_NoLocationView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HStretch(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Weather',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                suffixIcon: Visibility(
                  visible: _controller.text.isNotEmpty,
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<WeatherDetailsCubit>()
                          .setLocation(_controller.text);
                    },
                    icon: const Icon(Icons.check_circle_outline),
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: 'City, State',
              ),
            ),
          ),
          if (widget.message != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(widget.message!),
            )
        ],
      ),
    );
  }
}

class _WeatherDetailsView extends StatelessWidget {
  const _WeatherDetailsView({
    Key? key,
    required this.weatherForecast,
  }) : super(key: key);

  final List<Weather> weatherForecast;

  @override
  Widget build(BuildContext context) {
    final currentWeather = weatherForecast.first;
    final tomorrowWeather = weatherForecast.firstWhere(
      (weather) => weather.date!.difference(currentWeather.date!).inHours > 24,
    );
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HStretch(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Weather',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
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
