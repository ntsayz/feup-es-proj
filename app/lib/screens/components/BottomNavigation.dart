import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'My teams',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_sharp),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_handball_sharp),
          label: 'Places',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: const Color(0xFFF6B95D),
      unselectedItemColor: const Color(0xFFA0A0A0),
      onTap: widget.onItemTapped,
    );
  }
}
