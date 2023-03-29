import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/screens/profile_screen.dart';
import 'package:trabalho/screens/messages.dart';
import 'package:trabalho/screens/main.dart';
import 'package:trabalho/backend/Groups.dart';

//Common Widgets
import 'package:trabalho/screens/components//Header.dart';
import 'package:trabalho/screens/components/Search_bar.dart';
import 'package:trabalho/screens/components/widgets.dart';
import 'package:trabalho/screens/components/EventCards.dart';
import 'package:trabalho/screens/components/BottomNavigation.dart';


class MainScreen extends StatefulWidget {
  final String uid;
  MainScreen({Key? key, required this.uid}) : super(key: key);
  Map<String, dynamic>? userData;

  //late List<Map<String, dynamic>> _dataList = [];

  List<Map<String, dynamic>>_dataList =  [
  {
  "name": "Grupo de Futebol",
  "participants": {"dewdw","fewfwe","deqdfe","dqddnwe"},
  "capacity": 6,
  },{
  "name": "Grupo de Futebol",
  "participants": {"dewdw","fewfwe","deqdfe","dqddnwe","dwedff"},
  "capacity": 9,
  },{
  "name": "Grupo de Futebol",
  "participants": {"dewdw","fewfwe"},
  "capacity": 3,
  },{
  "name": "Grupo de Futebol",
  "participants": {"dewdw","fewfwe","deqdfe"},
  "capacity": 6,
  },{
  "name": "Grupo de Futebol",
  "participants": {"dewdw","fewfwe"},
  "capacity": 12,
  },];


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {



  int _selectedIndex = 0;
  late String fullname = "" ;
  late int phoneNumber = 0;
  late String username = ""  ;




  @override
  void initState()  {
    super.initState();
    if (widget.uid.isEmpty) {
      // Navigate back to the login screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }else{
        setData();
        getEventsDataMock();
        setState(() {
            getEventsDataMock();
        });

    }
  }

   void getEventsData() async {
      FirebaseFirestore.instance.collection('Event').get().then((querySnapshot) {
        widget._dataList = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
    void getEventsDataMock() async {

    }



  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('user').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data;
    } else {
      // handle the case where the document doesn't exist
      return null;
    }
  }
  void setData() async {
    Map<String, dynamic>? userData = await getUserData(widget.uid);
    if (userData != null) {
      setState(() {
        fullname = userData['Full name'];
        phoneNumber = userData['Phone number'];
        username = userData['Username'];
        widget.userData = userData;
      });
    } else {
      //
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              ListView(
                shrinkWrap: false,
                children: [
                  Header(username, () {
                    Profile(context);
                  }, (){
                    Messages(context);
                  }),
                  Search_bar(search_title: "Search events",),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25,0,0,0),
                        child: Text("Events nearby:",style: TextStyle(fontSize: 16,color: Color(0xFFA0A0A0)),),
                      ),
                      Spacer(),
                      Icon(Icons.location_on,color:Color(0xFFA0A0A0) ,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 20, 30, 20),
                        child: Text("Porto",style: TextStyle(color: Color(0xFFA0A0A0)),), //TODO: Placeholder
                      ),
                    ],
                  ),
                  EventCards(dataList: widget._dataList,),
                  YellowButton(text:"CREATE EVENT",height: 80,width: double.infinity,onItemTapped: (){CreateEvent(context);},),
                ],
              ),
              CustomAppBar(title: "MY TEAMS",),
              CustomAppBar(title: "LOCATION",),
              CustomAppBar(title: "PLACES",),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  void Profile(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: widget.uid, userData: widget.userData) ));
  }
  void Messages(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessagesScreen(uid: widget.uid, userData: widget.userData,dataList: widget._dataList,) ));
  }
  void CreateEvent(BuildContext context){
    print("create event");
  }
}













