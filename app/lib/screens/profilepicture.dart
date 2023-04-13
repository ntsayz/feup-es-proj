import 'package:flutter/material.dart';


class D8ddzukxuaaxldy1Widget extends StatefulWidget {
  @override
  _D8ddzukxuaaxldy1WidgetState createState() => _D8ddzukxuaaxldy1WidgetState();
}

class _D8ddzukxuaaxldy1WidgetState extends State<D8ddzukxuaaxldy1Widget> {
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
          'assets/images/card/profilepicture.png',
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}



