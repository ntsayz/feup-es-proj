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





class EventCards extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;

  EventCards({Key? key,required this.dataList}) : super(key: key);

  @override
  State<EventCards> createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {
  final List<String> sportsCards = ['assets/images/card/football.jpg',];


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
                  imageUrl: "assets/images/card/football.jpg",
                  occupancy:  widget.dataList[index]['participants'].length,
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