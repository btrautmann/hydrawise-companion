import 'package:flutter/material.dart';

class AppLifecycleStateObserver extends StatefulWidget {
  const AppLifecycleStateObserver({
    Key? key,
    required this.child,
    this.onBackground,
    this.onForeground,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onBackground;
  final VoidCallback? onForeground;

  @override
  State<AppLifecycleStateObserver> createState() =>
      _AppLifecycleStateObserverState();
}

class _AppLifecycleStateObserverState extends State<AppLifecycleStateObserver>
    with
        // ignore: prefer_mixin
        WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.onForeground?.call();
        break;
      case AppLifecycleState.inactive:
        // Ignore this case for now
        break;
      case AppLifecycleState.paused:
        widget.onBackground?.call();
        break;
      case AppLifecycleState.detached:
        // Ignore this case for now
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
