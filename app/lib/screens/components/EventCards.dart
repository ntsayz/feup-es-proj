import 'package:flutter/material.dart';
import 'dart:math';

class EventCards extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;

  EventCards({Key? key, required this.dataList}) : super(key: key);

  @override
  State<EventCards> createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {
  final List<String> sportsCards = [
    'assets/images/card/football.jpg',
    'assets/images/card/basketball.jpg',
    'assets/images/card/futsal.jpg',
    'assets/images/card/handball.jpg',
    'assets/images/card/karting.jpg',
    'assets/images/card/running.jpg',
    'assets/images/card/swimming.jpg',
    'assets/images/card/tennis.jpg',
    'assets/images/card/volleyball.jpg',
    'assets/images/card/athletics.jpg'
  ];

  String _getImageUrl() {
    // You can add a conditional statement here to determine which image URL to use.
    int randomIndex = Random().nextInt(sportsCards.length);
    return sportsCards[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF6B95D),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 20, 6, 20),
                child: EventCard(
                  title: widget.dataList[index]['name'],
                  imageUrl: _getImageUrl(),
                  occupancy: widget.dataList[index]['participants'].length,
                  capacity: widget.dataList[index]['capacity'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}





class EventCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int capacity;
  int occupancy;


  EventCard({Key? key, required this.title,
    required this.imageUrl,required this.capacity, required this.occupancy}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isSelected = false;
  int occ = 6;
  final int cap = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelected = !_isSelected;
                    if (_isSelected) {
                      widget.occupancy++;
                    } else {
                      widget.occupancy--;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isSelected ? Colors.green : Colors.black38,
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Text(
                "${widget.occupancy}/${widget.capacity}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 40,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}