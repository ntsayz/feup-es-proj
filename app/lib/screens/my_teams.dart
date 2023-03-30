import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';

class MyTeams extends StatefulWidget {
  final String uid;
  final Map<String, dynamic>? userData;

  const MyTeams({Key? key, required this.uid, required this.userData}) : super(key: key);


  @override
  State<MyTeams> createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {
  TextEditingController _groupnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
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
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    createGroup(_groupnamecontroller.text, widget.uid); //TODO
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text('Press me'),);
  }



  void hello(){

  }
}

