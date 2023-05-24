import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trabalho/screens/place_card.dart';

void main() {
  testWidgets('PlaceCard - Initial Likes and Dislikes Count', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlaceCard(
          uid: '123',
          userData: {},
          imagePath: 'assets/images/card/football.jpg',
          text: 'Some text',
          likesCount: 5,
          initialDislikesCount: 2,
        ),
      ),
    );

    expect(find.text('Likes: 5'), findsOneWidget);
    expect(find.text('Dislikes: 2'), findsOneWidget);
  });

  testWidgets('PlaceCard - Increment Likes Count', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlaceCard(
          uid: '123',
          userData: {},
          imagePath: 'assets/images/card/football.jpg',
          text: 'Some text',
        ),
      ),
    );

    expect(find.text('Likes: 0'), findsOneWidget);
    expect(find.text('Dislikes: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.thumb_up));
    await tester.pump();

    expect(find.text('Likes: 1'), findsOneWidget);
    expect(find.text('Dislikes: 0'), findsOneWidget);
  });

  testWidgets('PlaceCard - Increment Dislikes Count', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlaceCard(
          uid: '123',
          userData: {},
          imagePath: 'assets/images/card/football.jpg',
          text: 'Some text',
        ),
      ),
    );

    expect(find.text('Likes: 0'), findsOneWidget);
    expect(find.text('Dislikes: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.thumb_down));
    await tester.pump();

    expect(find.text('Likes: 0'), findsOneWidget);
    expect(find.text('Dislikes: 1'), findsOneWidget);
  });

  testWidgets('PlaceCard - Toggle Likes and Dislikes Count', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlaceCard(
          uid: '123',
          userData: {},
          imagePath: 'assets/images/card/football.jpg',
          text: 'Some text',
        ),
      ),
    );

    expect(find.text('Likes: 0'), findsOneWidget);
    expect(find.text('Dislikes: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.thumb_up));
    await tester.pump();

    expect(find.text('Likes: 1'), findsOneWidget);
    expect(find.text('Dislikes: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.thumb_down));
    await tester.pump();

    expect(find.text('Likes: 0'), findsOneWidget);
    expect(find.text('Dislikes: 1'), findsOneWidget);
  });


}
