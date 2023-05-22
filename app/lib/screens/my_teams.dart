import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/Group_page.dart';
import 'package:trabalho/screens/components/widgets.dart';
import 'package:trabalho/screens/users_of_group.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho/screens/BirthDateSelector.dart';
import 'package:trabalho/screens/components/appicon.dart';
import 'package:trabalho/main.dart';
import 'profilepicture.dart';
import 'MyDropdownmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class MyTeams extends StatefulWidget {
  final String uid;
  final Map<String, dynamic>? userData;

  const MyTeams({Key? key, required this.uid, required this.userData}) : super(key: key);


  @override
  State<MyTeams> createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {
  TextEditingController _groupnamecontroller = TextEditingController();


  int _counter = 0;

  void _reloadPAge(){
    setState(() {
      _counter = _counter +1;
    });
  }

  late String _username = "";







  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getUIDGroups(widget.uid),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // while the future is still running, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // if the future encountered an error, show an error message
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("You don´t have any groups yet. Create one if you want"),
                SizedBox(height: 16),
                YellowButton(
                  text: "CREATE GROUP",
                  height: 50,
                  width: double.infinity,
                  onItemTapped: () => newGroupName(),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData) {
          // if the future completed but returned no data, show an empty message
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("You don´t have any groups yet. Create one if you want"),
                SizedBox(height: 16),
                YellowButton(
                  text: "CREATE GROUP",
                  height: 50,
                  width: double.infinity,
                  onItemTapped: () => newGroupName(),
                ),
              ],
            ),
          );
        } else {
          // if the future completed and returned data, build the UI with the data
          List<String> groups = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                appiconWidget(),
                D8ddzukxuaaxldy1Widget(),
                SizedBox(height: 10),
                FutureBuilder<String?>(
                  future: getUserName(widget.uid), // Call the getUserName function with the desired ID
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Display an error message if an error occurs
                    } else {
                      final username = snapshot.data ?? ""; // Get the result of the future
                      return Text(
                        username, // Use the username in the Text widget
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(113, 127, 127, 1),
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: GroupButton(groupId: groups[index], uid: widget.uid),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                YellowButton(
                  text: "CREATE GROUP",
                  height: 50,
                  width: double.infinity,
                  onItemTapped: () => newGroupName(),
                ),
              ],
            ),
          );


        }
      },
    );
  }



  void newGroupName(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('What is the group name ?'),
          content: TextField(
            controller: _groupnamecontroller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(hintText: 'ex:.. Grupo de Futebol'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                _groupnamecontroller.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                createGroup(_groupnamecontroller.text, widget.uid); //TODO
                _groupnamecontroller.clear();
                Navigator.of(context).pop();
                _reloadPAge();
              },
            ),
          ],
        );
      },
    );
  }

}


class GroupButton extends StatelessWidget {
  final String groupId;
  final String uid;

  const GroupButton({required this.groupId, required this.uid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getGroupName(groupId),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupScreen(groupuid: groupId, uid: uid,),
                ),
              );
            },
            child: Text(
              snapshot.data!,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }
}