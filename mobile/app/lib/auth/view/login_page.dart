import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irri/auth/providers.dart';

/// Page for the user to enter their API key
/// and gain access to the rest of the application
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: _ApiKeyInput(),
    );
  }
}

class _ApiKeyInput extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return __ApiKeyInputState();
  }
}

class __ApiKeyInputState extends ConsumerState<_ApiKeyInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your Hydrawise API key',
            ),
          ),
          const VSpace(spacing: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(authProvider.notifier).login(_controller.text);
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
