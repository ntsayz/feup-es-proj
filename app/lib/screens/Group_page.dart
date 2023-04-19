import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/users_of_group.dart';
import 'components/widgets.dart';


class GroupScreen extends StatefulWidget {
  // final String uid;
  final String groupuid;

  const GroupScreen({Key? key, required this.groupuid}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(16.0),
           child: Center(
              child: Column(
                children: [
                  SizedBox(height: 80,),
                  Container(
                    width: 100.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => usersOfFroupScreen(uid: widget.groupuid),
                            ),
                          );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.account_circle),
                              Text("Elements"),
                            ],
                          ),
                        )),
                  ),
                  Text("IN HERE GOES THE EVENTS AND OTHER THINGS WE MAY WANT, BUT HAVE NOT BEEN CREATED")
                ],
              ),
            ),


        ),
      );
    }
}

