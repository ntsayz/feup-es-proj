import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/screens/components/Header.dart';
import 'package:trabalho/screens/components/Search_bar.dart';
import 'package:trabalho/screens/components/widgets.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/profile_screen.dart';
import 'package:trabalho/screens/components/ChatGroupCards.dart';

class MessagesScreen extends StatefulWidget {
  final String uid;
  Map<String, dynamic>? userData;
  late List<Map<String, dynamic>> dataList;
  MessagesScreen({Key? key, required this.uid, required this.userData, required this.dataList}) : super(key: key);

  List<Map<String, dynamic>> dataListsMock = [
    {
      "name": "Alice",
      "age": 30,
    },{
      "name": "Alice",
      "age": 30,
    },{
      "name": "Alice",
      "age": 30,
    },{
      "name": "Alice",
      "age": 30,
    },{
      "name": "Alice",
      "age": 30,
    }
  ];


  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  late String _username = "";

  @override
  void initState() {
    super.initState();
    if (widget.userData != null) {
      setState(() {
        _username = widget.userData!["Username"];

      });

    }
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');  // Exit the application
        return false; // DO NOT ALLOW THE USER TO GO BACK TO THE PREVIOUS PAGE (LOGIN-REGISTRATION)
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6B95D),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Messages"),
        ),
        body: SafeArea(
          top: true,
          child: ListView(
            shrinkWrap: false,
            children: [
              Search_bar(search_title: 'Search messages',),
              ChatGroupCards(dataList: widget.dataListsMock),
            ],
          ),
        ),
      ),
    );
  }


  void Profile(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen(uid:widget.uid,userData: widget.userData,)));
  }
  void Messages(BuildContext context){
    Navigator.pop(context);
  }


}