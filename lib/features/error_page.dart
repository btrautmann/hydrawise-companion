import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Exception? _exception;
  const ErrorPage({Key? key, required Exception? exception})
      : _exception = exception,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error: ${_exception.toString()}'),
      ),
    );
  }
}
