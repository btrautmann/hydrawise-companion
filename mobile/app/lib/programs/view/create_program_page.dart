import 'package:collection/collection.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CreateProgramPage extends StatelessWidget {
  const CreateProgramPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Program'),
      ),
      body: SafeArea(child: _CreateProgramView()),
    );
  }
}

class _CreateProgramView extends StatefulWidget {
  @override
  State<_CreateProgramView> createState() => _CreateProgramViewState();
}

class _CreateProgramViewState extends State<_CreateProgramView> {
  var _frequency = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Program name',
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final frequency = await showDialog<List<bool>>(
                    context: context,
                    builder: (context) {
                      return _FrequencySelectionDialog(
                        initialFrequency: _frequency,
                      );
                    },
                  );
                  if (frequency != null) {
                    setState(() {
                      _frequency = frequency;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_month),
              ),
            ],
          ),
          const VSpace(spacing: 8),
          _RunsOnText(frequency: _frequency),
          const VSpace(spacing: 8),
        ],
      ),
    );
  }
}

class _RunsOnText extends StatelessWidget {
  const _RunsOnText({required this.frequency});

  final List<bool> frequency;

  @override
  Widget build(BuildContext context) {
    late String text;
    if (frequency.every((f) => !f)) {
      text = 'Tap the calendar to set a frequency';
    } else {
      final desc = frequency.mapIndexed((index, f) => f ? index.toWeekDayName() : null).whereNotNull();
      text = 'Runs on ${desc.join(', ')}';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class _FrequencySelectionDialog extends StatefulWidget {
  const _FrequencySelectionDialog({required this.initialFrequency});

  final List<bool>? initialFrequency;

  @override
  State<_FrequencySelectionDialog> createState() => _FrequencySelectionDialogState();
}

class _FrequencySelectionDialogState extends State<_FrequencySelectionDialog> {
  late final List<bool> frequency;

  @override
  void initState() {
    super.initState();
    frequency = widget.initialFrequency ?? List.generate(7, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...frequency.mapIndexed(
              (index, element) => CheckboxListTile(
                value: frequency[index],
                onChanged: (value) {
                  setState(
                    () {
                      frequency[index] = value ?? false;
                    },
                  );
                },
                title: Text(index.toWeekDayName()),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(frequency),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on int {
  String toWeekDayName() {
    switch (this) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        throw Exception('Invalid int $this');
    }
  }
}
