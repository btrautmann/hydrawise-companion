import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrawise/features/customer_details/cubit/customer_details_cubit.dart';
import 'package:hydrawise/features/customer_details/cubit/customer_details_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(brandon): Should we break out auth state into its own
    // bloc and make it explicit?
    return BlocListener<CustomerDetailsCubit, CustomerDetailsState>(
      listener: (context, state) {
        state.when(
          loading: () {},
          empty: () => GoRouter.of(context).go('/login'),
          complete: (_, __) => GoRouter.of(context).go('/home'),
        );
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
