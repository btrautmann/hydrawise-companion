import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TimelineEntry {
  final String id;
  final TimeOfDay time;
  final Duration duration;

  TimelineEntry({
    required this.time,
    required this.duration,
    String? id,
  }) : id = id ?? const Uuid().v4();
}

extension TimelineEntryListX on List<TimelineEntry> {
  void sortByTime() {
    DateTime now = DateTime.now();
    sort((a, b) {
      final aDate = now.apply(a.time);
      final bDate = now.apply(b.time);
      return aDate.millisecondsSinceEpoch.compareTo(bDate.millisecondsSinceEpoch);
    });
  }
}

extension DateTimeX on DateTime {
  DateTime apply(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

enum NodeType {
  solo,
  jointWithTop,
  jointWithBottom,
  surrounded,
  overlap,
}

class TimelineBuilder extends StatefulWidget {
  final List<TimelineEntry> entries;
  final String Function(String entryId) buildTitle;
  final Function(String entryId, double duration) onEntryDurationChanged;
  final Function(String entryId) onNodeTapped;
  final ValueSetter<bool> onValidityChanged;

  const TimelineBuilder({
    Key? key,
    required this.entries,
    required this.buildTitle,
    required this.onNodeTapped,
    required this.onEntryDurationChanged,
    required this.onValidityChanged,
  }) : super(key: key);

  @override
  State<TimelineBuilder> createState() => _TimelineBuilderState();
}

class _TimelineBuilderState extends State<TimelineBuilder> {
  bool isValid = true;

  bool calculateValidity() {
    List<bool> invalidNodes = [];
    widget.entries.asMap().forEach((index, element) {
      final currentEntry = widget.entries[index];
      final currentEntryStartTime = DateTime.now().apply(currentEntry.time);
      final currentEntryEndTime = currentEntryStartTime.add(currentEntry.duration);

      final previousEntry = index == 0 ? null : widget.entries[index - 1];
      final previousEntryStartTime = previousEntry == null ? null : DateTime.now().apply(previousEntry.time);
      final previousEntryEndTime = previousEntryStartTime?.add(previousEntry!.duration);

      final nextEntry = index == widget.entries.length - 1 ? null : widget.entries[index + 1];
      final nextEntryStartTime = nextEntry == null ? null : DateTime.now().apply(nextEntry.time);

      final overlapsWithPrevious = widget.entries.length > 1 &&
          previousEntryEndTime != null &&
          currentEntryStartTime.isBefore(previousEntryEndTime);

      final overlapsWithNext =
          widget.entries.length > 1 && nextEntryStartTime != null && currentEntryEndTime.isAfter(nextEntryStartTime);
      final hasOverlap = overlapsWithPrevious || overlapsWithNext;
      if (hasOverlap) {
        invalidNodes.add(true);
      }
    });
    return invalidNodes.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    widget.entries.sortByTime();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool newValidity = calculateValidity();
      if (isValid != newValidity) {
        setState(() {
          isValid = newValidity;
        });
        widget.onValidityChanged(isValid);
      }
    });
    return ListView.builder(
      itemCount: widget.entries.length,
      itemBuilder: (context, index) {
        final currentEntry = widget.entries[index];
        final currentEntryStartTime = DateTime.now().apply(currentEntry.time);
        final currentEntryEndTime = currentEntryStartTime.add(currentEntry.duration);

        final previousEntry = index == 0 ? null : widget.entries[index - 1];
        final previousEntryStartTime = previousEntry == null ? null : DateTime.now().apply(previousEntry.time);
        final previousEntryEndTime = previousEntryStartTime?.add(previousEntry!.duration);

        final nextEntry = index == widget.entries.length - 1 ? null : widget.entries[index + 1];
        final nextEntryStartTime = nextEntry == null ? null : DateTime.now().apply(nextEntry.time);

        final beginsAtPreviousEnd = widget.entries.length > 1 &&
            previousEntryEndTime != null &&
            currentEntryStartTime.isAtSameMomentAs(previousEntryEndTime);

        final endsAtNextStart = widget.entries.length > 1 &&
            nextEntryStartTime != null &&
            currentEntryEndTime.isAtSameMomentAs(nextEntryStartTime);

        final overlapsWithPrevious = widget.entries.length > 1 &&
            previousEntryEndTime != null &&
            currentEntryStartTime.isBefore(previousEntryEndTime);

        final overlapsWithNext =
            widget.entries.length > 1 && nextEntryStartTime != null && currentEntryEndTime.isAfter(nextEntryStartTime);

        final hasOverlap = overlapsWithPrevious || overlapsWithNext;

        NodeType nodeType;
        if (hasOverlap) {
          nodeType = NodeType.overlap;
        } else if (index == 0) {
          if (endsAtNextStart) {
            nodeType = NodeType.jointWithBottom;
          } else {
            nodeType = NodeType.solo;
          }
        } else if (index == widget.entries.length - 1) {
          if (beginsAtPreviousEnd) {
            nodeType = NodeType.jointWithTop;
          } else {
            nodeType = NodeType.solo;
          }
        } else if (endsAtNextStart && beginsAtPreviousEnd) {
          nodeType = NodeType.surrounded;
        } else if (endsAtNextStart) {
          nodeType = NodeType.jointWithBottom;
        } else if (beginsAtPreviousEnd) {
          nodeType = NodeType.jointWithTop;
        } else {
          nodeType = NodeType.solo;
        }

        final DashLocation location;
        final Color color;
        switch (nodeType) {
          case NodeType.overlap:
            color = Theme.of(context).errorColor;
            if (overlapsWithPrevious && overlapsWithNext) {
              location = DashLocation.all;
            } else if (overlapsWithPrevious) {
              location = DashLocation.top;
            } else {
              location = DashLocation.bottom;
            }
            break;
          case NodeType.solo:
            color = Theme.of(context).colorScheme.primary;
            location = DashLocation.none;
            break;
          case NodeType.jointWithTop:
            color = Theme.of(context).colorScheme.secondary;
            location = DashLocation.top;
            break;
          case NodeType.jointWithBottom:
            color = Theme.of(context).colorScheme.primary;
            location = DashLocation.bottom;
            break;
          case NodeType.surrounded:
            color = Theme.of(context).colorScheme.secondary;
            location = DashLocation.all;
            break;
        }
        return ColoredBox(
          color: index.isEven
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    currentEntry.time.format(context),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: index.isEven
                              ? Theme.of(context).colorScheme.onSecondaryContainer
                              : Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DashedVerticalLine(
                        color: hasOverlap ? Theme.of(context).errorColor : Theme.of(context).dividerColor,
                        width: 1.5,
                        location: location,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.onNodeTapped(currentEntry.id);
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
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          widget.buildTitle(currentEntry.id),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: index.isEven
                                    ? Theme.of(context).colorScheme.onSecondaryContainer
                                    : Theme.of(context).colorScheme.onTertiaryContainer,
                              ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Slider(
                              value: currentEntry.duration.inMinutes.toDouble(),
                              onChangeEnd: (time) => widget.onEntryDurationChanged(
                                currentEntry.id,
                                time,
                              ),
                              onChanged: (time) => widget.onEntryDurationChanged(
                                currentEntry.id,
                                time,
                              ),
                              min: 1,
                              max: 60,
                            ),
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
