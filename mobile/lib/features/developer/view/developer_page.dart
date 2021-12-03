import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irri/features/developer/developer.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeveloperCubit(
        getAllStorage: context.read<GetAllStorage>(),
      ),
      child: const DeveloperView(),
    );
  }
}

class DeveloperView extends StatelessWidget {
  const DeveloperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: BlocBuilder<DeveloperCubit, DeveloperState>(
            builder: (context, state) {
              final storage = state.storage;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: storage.keys.length,
                itemBuilder: (context, index) {
                  final item = storage.entries.toList()[index];
                  return Row(
                    children: [
                      Text(item.key),
                      const Spacer(),
                      Text(item.value.toString())
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
