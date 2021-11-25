import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrawise/features/configuration/configuration.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/home/home.dart';
import 'package:hydrawise/features/programs/programs.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required int selectedTabIndex})
      : _selectedTabIndex = selectedTabIndex,
        super(key: key);

  final int _selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit()..selectTab(_selectedTabIndex),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (_, state) {
        // When a new tab is selected, navigate to it via the router
        // which better support deep-linking and URL changing on web
        GoRouter.of(context).go('/home/${state.selectedTabIndex}');
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle),
                activeIcon: Icon(Icons.play_circle_filled),
                label: 'Programs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                activeIcon: Icon(Icons.settings),
                label: 'Configuration',
              )
            ],
            currentIndex: state.selectedTabIndex,
            onTap: (index) => context.read<HomeCubit>().selectTab(index),
          ),
          body: HomeBody(
            selectedTabIndex: state.selectedTabIndex,
          ),
        );
      },
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    required int selectedTabIndex,
  })  : _selectedTabIndex = selectedTabIndex,
        super(key: key);

  final int _selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    switch (_selectedTabIndex) {
      case 0:
        return const CustomerDetailsPage();
      case 1:
        return const ProgramsPage();
      case 2:
        return const ConfigurationPage();
      default:
        return const CustomerDetailsPage();
    }
  }
}
