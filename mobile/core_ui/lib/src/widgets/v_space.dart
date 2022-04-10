import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  const VSpace({
    Key? key,
    required this.spacing,
  }) : super(key: key);

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacing,
    );
  }
}
