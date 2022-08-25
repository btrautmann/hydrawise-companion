import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class TimelineBuilder extends StatelessWidget {
  final List<String> startTimes;

  const TimelineBuilder({
    Key? key,
    required this.startTimes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CircleBackground(
          child: Text(
            startTimes[index],
          ),
        );
      },
    );
  }
}
