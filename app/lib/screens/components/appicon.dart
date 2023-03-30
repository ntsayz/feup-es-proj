import 'package:flutter/material.dart';

class appiconWidget extends StatefulWidget {
  @override
  _appiconWidgetState createState() => _appiconWidgetState();
}

class _appiconWidgetState extends State<appiconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/icons/icon.png',
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}