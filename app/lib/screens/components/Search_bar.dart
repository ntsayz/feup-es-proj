import 'package:flutter/material.dart';

class Search_bar extends StatelessWidget {
  final String search_title;
  const Search_bar({super.key, required this.search_title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFF1F5F4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children:[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search,color:Color(0xFFA0A0A0)),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: search_title,
                  border:InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}