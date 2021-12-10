import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:red_peetoze/ui/app.dart';
import 'package:red_peetoze/ui/pages/authentication/login/login_screen.dart';
import 'package:red_peetoze/main.dart';

void main() {
  group('Encontrar widgets', () {
    testWidgets('Buscar widgets', (WidgetTester tester) async {
      await tester.pumpWidget(App());
      final widget1 = find.byType(Scaffold);
      expect(widget1, findsWidgets);

      final widget2 = find.byType(TextButton);
      expect(widget2, findsOneWidget);

      final widget3 = find.byType(TextFormField);
      expect(widget3, findsWidgets);
    });
  });

  group('Interaccion con widgets', () {
    testWidgets('Check we can type in the textfield',
        (WidgetTester tester) async {
      await tester.pumpWidget(App());
      var password = 'Hacer2345';
      expect(find.text(password), findsNothing);

      await tester.enterText(find.byType(TextFormField), password);
      await tester.pump();

      // Expect to find the item on screen.
      expect(find.text(password), findsOneWidget);
    });
  });
}
