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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.lightGreen,
            ],
          ),
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: _child,
      ),
    );
  }
}
