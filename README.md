# Irri

Third party, modern support for the Hydrawise API

[![License: MIT][license_badge]][license_link]

<p align="center">
  <img width="300" height="349" src="https://github.com/btrautmann/hydrawise-companion/blob/main/assets/app_logo.png">
</p>

### Welcome to Irri

Irri is a passion project that aims to bring a bit of modernization to the experience of interacting with your Hydrawise irrigation system. It offers a clean, minimalistic UI and takes full advantage of the public Hydrawise API, while also layering on its own capabilities.

### Features included:

:white_check_mark: Dark mode

:white_check_mark: Quickly rename zones while maintaining original names in the first-party Hydrawise app

:construction: Ability to create and update programs in supersonic speed

:construction: Push notifications when runs begin

:construction: Integration with OpenWeatherMap API

:construction: and more! (coming soon)

---

## Getting Started 🚀

### Open Weather Map API

_**Note: I've currently removed the Open Weather Map API functionality from the app, so this does not apply. I'm leaving it here for a future re-introduction**_

This project makes use of the [OpenWeatherMap API](https://openweathermap.org/api) to fetch weather data. Before building the app, you need to obtain your own API key by creating an account on their website, and make sure that this key is available as an environment variable when deploying the app. This can be done by passing the API key to the `--dart-define` flag (e.g `--dart-define OPEN_WEATHER_MAP_API_KEY=<your_api_key_goes_here>`). The variable name matters, so make sure it's equivalent to `OPEN_WEATHER_MAP_API_KEY`. If you are using VSCode for development and want to make use of the `launch.json` (rather than building from the command line), you'll also need to add this key to your machine's environment's variables (and will need to restart VSCode after doing so) so that `launch.json` can provide it to the app when building.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
