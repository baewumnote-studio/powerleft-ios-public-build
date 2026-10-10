import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../test/support/preferences_test_support.dart';
import '../test/support/first_run_smoke_flow.dart';

import 'package:powerleft/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // SharedPreferencesWithCache uses the async platform backend.
    setInitialPreferences(<String, Object>{});
  });

  testWidgets(
    'first-run smoke: onboarding -> runtime -> result -> battery-needed -> result',
    (tester) async {
      await runFirstRunSmoke(tester, app.main);
    },
  );
}
