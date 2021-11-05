import 'package:flutter_test/flutter_test.dart';
import 'package:hydrawise/app/domain/app_domain_factory.dart';
import 'package:hydrawise/app/domain/build_router.dart';
import 'package:hydrawise/core/core.dart';
import 'package:hydrawise/app/hydrawise_companion_app.dart';
import 'package:hydrawise/features/customer_details/customer_details.dart';
import 'package:hydrawise/features/splash_page.dart';

void main() {
  group('App', () {
    testWidgets('renders SplashPage', (tester) async {
      final repository = InMemoryCustomerDetailsRepository();
      final router = await BuildStandardRouter().call();

      final providers = DevelopmentDomainFactory.build(
        dataStorage: InMemoryStorage(),
        repository: repository,
      );

      await tester.pumpWidget(App(
        router: router,
        providers: providers,
      ));
      expect(find.byType(SplashPage), findsOneWidget);
    });
  });
}
