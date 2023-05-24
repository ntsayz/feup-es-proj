import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/screens/components/EventCards.dart';


void main() {
  testWidgets('Should increment occupancy when selected', (WidgetTester tester) async {
    final EventCard eventCard = EventCard(
      title: 'Test Event',
      imageUrl: 'assets/images/card/football.jpg',
      capacity: 5,
      occupancy: 2,
    );

    await tester.pumpWidget(MaterialApp(home: eventCard));

    final finder = find.byIcon(Icons.done);
    expect(finder, findsOneWidget);

    await tester.tap(finder);
    await tester.pump();

    expect(eventCard.occupancy, 3);
  });


  testWidgets('Should decrement occupancy when deselected', (WidgetTester tester) async {
    final EventCard eventCard = EventCard(
      title: 'Test Event',
      imageUrl: 'assets/images/card/football.jpg',
      capacity: 5,
      occupancy: 3,
    );

    await tester.pumpWidget(MaterialApp(home: eventCard));

    final finder = find.byIcon(Icons.done);
    expect(finder, findsOneWidget);

    await tester.tap(finder);
    await tester.pump();

    expect(eventCard.occupancy, 4);

    await tester.tap(finder);
    await tester.pump();

    expect(eventCard.occupancy, 3);

  });
}
