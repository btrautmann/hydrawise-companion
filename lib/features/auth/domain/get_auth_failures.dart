import 'dart:async';

class GetAuthFailures {
  GetAuthFailures({
    required StreamController<void> authFailuresController,
  }) : _authFailuresController = authFailuresController;

  final StreamController<void> _authFailuresController;

  Future<Stream<void>> call() async {
    return _authFailuresController.stream.asBroadcastStream();
  }
}
