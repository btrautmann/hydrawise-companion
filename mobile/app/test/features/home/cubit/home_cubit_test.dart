import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/home/home.dart';

void main() {
  group('HomeCubit', () {
    HomeCubit _buildSubject() {
      return HomeCubit();
    }

    group('init', () {
      test('default tab is 0', () {
        final cubit = _buildSubject();
        expect(cubit.state.selectedTabIndex, 0);
      });
    });

    group('selectTab', () {
      blocTest<HomeCubit, HomeState>(
        'it emits the newly selected tab',
        build: _buildSubject,
        act: (cubit) => cubit.selectTab(1),
        expect: () => <HomeState>[HomeState(selectedTabIndex: 1)],
      );
    });
  });
}
