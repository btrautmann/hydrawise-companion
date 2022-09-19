import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/auth/auth.dart';
import 'package:simple_animations/simple_animations.dart';

/// Page for the user to enter their API key
/// and gain access to the rest of the application
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Center(
          child: _ApiKeyInput(),
        ),
      ),
    );
  }
}

class _ApiKeyInput extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    ref.listen<AsyncValue<Object?>>(
      logInControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
        data: (success) {
          if (success != null && success == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid API key')),
            );
          }
        },
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            textAlign: TextAlign.left,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(.1),
              suffixIcon: const Icon(Icons.question_mark),
              hintText: 'Hydrawise API key',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          const VSpace(spacing: 16),
          HStretch(
            child: OutlinedButton(
              onPressed: () {
                ref.read(logInControllerProvider.notifier).logIn(apiKey: controller.text);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(1),
                    ),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color1 = MovieTweenProperty<Color>();
    final color2 = MovieTweenProperty<Color>();
    final tween = MovieTween()
      ..tween(
        color1,
        ColorTween(
          begin: Theme.of(context).colorScheme.primary,
          end: Theme.of(context).colorScheme.secondary,
        ),
        duration: const Duration(seconds: 8),
      )
      ..tween(
        color2,
        ColorTween(
          begin: Theme.of(context).colorScheme.onPrimary,
          end: Theme.of(context).colorScheme.onSecondary,
        ),
        duration: const Duration(seconds: 8),
      );

    return MirrorAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      child: child,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                value.get(color1),
                value.get(color2),
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
