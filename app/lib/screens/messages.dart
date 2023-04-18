import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/screens/components/Search_bar.dart';
import 'package:trabalho/screens/profile_screen.dart';
import 'package:trabalho/screens/components/ChatGroupCards.dart';

import '../backend/Groups.dart';

class MessagesScreen extends StatefulWidget {
  User user;
  Map<String, dynamic>? userData;
  MessagesScreen({Key? key, required this.user,required this.userData}) : super(key: key);

  List<Map<String, dynamic>> userGroups = [];

  List<Map<String, dynamic>> messages = [];




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
      getMessagesData();

    }
  }

  void getMessagesData() async {
    List<String> userGroupIds = await getUIDGroups(widget.user.uid);
    List<Map<String, dynamic>> fetchedGroups = [];

    for (String groupId in userGroupIds) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('groups').doc(groupId).get();
      if (snapshot.exists) {
        Map<String, dynamic> groupData = snapshot.data() as Map<String, dynamic>;
        groupData['groupId'] = groupId; // Add groupId to the group data
        fetchedGroups.add(groupData);
      }
    }

    setState(() {
      widget.userGroups = fetchedGroups;
    });
  }

  void fetchGroupMessagesExample() async {

    widget.userGroups.forEach((group) async {
      widget.messages =   await getGroupMessages(group['groupId']);
      widget.messages.forEach((message) {
        print(message);
      });
    });
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
              ChatGroupCards(dataList: widget.userGroups,user: widget.user,userData: widget.userData,),
            ],
          ),
        ),
      ),
    );
  }


  void Profile(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen(uid:widget.user.uid,userData: widget.userData,)));
  }
  void Messages(BuildContext context){
    Navigator.pop(context);
  }


}


