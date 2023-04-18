import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatGroupCards extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;

  ChatGroupCards({Key? key,required this.dataList}) : super(key: key);

  @override
  State<ChatGroupCards> createState() => _ChatGroupCardsState();

  List<Map<String, dynamic>> dataList1 =  [
    {
      "id":"59XDKIoWQ1E24rxUaREv",
      "name": "Grupo de Futebol",
      "participants": {"alice123","tiago5","joao2001","dthedestroyer"},
      "capacity": 12,
      "messages":{
        "sender":"ntsaz",
        "content":"hey what's up",
        "time":"2023-04-12-22:25:28"
      },}
    ,{
      "id":"50AELHoVN0C23qyTbSDu",
      "name": "Grupo de Andebol",
      "participants": {"alice123","tiago5","guilherme"},
      "capacity": 4,
      "messages":{
        "sender":"guilherme",
        "content":"cheguei",
        "time":"2023-04-12-22:25:28"
      },
    },{
      "id":"70ZELJpXN3F27syWcSFw",
      "name": "Corrida",
      "participants": {"alice123","tiago5"},
      "capacity": 3,
      "messages":{
        "sender":"alice123",
        "content":"olá,tudo bem?",
        "time":"2023-04-12-22:25:28"
      },
    },{
      "id":"61YFLJoYR2F25syVcSEx",
      "name": "Ténis na Prelada",
      "participants": {"alice123","tiago5","joao2001","dthedestroyer"},
      "capacity": 6,
      "messages":{
        "sender":"ntsaz",
        "content":"hey what's up",
        "time":"2023-04-12-22:25:28"
      },
    },{
      "id":"71ZFMKpYQ4G28tzXdTGz",
      "name": "Karting Matosinhos",
      "participants": {"alice123","tiago5","joao2001",},
      "capacity": 8,
      "messages":{{
        "sender":"tiago5",
        "content":"hey what's up",
        "time":"2023-04-12-22:25:28"
      }},
    }
  ];
}

class _ChatGroupCardsState extends State<ChatGroupCards> {
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

  List<Map<String, dynamic>>dataList =  [
    {
      "id":"59XDKIoWQ1E24rxUaREv",
      "name": "Grupo de Futebol",
      "participants": {"alice123","tiago5","joao2001","dthedestroyer"},
      "capacity": 12,
      "messages": [
        {
          "sender":"ntsaz",
          "content":"hey what's up",
          "time":"2023-04-12-22:25:28"
        },
        {
          "sender":"tiago5",
          "content":"not much, how about you?",
          "time":"2023-04-12-22:26:30"
        }
      ],}
    ,{
      "id":"50AELHoVN0C23qyTbSDu",
      "name": "Grupo de Andebol",
      "participants": {"alice123","tiago5","guilherme"},
      "capacity": 4,
      "messages": [
        {
          "sender":"guilherme",
          "content":"hey what's up",
          "time":"2023-04-12-22:25:28"
        },
        {
          "sender":"tiago5",
          "content":"not much, how about you?",
          "time":"2023-04-12-22:26:30"
        }
      ],
    },{
      "id":"70ZELJpXN3F27syWcSFw",
      "name": "Corrida",
      "participants": {"alice123","tiago5"},
      "capacity": 3,
      "messages": [
        {
          "sender":"ntsaz",
          "content":"hey what's up",
          "time":"2023-04-12-22:25:28"
        },
        {
          "sender":"tiago5",
          "content":"not much, how about you?",
          "time":"2023-04-12-22:26:30"
        }
      ],
    },{
      "id":"61YFLJoYR2F25syVcSEx",
      "name": "Ténis na Prelada",
      "participants": {"alice123","tiago5","joao2001","dthedestroyer"},
      "capacity": 6,
      "messages": [
        {
          "sender":"ntsaz",
          "content":"hey what's up",
          "time":"2023-04-12-22:25:28"
        },
        {
          "sender":"tiago5",
          "content":"not much, how about you?",
          "time":"2023-04-12-22:26:30"
        }
      ],
    },{
      "id":"71ZFMKpYQ4G28tzXdTGz",
      "name": "Karting Matosinhos",
      "participants": {"alice123","tiago5","joao2001",},
      "capacity": 8,
      "messages": [
        {
          "sender":"ntsaz",
          "content":"hey what's up",
          "time":"2023-04-12-22:25:28"
        },
        {
          "sender":"tiago5",
          "content":"not much, how about you?",
          "time":"2023-04-12-22:26:30"
        }
      ],
    }
  ];

  String _getImageUrl() {
    // You can add a conditional statement here to determine which image URL to use.
    int randomIndex = Random().nextInt(sportsCards.length);
    return sportsCards[randomIndex];
  }

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
            itemCount: widget.dataList1.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 6, 5),
                child: ChatGroupCard(
                  groupId: widget.dataList1[index]['id'],
                  name: widget.dataList1[index]['name'],
                  imageUrl: _getImageUrl(),
                  lastMessage: "mock",//widget.dataList1[index]['messages']['content'],
                  lastMessageSender:"data", //widget.dataList1[index]['messages']['sender'],
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
  final String groupId;
  final String name;
  final String imageUrl;
  final String lastMessage;
  final String lastMessageSender;

  ChatGroupCard({
    Key? key,
    required this.groupId,
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastMessageSender,
  }) : super(key: key);

  @override
  _ChatGroupCardState createState() => _ChatGroupCardState();
}

class _ChatGroupCardState extends State<ChatGroupCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChatScreen(groupId: widget.groupId),
          ),
        );
      },
      child: Card(
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
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 15.0,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.0),
                        Text("${widget.lastMessageSender}: ${widget.lastMessage}",
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
      ),
    );
  }
}


class GroupChatScreen extends StatefulWidget {
  final String groupId;

  GroupChatScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: streamMessagesInGroup(widget.groupId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final message = snapshot.data!.docs[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(message['senderUsername'][0]),
                        ),
                        title: Text(message['senderUsername']),
                        subtitle: Text(message['content']),
                        trailing: Text(message['time'].toDate().toString()),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String content = _messageController.text.trim();
                    if (content.isNotEmpty) {
                      // Replace 'userId' and 'username' with the actual sender's UID and username.
                      await sendMessageToGroup(
                        groupId: widget.groupId,
                        senderUid: 'userId',
                        senderUsername: 'username',
                        content: content,
                      );
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Stream<QuerySnapshot> streamMessagesInGroup(String groupId) {
  return FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .collection('messages')
      .orderBy('time', descending: false)
      .snapshots();
}


Future<void> sendMessageToGroup({
  required String groupId,
  required String senderUid,
  required String senderUsername,
  required String content,
}) {
  return FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .collection('messages')
      .add({
    'senderUid': senderUid,
    'senderUsername': senderUsername,
    'content': content,
    'time': DateTime.now(),
  });
}


