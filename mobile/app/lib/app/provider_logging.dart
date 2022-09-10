
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // ignore: avoid_print
    print(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''',
    );
  }
}
