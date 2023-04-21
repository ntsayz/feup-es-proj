import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/users_of_group.dart';
import 'components/widgets.dart';

var users22 = [];




class removeUserScreen extends StatefulWidget {
  final String groupID;
  final String uid;

  const removeUserScreen({Key? key, required this.groupID, required this.uid}) : super(key: key);

  @override
  State<removeUserScreen> createState() => _removeUserScreenScreenState();
}

class _removeUserScreenScreenState extends State<removeUserScreen> {

  int _counter = 0;

  void _reloadPAge(){
    setState(() {
      _counter = _counter +1;
    });
  }

  // List to keep track of selected users
  List<String> selectedUsers = [];


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getUsersofGroup(widget.groupID),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // while the future is still running, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // if the future encountered an error, show an error message
          return Center(child: Text('Error22: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          // if the future completed but returned no data, show an empty message
          return Center(child: Text('No data found'));
        } else {
          // if the future completed and returned data, build the UI with the data
          List<String> users = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("SELECT USERS TO REMOVE: ", style: TextStyle(fontSize: 30),),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserBox(userId: users[index]);
                      },
                    ),
                  ),
                  YellowButton(
                    text: "REMOVE",
                    height: 50,
                    width: double.infinity,
                    //onItemTapped: () => addElement(),
                    onItemTapped: () {
                      for (var user in users22){
                        removeUIDFromGroup(user, widget.groupID);
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => usersOfFroupScreen(groupID: widget.groupID, uid: widget.uid,),
                        ),
                      );                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }



}

class UserBox extends StatefulWidget {
  final String userId;

  const UserBox({required this.userId});

  @override
  _UserBoxState createState() => _UserBoxState();
}

class _UserBoxState extends State<UserBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserName(widget.userId),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: 80.0,
            height: 80.0,
            child: Stack(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (users22.contains(widget.userId)) {
                      users22.remove(widget.userId);
                      print(users22);
                      setState(() {
                        isSelected = !isSelected;
                      });
                    }
                    else{
                      users22.add(widget.userId);
                      print(users22);
                      setState(() {
                        isSelected = !isSelected;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isSelected ? Colors.blue : null,
                  ),
                  child: Text(
                    snapshot.data!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: isSelected ? Colors.blue : Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

