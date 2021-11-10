import 'package:flutter/material.dart';

class CircleBackground extends StatelessWidget {
  const CircleBackground({
    Key? key,
    required Widget child,
  })  : _child = child,
        super(key: key);

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.tight(const Size(42, 42)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).accentColor,
        ),
        child: _child,
      ),
    );
  }
}
