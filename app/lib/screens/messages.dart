import 'package:flutter/material.dart';
import 'package:trabalho/screens/components/Header.dart';
import 'package:trabalho/screens/components/Search_bar.dart';
import 'package:trabalho/screens/components/widgets.dart';
import 'package:trabalho/screens/home.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/profile_screen.dart';

class MessagesScreen extends StatefulWidget {
  final String uid;
  Map<String, dynamic>? userData;
  MessagesScreen({Key? key, required this.uid, required this.userData}) : super(key: key);

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
      onWillPop: () async{
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');  // Sai do aplicativo
        return false; // NÃO PERMITE QUE O UTILIZADOR VOLTE PARA A PÁGINA ANTERIOR (LOGIN-REGISTO)\\\\\\\\\\\\\]
      },
      child: Scaffold(
        extendBody: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          top:true,
          child: ListView(
            shrinkWrap: false,
            children: [
              Header(_username, () {
                Profile(context);
              }, (){
                Messages(context);
              }),
              Search_bar(search_title: 'Search messages',),
              YellowButton(text: "HOME", height: 100, width: 100,onItemTapped: (){Messages(context);},),
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