import 'package:flutter/material.dart';

class ChatGroupCards extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;

  ChatGroupCards({Key? key,required this.dataList}) : super(key: key);

  @override
  State<ChatGroupCards> createState() => _ChatGroupCardsState();
}

class _ChatGroupCardsState extends State<ChatGroupCards> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF6B95D),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: SizedBox(
          height: 650,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 6, 5),
                child: ChatGroupCard(
                  name: "Grupo de Futebol",
                  imageUrl: "assets/images/card/tennis.jpg",
                  lastMessage: "Tiago: This is just mock data",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



class ChatGroupCard extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String lastMessage;

  ChatGroupCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
  }) : super(key: key);

  @override
  _ChatGroupCardState createState() => _ChatGroupCardState();
}

class _ChatGroupCardState extends State<ChatGroupCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.imageUrl),
              radius: 35.0,
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ), SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 15.0,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5.0),
                      Text(widget.lastMessage,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}