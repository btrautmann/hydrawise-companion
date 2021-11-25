# Hydrawise Companion

[![License: MIT][license_badge]][license_link]

---

## Getting Started 🚀


### Open Weather Map API

This project makes use of the [OpenWeatherMap API](https://openweathermap.org/api) to fetch weather data. Before building the app, you need to obtain your own API key by creating an account on their website, and make sure that this key is available as an environment variable when deploying the app. This can be done by passing the API key to the `--dart-define` flag (e.g `--dart-define OPEN_WEATHER_MAP_API_KEY=<your_api_key_goes_here>`). The variable name matters, so make sure it's equivalent to `OPEN_WEATHER_MAP_API_KEY`. If you are using VSCode for development and want to make use of the `launch.json` (rather than building from the command line), you'll also need to add this key to your machine's environment's variables (and will need to restart VSCode after doing so) so that `launch.json` can provide it to the app when building.

### Flavors

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Hydrawise Companion works on iOS and Android_

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
