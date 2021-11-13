import 'dart:async';

import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/app_theme_mode/app_theme_mode.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/login/login.dart';
import 'package:hydrawise/features/programs/programs.dart';
import 'package:hydrawise/features/run_zone/run_zone.dart';
import 'package:hydrawise/features/weather/weather.dart';
import 'package:provider/provider.dart';

abstract class ProductionDomainFactory {
  static List<Provider> build({
    required HttpClient client,
    required DataStorage dataStorage,
    required CustomerDetailsRepository repository,
    // ignore: prefer_void_to_null
    required StreamController<Null> authFailures,
  }) {
    final clearCustomerDetails = ClearCustomerDetailsFromStorage(
      dataStorage: dataStorage,
      customerDetailsRepository: repository,
    );
    final getApiKey = GetApiKeyFromStorage(dataStorage);
    final setApiKey = SetApiKeyInStorage(dataStorage);
    final getWeather = GetWeatherFromNetwork();
    final getLocation = GetLocationFromStorage(dataStorage);
    final setLocation = SetLocationInStorage(dataStorage);
    final getNextPollTime = GetNextPollTimeFromStorage(dataStorage);
    final setNextPollTime = SetNextPollTimeInStorage(dataStorage);

    final getCustomerDetails = GetCustomerDetailsFromNetwork(
      httpClient: client,
      repository: repository,
      getApiKey: getApiKey,
    );
    final getCustomerStatus = GetCustomerStatusFromNetwork(
      httpClient: client,
      repository: repository,
      getApiKey: getApiKey,
      getNextPollTime: getNextPollTime,
      setNextPollTime: setNextPollTime,
    );
    final getPrograms = GetProgramsFromRepository(repository: repository);
    final createProgram = AddProgramToRepository(repository: repository);
    final deleteProgram = DeleteProgram(repository: repository);

    final runZone = RunZoneOverNetwork(
      httpClient: client,
      getApiKey: getApiKey,
      setNextPollTime: setNextPollTime,
      repository: repository,
    );

    final stopZone = StopZoneOverNetwork(
      httpClient: client,
      getApiKey: getApiKey,
    );

    final setAppThemeMode = SetAppThemeModeInStorage(dataStorage);
    final getAppThemeMode = GetAppThemeModeFromStorage(dataStorage);
    final getAuthFailures = GetNetworkAuthFailures(
      authFailuresController: authFailures,
    );

    return [
      Provider<GetCustomerDetails>.value(value: getCustomerDetails),
      Provider<GetCustomerStatus>.value(value: getCustomerStatus),
      Provider<GetPrograms>.value(value: getPrograms),
      Provider<CreateProgram>.value(value: createProgram),
      Provider<DeleteProgram>.value(value: deleteProgram),
      Provider<GetApiKey>.value(value: getApiKey),
      Provider<SetApiKey>.value(value: setApiKey),
      Provider<ClearCustomerDetails>.value(value: clearCustomerDetails),
      Provider<RunZone>.value(value: runZone),
      Provider<StopZone>.value(value: stopZone),
      Provider<GetLocation>.value(value: getLocation),
      Provider<SetLocation>.value(value: setLocation),
      Provider<GetWeather>.value(value: getWeather),
      Provider<SetAppThemeMode>.value(value: setAppThemeMode),
      Provider<GetAppThemeMode>.value(value: getAppThemeMode),
      Provider<GetAuthFailures>.value(value: getAuthFailures),
    ];
  }
}

abstract class DevelopmentDomainFactory {
  static List<Provider> build({
    required DataStorage dataStorage,
    required CustomerDetailsRepository repository,
  }) {
    final clearCustomerDetails = ClearCustomerDetailsFromStorage(
      dataStorage: dataStorage,
      customerDetailsRepository: repository,
    );
    final getApiKey = GetApiKeyFromStorage(dataStorage);
    final setApiKey = SetApiKeyInStorage(dataStorage);
    final getWeather = GetWeatherFromNetwork();
    final getLocation = GetLocationFromStorage(dataStorage);
    final setLocation = SetLocationInStorage(dataStorage);
    final runZone = RunZoneLocally(repository: repository);
    final stopZone = StopZoneLocally(repository: repository);
    final getCustomerDetails = GetFakeCustomerDetails(repository: repository);
    final getCustomerStatus = GetFakeCustomerStatus(repository: repository);
    final getPrograms = GetProgramsFromRepository(repository: repository);
    final createProgram = AddProgramToRepository(repository: repository);
    final deleteProgram = DeleteProgram(repository: repository);
    final setAppThemeMode = SetAppThemeModeInStorage(dataStorage);
    final getAppThemeMode = GetAppThemeModeFromStorage(dataStorage);
    final getAuthFailures = GetNetworkAuthFailures(
      // We need to inject this to fulfill our dependency
      // injection contract, but we just create the controller
      // here because we'll never fail auth while in development
      // mode
      authFailuresController: StreamController(),
    );

    return [
      Provider<GetCustomerDetails>.value(value: getCustomerDetails),
      Provider<GetCustomerStatus>.value(value: getCustomerStatus),
      Provider<GetPrograms>.value(value: getPrograms),
      Provider<CreateProgram>.value(value: createProgram),
      Provider<DeleteProgram>.value(value: deleteProgram),
      Provider<GetApiKey>.value(value: getApiKey),
      Provider<SetApiKey>.value(value: setApiKey),
      Provider<ClearCustomerDetails>.value(value: clearCustomerDetails),
      Provider<RunZone>.value(value: runZone),
      Provider<StopZone>.value(value: stopZone),
      Provider<GetLocation>.value(value: getLocation),
      Provider<SetLocation>.value(value: setLocation),
      Provider<GetWeather>.value(value: getWeather),
      Provider<SetAppThemeMode>.value(value: setAppThemeMode),
      Provider<GetAppThemeMode>.value(value: getAppThemeMode),
      Provider<GetAuthFailures>.value(value: getAuthFailures),
    ];
  }
}
