import 'dart:async';

class GetAuthFailures {
  final StreamController<void> _authFailuresController;

  GetAuthFailures({
    required StreamController<void> authFailuresController,
  }) : _authFailuresController = authFailuresController;

  Future<Stream<void>> call() async {
    return _authFailuresController.stream.asBroadcastStream();
  }
}
