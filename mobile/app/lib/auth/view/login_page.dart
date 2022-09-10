import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:irri/auth/auth.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

/// Page for the user to enter their API key
/// and gain access to the rest of the application
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ApiKeyInput(),
            _Info(),
          ],
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
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              hintText: 'Enter your Hydrawise API key',
            ),
          ),
          const VSpace(spacing: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(logInControllerProvider.notifier).logIn(apiKey: controller.text);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 200,
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: const [
                    Tab(text: 'What is it?'),
                    Tab(text: 'Is this safe?'),
                  ],
                  indicator: DotIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    distanceFromCenter: 16,
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Opacity(
                        opacity: .5,
                        child: Text(
                          'Your API key is a string provided '
                          'to you by Hydrawise that allows us '
                          'to communicate with your irrigation '
                          'system on your behalf. You can retrieve '
                          'yours by logging into your Hydrawise '
                          'account and navigating to Account Details',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Opacity(
                        opacity: .5,
                        child: Text(
                          'Your API key is only used to communicate '
                          'with Hydrawise, and never leaves our servers '
                          'for any other reason. At any time, you can '
                          'delete your account data, including the API key.',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
