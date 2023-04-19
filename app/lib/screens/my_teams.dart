import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/Group_page.dart';
import 'package:trabalho/screens/components/widgets.dart';
import 'package:trabalho/screens/users_of_group.dart';




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
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      return GroupButton(groupId: groups[index]);
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
                _groupnamecontroller.clear();
                createGroup(_groupnamecontroller.text, widget.uid); //TODO
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

  const GroupButton({required this.groupId});

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
                  builder: (context) => GroupScreen(groupuid: groupId),
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
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
