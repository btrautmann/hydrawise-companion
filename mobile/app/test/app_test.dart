import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irri/app/domain/app_domain_factory.dart';
import 'package:irri/app/domain/build_router.dart';
import 'package:irri/app/irri_app.dart';
import 'package:irri/customer_details/customer_details.dart';
import 'package:irri/splash_page.dart';

void main() {
  group('App', () {
    testWidgets(
      'renders SplashPage',
      (tester) async {
        final repository = InMemoryCustomerDetailsRepository();
        final router = await BuildAppRouter().call();

        final providers = DevelopmentDependencyFactory.build(
          dataStorage: InMemoryStorage(),
          repository: repository,
        );

        await tester.pumpWidget(
          IrriApp(
            router: router,
            providers: providers,
          ),
        );
        expect(find.byType(SplashPage), findsOneWidget);
      },
      skip: true,
    );
  });
}
