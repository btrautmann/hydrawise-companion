import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class TimelineEntry {
  final TimeOfDay time;
  final Duration duration;

  TimelineEntry(
    this.time,
    this.duration,
  );
}

extension on DateTime {
  DateTime apply(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

enum NodeType { solo, jointWithTop, jointWithBottom, surrounded, overlap }

class TimelineBuilder extends StatelessWidget {
  final List<TimelineEntry> entries;
  final String Function(TimelineEntry entry) buildTitle;
  final ValueSetter<TimelineEntry> onEntryRemoved;
  final Function(TimelineEntry entry, TimeOfDay startTime) onEntryStartTimeChanged;
  final Function(TimelineEntry entry, double duration) onEntryDurationChanged;

  const TimelineBuilder({
    Key? key,
    required this.entries,
    required this.buildTitle,
    required this.onEntryRemoved,
    required this.onEntryStartTimeChanged,
    required this.onEntryDurationChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    entries.sort((a, b) {
      final aDate = now.apply(a.time);
      final bDate = now.apply(b.time);
      return aDate.millisecondsSinceEpoch.compareTo(bDate.millisecondsSinceEpoch);
    });
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final currentEntry = entries[index];
        final currentEntryTime = DateTime.now().apply(currentEntry.time);
        final previousEntryTime = index == 0 ? currentEntryTime : DateTime.now().apply(entries[index - 1].time);
        final nextEntryTime =
            index == entries.length - 1 ? currentEntryTime : DateTime.now().apply(entries[index + 1].time);
        final isDirectlyAfterPrevious = entries.length > 1 &&
            (previousEntryTime == currentEntryTime ||
                currentEntryTime.subtract(currentEntry.duration).isAtSameMomentAs(previousEntryTime));
        final endsDirectlyBeforeNext = entries.length > 1 &&
            (currentEntryTime == nextEntryTime ||
                currentEntryTime.add(currentEntry.duration).isAtSameMomentAs(nextEntryTime));
        final overlapsWithPrevious = currentEntryTime != previousEntryTime &&
            currentEntryTime.subtract(currentEntry.duration).isBefore(previousEntryTime);
        final overlapsWithNext =
            currentEntryTime != nextEntryTime && currentEntryTime.add(currentEntry.duration).isAfter(nextEntryTime);
        final hasOverlap = overlapsWithPrevious || overlapsWithNext;

        NodeType nodeType;
        if (hasOverlap) {
          nodeType = NodeType.overlap;
        } else if (index == 0) {
          if (endsDirectlyBeforeNext) {
            nodeType = NodeType.jointWithBottom;
          } else {
            nodeType = NodeType.solo;
          }
        } else if (index == entries.length - 1) {
          if (isDirectlyAfterPrevious) {
            nodeType = NodeType.jointWithTop;
          } else {
            nodeType = NodeType.solo;
          }
        } else if (endsDirectlyBeforeNext && isDirectlyAfterPrevious) {
          nodeType = NodeType.surrounded;
        } else if (endsDirectlyBeforeNext) {
          nodeType = NodeType.jointWithBottom;
        } else {
          nodeType = NodeType.jointWithTop;
        }

        final DashLocation location;
        final Color color;
        switch (nodeType) {
          case NodeType.overlap:
            color = Colors.red.shade300;
            if (overlapsWithPrevious) {
              location = DashLocation.top;
            } else {
              location = DashLocation.bottom;
            }
            break;
          case NodeType.solo:
            color = Colors.green.shade300;
            location = DashLocation.none;
            break;
          case NodeType.jointWithTop:
            color = Colors.blue.shade300;
            location = DashLocation.top;
            break;
          case NodeType.jointWithBottom:
            color = Colors.green.shade300;
            location = DashLocation.bottom;
            break;
          case NodeType.surrounded:
            color = Colors.blue.shade300;
            location = DashLocation.all;
            break;
        }
        return ColoredBox(
          color: index.isEven ? Colors.grey.shade100 : Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DashedVerticalLine(
                        color: hasOverlap ? Colors.red.shade500 : Colors.grey.shade500,
                        width: 1.5,
                        location: location,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Pressed the time');
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(color), // <-- Button color
                        ),
                        child: const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentEntry.time.format(context),
                            textAlign: TextAlign.center,
                          ),
                          Expanded(
                            child: Slider(
                              value: currentEntry.duration.inMinutes.toDouble(),
                              onChanged: (time) => onEntryDurationChanged(currentEntry, time),
                              min: 1,
                              max: 60,
                            ),
                          ),
                          Text(
                            currentEntry.time.format(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
