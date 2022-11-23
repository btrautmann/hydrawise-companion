import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/auth/providers.dart';
import 'package:irri/auth/set_api_key.dart';

part 'log_out_controller.dart';

class LogOut {
  LogOut({
    required SetApiKey setApiKey,
  }) : _setApiKey = setApiKey;

  final SetApiKey _setApiKey;

  Future<void> call() async {
    await _setApiKey('');
  }
}
