import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port, 'ENV_FILE': '.env.test'},
    );
    final stream = p.stdout.asBroadcastStream();

    stream.forEach((element) {
      print('DEBUG: ${utf8.decode(element)}');
    });
    // Wait for server to start and print to stdout.
    await stream.firstWhere(
        (element) => utf8.decode(element).contains('Server listening'));
  });

  tearDown(() => p.kill());

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
