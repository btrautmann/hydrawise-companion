import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Playground'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final startTimes = <TimelineEntry>[];

  void _addStartTime(TimelineEntry entry) {
    setState(() {
      startTimes.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TimelineBuilder(
                entries: startTimes,
                buildTitle: (entry) => 'Will run for ${entry.duration.inMinutes} minutes',
                onEntryDurationChanged: (TimelineEntry entry, double duration) {},
                onEntryRemoved: (TimelineEntry value) {},
                onEntryStartTimeChanged: (TimelineEntry entry, TimeOfDay startTime) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                children: [1, 2, 3, 4, 5]
                    .map(
                      (e) => ActionChip(
                        onPressed: () {
                          print('add zone');
                        },
                        label: Text('Zone $e'),
                      ),
                    )
                    .toList()
                  ..add(
                    ActionChip(
                      onPressed: () async {
                        final TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (newTime != null) {
                          _addStartTime(
                            TimelineEntry(
                              newTime,
                              const Duration(minutes: 10),
                            ),
                          );
                        }
                      },
                      backgroundColor: Colors.green.shade300,
                      label: const Text('Add Start'),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
