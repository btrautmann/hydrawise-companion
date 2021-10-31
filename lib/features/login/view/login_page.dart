import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrawise/features/login/login.dart';

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

class _ApiKeyInput extends StatefulWidget {
  @override
  __ApiKeyInputState createState() => __ApiKeyInputState();
}

class __ApiKeyInputState extends State<_ApiKeyInput> {
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
          ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().login(_controller.text);
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
