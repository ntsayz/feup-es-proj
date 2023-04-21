import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/users_of_group.dart';
import 'components/widgets.dart';


class GroupScreen extends StatefulWidget {
  final String uid;
  final String groupuid;

  const GroupScreen({Key? key, required this.groupuid, required this.uid}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {

  @override
    Widget build(BuildContext context) {
        return FutureBuilder<String?>(
          future: getGroupName(widget.groupuid),
          builder: (context, AsyncSnapshot<String?> snapshot) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          snapshot.data!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 95.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => usersOfFroupScreen(groupID: widget.groupuid, uid: widget.uid),
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
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox( height: 20,),
                      Text("IN HERE GOES THE EVENTS AND OTHER THINGS WE MAY WANT, BUT HAVE NOT BEEN CREATED")
                    ],
                  ),
                ),


              ),
            );
          }
        );
      }
}

