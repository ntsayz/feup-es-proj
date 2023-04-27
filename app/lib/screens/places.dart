import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'place_card.dart';
import 'dart:math';

class PlacesScreen extends StatelessWidget {
  final String uid;
  final dynamic userData;

  const PlacesScreen({Key? key, required this.uid, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        backgroundColor: const Color(0xFFF6B95D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          PlaceCard(
            uid: uid,
            userData: userData,
            imagePath: 'assets/images/places/fitnessup.jpg',
            text: 'FitnessUp São João',
            likesCount: Random().nextInt(100),
          ),
          PlaceCard(
            uid: uid,
            userData: userData,
            imagePath: 'assets/images/places/padel.jpg',
            text: 'Complexo de Padel de Ermesinde',
            likesCount: Random().nextInt(100),
          ),
          PlaceCard(
            uid: uid,
            userData: userData,
            imagePath: 'assets/images/places/piscina.jpg',
            text: 'Piscinas Municipais de Barcelos',
            likesCount: Random().nextInt(100),
          ),
          // add more PlaceCards as needed
        ],
      ),
    );
  }
}




        