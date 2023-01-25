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

class _Zone {
  final int id;
  final String name;
  _Zone(this.id, this.name);
}

class _MyHomePageState extends State<MyHomePage> {
  final zones = <_Zone>[
    _Zone(1, '1'),
    _Zone(2, '2'),
    _Zone(3, '3'),
    _Zone(4, '4'),
    _Zone(5, '5'),
  ];
  final entries = <TimelineEntry>[];
  final mapping = <String, _Zone>{};
  bool isValid = true;

  void _addStartTime(TimelineEntry entry, _Zone zone) {
    if (zones.isNotEmpty) {
      setState(() {
        mapping[entry.id] = zone;
        entries.add(entry);
      });
    }
  }

  void _changeStartTime(String entryId, TimeOfDay time) {
    final entry = entries.singleWhere(
      (element) => element.id == entryId,
    );
    final adjustedEntry = TimelineEntry(
      time: time,
      duration: entry.duration,
      id: entry.id,
    );
    setState(() {
      entries
        ..removeWhere((element) => element.id == adjustedEntry.id)
        ..add(adjustedEntry);
    });
  }

  void _changeDuration(String entryId, double duration) {
    final entry = entries.singleWhere(
      (element) => element.id == entryId,
    );
    setState(() {
      entries
        ..removeWhere((element) => element.id == entryId)
        ..add(
          TimelineEntry(
            time: entry.time,
            duration: Duration(minutes: duration.toInt()),
            id: entry.id,
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Visibility(
        visible: isValid,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final zone = await showDialog<_Zone>(
              context: context,
              builder: (_) {
                return Dialog(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: zones.length,
                    itemBuilder: (context, index) {
                      final zone = zones[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop(zone);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(zone.name),
                        ),
                      );
                    },
                  ),
                );
              },
            );
            if (zone != null && mounted) {
              entries.sortByTime();
              final lastEntry = entries.isEmpty ? null : entries.last;
              final TimeOfDay? newTime = await showTimePicker(
                context: context,
                initialTime: lastEntry == null
                    ? TimeOfDay.now()
                    : TimeOfDay.fromDateTime(
                        DateTime.now().apply(lastEntry.time).add(lastEntry.duration),
                      ),
              );
              if (newTime != null) {
                _addStartTime(
                  TimelineEntry(
                    time: newTime,
                    duration: const Duration(minutes: 10),
                  ),
                  zone,
                );
              }
            }
          },
          backgroundColor: Colors.green.shade300,
          label: const Text('Add Start'),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TimelineBuilder(
                entries: entries,
                buildTitle: (entryId) {
                  final zone = mapping[entryId]!;
                  final entry = entries.singleWhere(
                    (element) => element.id == entryId,
                  );
                  return 'Zone ${zone.name} runs for ${entry.duration.inMinutes} minutes';
                },
                onEntryDurationChanged: (String entryId, double duration) {
                  _changeDuration(entryId, duration);
                },
                onValidityChanged: (valid) {
                  setState(() {
                    isValid = valid;
                  });
                },
                onNodeTapped: (node) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mapping.remove(node);
                                  entries.removeWhere(
                                    (element) => element.id == node,
                                  );
                                });
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Remove run'),
                              ),
                            ),
                            const Divider(),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                final TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime: entries.singleWhere((element) => element.id == node).time,
                                );
                                if (newTime != null) {
                                  _changeStartTime(node, newTime);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('Adjust start time'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
