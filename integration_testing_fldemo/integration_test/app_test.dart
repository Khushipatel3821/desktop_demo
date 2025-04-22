import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing_fldemo/main.dart' as app;
import 'package:integration_testing_fldemo/screens/home_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    "End to end test",
    () {
      Future<void> performLogin(
        WidgetTester tester, {
        required String username,
        required String password,
      }) async {
        app.main();
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(Key("username_controller")), username);
        await tester.enterText(find.byType(TextField).at(1), password);
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
      }

      testWidgets(
        "Verify Login Screen with correct Username and Password",
        (tester) async {
          await performLogin(tester,
              username: "username", password: "password");
          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );

      Future.delayed(Duration(seconds: 2));

      testWidgets(
        "Verify Login Screen with incorrect Username and Password",
        (tester) async {
          await performLogin(tester, username: "khs123", password: "123");
          expect(find.text("Error"), findsOneWidget);
        },
      );
    },
  );
}
