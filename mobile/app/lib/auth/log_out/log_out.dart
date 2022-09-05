import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/auth/auth.dart';
import 'package:irri/auth/providers.dart';

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
