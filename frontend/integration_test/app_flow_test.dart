import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:frontend/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-end login flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify we are on login screen
    expect(find.text('ATHLEX'), findsWidgets);
    expect(find.text('Log In'), findsWidgets);
  });
}
