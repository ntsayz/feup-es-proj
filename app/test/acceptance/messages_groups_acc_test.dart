import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trabalho/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Messaging Test', () {
    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets("Messaging test", (WidgetTester tester) async {
      // Start the app
      await tester.pumpWidget(MyApp());

      // Assuming the user is already logged in, navigate to MessagesScreen
      // ...insert navigation code here...

      // Find the TextField to enter a message
      final Finder messageField = find.byKey(Key('message_field'));

      // Enter a message
      await tester.enterText(messageField, 'Test message');

      // Tap the send button
      final Finder sendButton = find.byKey(Key('send_button'));
      await tester.tap(sendButton);

      // Let the message sending process complete and redraw the UI
      await tester.pumpAndSettle();

      // Verify the message appears in the chat
      expect(find.text('Test message'), findsOneWidget);
    });
  });
}
