import 'package:flutter/material.dart';

class appiconWidget extends StatefulWidget {
  @override
  _appiconWidgetState createState() => _appiconWidgetState();
}

class _appiconWidgetState extends State<appiconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/icons/icon.png',
          width: 55,
          height: 55,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}