import 'package:irri/auth/auth.dart';

class LogOut {
  LogOut({
    required SetApiKey setApiKey,
  }) : _setApiKey = setApiKey;

  final SetApiKey _setApiKey;

  Future<void> call() async {
    await _setApiKey('');
  }
}
