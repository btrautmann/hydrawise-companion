import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irri/configuration/configuration.dart';
import 'package:irri/customer/customer.dart';
import 'package:irri/home/home.dart';
import 'package:irri/programs/programs.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required int selectedTabIndex})
      : _selectedTabIndex = selectedTabIndex,
        super(key: key);

  // ignore: unused_field
  final int _selectedTabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const HomeView();
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<HomeState>(homeStateProvider, (previous, next) {
      // When a new tab is selected, navigate to it via the router
      // which better support deep-linking and URL changing on web
      GoRouter.of(context).go('/home/${next.selectedTabIndex}');
    });
    final homeState = ref.watch(homeStateProvider);
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
        currentIndex: homeState.selectedTabIndex,
        onTap: (index) => ref.read(homeStateProvider.notifier).selectTab(index),
      ),
      body: HomeBody(
        selectedTabIndex: homeState.selectedTabIndex,
      ),
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
        return const CustomerDashboardPage();
      case 1:
        return const ProgramsPage();
      case 2:
        return const ConfigurationPage();
      default:
        return const CustomerDashboardPage();
    }
  }
}
