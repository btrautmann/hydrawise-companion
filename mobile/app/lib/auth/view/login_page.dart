import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/auth/log_in/log_in.dart';
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _IrriName(),
              _ApiKeyInput(),
            ],
          ),
        ),
      ),
    );
  }
}

class _IrriName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Irri',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class _ApiKeyInput extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final controllerUpdates = useValueListenable(controller);
    ref.listen<AsyncValue<Object?>>(
      logInControllerProvider,
      (_, state) => state.whenOrNull(
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
        data: (isSuccessful) {
          if (isSuccessful != null && isSuccessful == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid API key')),
            );
          }
        },
      ),
    );
    final isLoading = ref.watch(logInControllerProvider).isLoading;
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
              suffixIcon: IconButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return const AboutApiKeyDialog();
                    },
                  );
                },
                icon: const Icon(Icons.question_mark),
                iconSize: 18,
              ),
              hintText: 'Hydrawise API key',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          const VSpace(spacing: 16),
          HStretch(
            child: OutlinedButton(
              onPressed: isLoading || controllerUpdates.text.isEmpty
                  ? null
                  : () {
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

class AboutApiKeyDialog extends StatelessWidget {
  const AboutApiKeyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.info,
            size: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'About API keys',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
      content: Text(
        'API keys are codes used to identify and authenticate a user. '
        'We use your API key to talk to the Hydrawise application on your behalf. '
        'We never use it for any other reason. You can find yours by logging '
        'into your Hydrawise account and navigating to Account Details.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
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
