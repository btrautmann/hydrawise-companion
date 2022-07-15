import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  const port = '8080';
  const host = 'http://0.0.0.0:$port';
  late Process process;

  setUp(() async {
    process = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port, 'ENV_FILE': '.env.test'},
    );
    final stream = process.stdout.asBroadcastStream();

    unawaited(
      stream.forEach((element) {
        print('DEBUG: ${utf8.decode(element)}');
      }),
    );
    // Wait for server to start and print to stdout.
    await stream.firstWhere(
      (element) => utf8.decode(element).contains('Server listening'),
    );

    addTearDown(() => process.kill());
  });

  test('Index', () async {
    final response = await get(Uri.parse('$host/'));
    expect(response.statusCode, 200);
    expect(response.body, 'Hello, World!');
  });

  test('404', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });
}
