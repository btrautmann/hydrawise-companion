import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'get_programs.dart';
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
    final envFiles = dotEnv['ENV_FILE'] != null ? List<String>.from([dotEnv['ENV_FILE']]) : List<String>.from(['.env']);
    print('Using .env file(s) $envFiles');
    dotEnv.load(envFiles);
    databaseHost = dotEnv['DB_HOST']!;
  }

  databasePort = dotEnv['DB_PORT']!;
  databaseName = dotEnv['DB_NAME']!;
  databaseUsername = dotEnv['DB_USER']!;
  databasePassword = dotEnv['DB_PASS']!;

  final db = PostgreSQLConnection(
    databaseHost,
    int.parse(databasePort),
    databaseName,
    username: databaseUsername,
    password: databasePassword,
    isUnixSocket: environment == 'prod',
  );

  await db.open();

  // Configure routes.
  final router = Router()
    ..get('/', Index())
    ..post('/v6/login', Login(db))
    ..post('/run_zone', RunZone(db))
    ..post('/stop_zone', StopZone(db))
    ..post('/program', CreateProgram(db))
    ..get('/program', GetPrograms(db))
    ..put('/program', UpdateProgram(db))
    ..get('/customer', GetCustomer(db));

  // Configure a pipeline that logs requests.
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
