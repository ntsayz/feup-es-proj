import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trabalho/screens/components/BottomNavigation.dart';


void main() {
  testWidgets('BottomNavigation - Initial Selected Index', (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: BottomNavigation(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            selectedIndex = index;
          },
        ),
      ),
    );

    final bottomNavigationBarFinder = find.byType(BottomNavigationBar);
    final bottomNavigationBar = tester.widget<BottomNavigationBar>(bottomNavigationBarFinder);

    expect(bottomNavigationBar.currentIndex, equals(selectedIndex));
  });

}
