import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required Exception? exception})
      : _exception = exception,
        super(key: key);

  final Exception? _exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Error: $_exception',
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: () => GoRouter.of(context).pop(),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
