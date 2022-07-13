import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'index.dart';
import 'login.dart';

Future<void> main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final env = DotEnv(includePlatformEnvironment: true);
  final envFiles = env['ENV_FILE'] != null
      ? List<String>.from([env['ENV_FILE']])
      : List<String>.from(['.env']);
  print('Using .env file(s) $envFiles');
  env.load(envFiles);

  final connection = PostgreSQLConnection(
    env['DATABASE_HOST']!,
    int.parse(env['DATABASE_PORT']!),
    env['DATABASE_NAME']!,
    username: env['DATABASE_ROLE'],
    password: env['DATABASE_PASSWORD'],
  );

  await connection.open();

  // Configure routes.
  final router = Router()
    ..get('/', Index())
    ..get('/login', Login(connection));

  // Configure a pipeline that logs requests.
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
