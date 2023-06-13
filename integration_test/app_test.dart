import 'package:cash_flow_facts/presentation/config/navigation/global_nav.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cash_flow_facts/main.dart' as app;

late GlobalNav globalNav;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<Widget> createWidgetUnderTest(bool initialise) async {
    globalNav = GlobalNav();
    if (initialise) await globalNav.init();
    return const app.MyApp();
  }

  group(
    'abc',
    () {
      testWidgets('description', (tester) async {
        await tester.pumpWidget(await createWidgetUnderTest(true));
        // Wait if during the test development
        await Future.delayed(const Duration(seconds: 3));
      });
    },
  );
}
