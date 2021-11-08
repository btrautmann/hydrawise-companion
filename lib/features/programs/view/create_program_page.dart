import 'package:flutter/material.dart';

class CreateProgramPage extends StatelessWidget {
  const CreateProgramPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Program'),
      ),
      body: const CreateProgramView(),
    );
  }
}

class CreateProgramView extends StatelessWidget {
  const CreateProgramView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text('Name'),
          Text('Frequency'),
          Text('Start Times'),
        ],
      ),
    );
  }
}
