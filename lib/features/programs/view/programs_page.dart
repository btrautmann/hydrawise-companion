import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrawise/core-ui/core_ui.dart';
import 'package:hydrawise/features/programs/programs.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ProgramsPageView(),
      ),
    );
  }
}

class ProgramsPageView extends StatelessWidget {
  const ProgramsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramsCubit, ProgramsState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Programs',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            Visibility(visible: state.programs.isEmpty, child: const Spacer()),
            Visibility(
              visible: state.programs.isEmpty,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No programs'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push('/create_program');
                        },
                        child: const Text('Create Program'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: state.programs.isNotEmpty,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.programs.length,
                      itemBuilder: (context, index) {
                        return ListRow(
                          leadingIcon: CircleBackground(
                            child: Text(
                              state.programs[index].name.characters.first,
                            ),
                          ),
                          title: Text(state.programs[index].name),
                          onTapped: () {
                            showDialog(
                              context: context,
                              builder: (_) => ProgramDetailsDialog(
                                program: state.programs[index],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).push('/create_program');
                    },
                    child: const Text('ADD PROGRAM'),
                  )
                ],
              ),
            ),
            Visibility(visible: state.programs.isEmpty, child: const Spacer()),
          ],
        );
      },
    );
  }
}

class ProgramDetailsDialog extends StatelessWidget {
  final Program _program;
  const ProgramDetailsDialog({
    Key? key,
    required Program program,
  })  : _program = program,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_program.name),
            Text(_program.frequency.toString()),
            Text(_program.runs.toString()),
          ],
        ),
      ),
    );
  }
}
