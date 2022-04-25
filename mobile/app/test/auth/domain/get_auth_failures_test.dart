import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:irri/auth/auth.dart';

void main() {
  group('GetAuthFailures', () {
    late StreamController controller;

    setUp(() {
      controller = StreamController<void>();
    });

    tearDown(() {
      controller.close();
    });

    test('it returns the stream from the provided streamcontroller', () async {
      final subject = GetAuthFailures(
        authFailuresController: controller,
      );
      final stream = await subject.call();
      controller.add(null);
      await expectLater(stream, emits(null));
    });
  });
}
