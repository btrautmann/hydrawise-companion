import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/home/home.dart';
import 'package:irri/programs/programs.dart';

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
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.water),
                label: 'Irrigation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
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
