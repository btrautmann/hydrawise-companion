import 'package:flutter/material.dart';

enum DashLocation { all, top, bottom, none }

class DashedVerticalLine extends StatelessWidget {
  const DashedVerticalLine({
    Key? key,
    this.width = 1,
    this.color = Colors.red,
    this.location = DashLocation.all,
  }) : super(key: key);
  final double width;
  final Color color;
  final DashLocation location;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final dashWidth = width;
        const dashHeight = 5.0;
        final spaceToFill = constraints.constrainHeight();
        final dashCount = (spaceToFill / (2 * (dashHeight))).floor();
        bool isVisible(int index) {
          switch (location) {
            case DashLocation.all:
              return true;
            case DashLocation.top:
              return index < dashCount / 2;
            case DashLocation.bottom:
              return index > dashCount / 2;
            case DashLocation.none:
              return false;
          }
        }

        return Padding(
          padding: const EdgeInsets.only(top: dashHeight / 2, bottom: dashHeight / 2),
          child: Column(
            children: List.generate(dashCount, (index) {
              return Visibility(
                visible: isVisible(index),
                child: SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color),
                  ),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        );
      },
    );
  }
}
