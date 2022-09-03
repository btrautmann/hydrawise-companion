import 'package:flutter/material.dart';

class CircleBackground extends StatelessWidget {
  const CircleBackground({
    Key? key,
    Color? color,
    required Widget child,
  })  : _child = child,
        _color = color,
        super(key: key);

  final Widget _child;
  final Color? _color;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.tight(const Size(42, 42)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _color ?? Theme.of(context).colorScheme.secondary,
        ),
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            child: _child,
          ),
        ),
      ),
    );
  }
}
