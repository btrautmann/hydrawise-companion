import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';

void main() {
  group('GetNextPollTimeFromStorage', () {
    final storage = InMemoryStorage();
    final getNextPollTime = GetNextPollTimeFromStorage(storage);

    setUp(() async {
      await storage.clearAll();
    });

    group('when a next poll time exists in storage', () {
      test('it gets the next poll time from next_poll_time', () async {
        await storage.setInt('next_poll_time', 1000);
        expect(
          await getNextPollTime(),
          DateTime.fromMillisecondsSinceEpoch(1000),
        );
      });
    });

    group('when a next poll time does not exist in storage', () {
      test('it returns the unix epoch', () async {
        expect(
          await getNextPollTime(),
          DateTime.fromMillisecondsSinceEpoch(0),
        );
      });
    });
  });
}
