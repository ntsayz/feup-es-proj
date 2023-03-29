import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String text;
  final double height, width;
  final onItemTapped;
  const YellowButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(80,40,80,80),
      child: Card(
        child: SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            onPressed: onItemTapped,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF6B95D),
              foregroundColor: Colors.white,
            ),
            child:Text(
              text,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top:false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6B95D),
          title: Text(title),
        ),
      ),
    );
  }
}







