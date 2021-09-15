import 'package:flutter/material.dart';

class RunZonesPage extends StatelessWidget {
  const RunZonesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Pop'),
        ),
      ),
    );
  }
}
