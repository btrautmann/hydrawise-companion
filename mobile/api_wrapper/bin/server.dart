import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'middleware.dart';
import 'routes.dart';

Future<void> main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final dotEnv = DotEnv(includePlatformEnvironment: true);
  final environment = dotEnv['ENV'] ?? 'prod';

  late final String databaseHost;
  late final String databasePort;
  late final String databaseName;
  late final String databaseUsername;
  late final String databasePassword;
  if (environment == 'prod') {
    print('Running in production');
    final instanceConnectionName = dotEnv['INSTANCE_CONNECTION_NAME']!;
    databaseHost = '/cloudsql/$instanceConnectionName/.s.PGSQL.5432';
  } else {
    print('Running in development');
    final envFiles =
        dotEnv['ENV_FILE'] != null ? List<String>.from([dotEnv['ENV_FILE']]) : List<String>.from(['.env.dev']);
    print('Using .env file(s) $envFiles');
    dotEnv.load(envFiles);
    databaseHost = dotEnv['DB_HOST']!;
  }

  databasePort = dotEnv['DB_PORT']!;
  databaseName = dotEnv['DB_NAME']!;
  databaseUsername = dotEnv['DB_USER']!;
  databasePassword = dotEnv['DB_PASS']!;

  PostgreSQLConnection db() {
    return PostgreSQLConnection(
      databaseHost,
      int.parse(databasePort),
      databaseName,
      username: databaseUsername,
      password: databasePassword,
      isUnixSocket: environment == 'prod',
    );
  }

  tz.initializeTimeZones();

  // Configure routes.
  final router = Router()
    ..get('/', Index())
    ..post('/login', Login(db))
    ..post('/trigger_group', TriggerGroup(db, dotEnv))
    ..post('/trigger_run', TriggerRun(db))
    ..post('/run_zone', RunZone(db))
    ..post('/stop_zone', StopZone(db))
    ..put('/zone', UpdateZone(db))
    ..post('/program', CreateProgram(db, dotEnv))
    ..get('/program', GetPrograms(db))
    ..put('/program', UpdateProgram(db))
    ..delete('/program', DeleteProgram(db))
    ..get('/customer', GetCustomer(db))
    ..get('/ping', Ping());

  final handler = const Pipeline()
      .addMiddleware(logPriorRequests())
      .addMiddleware(logRequests())
      .addMiddleware(authentication(db))
      .addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}

Middleware logPriorRequests({void Function(String message, bool isError)? logger}) => (innerHandler) => (request) {
      print('Received request ${request.url}');

      return Future.sync(() => innerHandler(request));
    };
