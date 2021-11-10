import 'dart:async';

abstract class GetAuthFailures {
  Future<Stream<void>> call();
}

class GetNetworkAuthFailures implements GetAuthFailures {
  final StreamController<void> _authFailuresController;

  GetNetworkAuthFailures({
    required StreamController<void> authFailuresController,
  }) : _authFailuresController = authFailuresController;

  @override
  Future<Stream<void>> call() async {
    return _authFailuresController.stream.asBroadcastStream();
  }
}
