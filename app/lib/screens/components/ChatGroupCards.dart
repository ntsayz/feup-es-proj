import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho/backend/Groups.dart';

class ChatGroupCards extends StatefulWidget {
  User user;
  final List<Map<String, dynamic>> dataList;
  Map<String, dynamic>? userData;

  ChatGroupCards({Key? key,required this.dataList,required  this.user, required this.userData}) : super(key: key);

  @override
  State<ChatGroupCards> createState() => _ChatGroupCardsState();
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
            itemCount: widget.dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 6, 5),
                child: ChatGroupCard(
                  userID: widget.user.uid,
                  username: widget.userData!['Username'],
                  groupId: widget.dataList[index]['groupId'],
                  name: widget.dataList[index]['Group Name'],
                  imageUrl: _getImageUrl(),
                  lastMessage: "be fixed soon",//widget.dataList1[index]['messages']['content'],
                  lastMessageSender:"This will", //widget.dataList1[index]['messages']['sender'],
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
  final String username;
  final String imageUrl;
  final String lastMessage;
  final String lastMessageSender;

  final String userID;

  ChatGroupCard({
    Key? key,
    required this.userID,
    required this.username,
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
            builder: (context) => GroupChatScreen(groupId: widget.groupId,username: widget.username,userID: widget.userID,),
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
  final String username;

  final String userID;


  GroupChatScreen({Key? key, required this.groupId, required this.username,required this.userID}) : super(key: key);

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController _messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getGroupName(widget.groupId),
      builder: (context, AsyncSnapshot<String?> snapshot) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFFF6B95D),
            title: Text(snapshot.data?.toUpperCase() ?? ''),
            // Use the null-aware operator '?.' to avoid accessing a null value.
            // If snapshot.data is null, use an empty string instead.
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
                      return  ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final message = snapshot.data!.docs[index];
                          final isCurrentUser = message['senderUsername'] == widget.username;
                          return Container(
                            alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isCurrentUser ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(isCurrentUser ? 10 : 0),
                                  topRight: Radius.circular(isCurrentUser ? 0 : 10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message['senderUsername'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isCurrentUser ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    message['content'],
                                    style: TextStyle(
                                      color: isCurrentUser ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    DateFormat.jm().add_Md().format(message['time'].toDate()),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isCurrentUser ? Colors.white54 : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 30),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        key: Key('message_field'),
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
                      key: Key('send_button'),
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        String content = _messageController.text.trim();
                        if (content.isNotEmpty) {
                          // Replace 'userId' and 'username' with the actual sender's UID and username.
                          await sendMessageToGroup(
                            groupId: widget.groupId,
                            senderUid: widget.userID,
                            senderUsername: widget.username,
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


