import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required Exception? exception})
      : _exception = exception,
        super(key: key);

  final Exception? _exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error: ${_exception.toString()}'),
      ),
    );
  }
}
