import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/users_of_group.dart';
import 'components/widgets.dart';
import 'package:trabalho/backend/event.dart';
import 'package:intl/intl.dart';



class GroupScreen extends StatefulWidget {
  final String uid;
  final String groupuid;

  const GroupScreen({Key? key, required this.groupuid, required this.uid}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {


  int cont =0;
  void reloadPage(){
    setState(() {
      cont++;
    });
  }




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
                    Center(child: Text("Events of the group:" ,  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24,
                          ),

                    ),
                    ),
                    FutureBuilder<List<String>>(
                        future: getEventssofGroup(widget.groupuid),
                        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // while the future is still running, show a loading indicator
                              return Center(child: CircularProgressIndicator());
                            }
                            else{
                              List<String> events = snapshot.data!;
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: events.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: EventButton(groupId: widget.groupuid, uid:widget.uid , EventID: events[index]),
                                    );
                                  },
                                ),
                              );
                            }
                        }
                    ),



                  ],
                ),
              ),


            ),
          );
        }
    );
  }
}



class EventButton extends StatelessWidget {
  final String groupId;
  final String uid;
  final String EventID;

  const EventButton(
      {required this.groupId, required this.uid, required this.EventID});






  @override
  Widget build(BuildContext context) {
    List<String> eventElements = [];

  List <String> elements = [];
  getEventMember() async{
    elements = await EventElements(EventID);
  }
    void reloadPage(){
      final groupScreenState = context.findAncestorStateOfType<_GroupScreenState>();
      if (groupScreenState!=null){
        groupScreenState.reloadPage();
      }
    }

    getEventMember();

    return FutureBuilder<String?>(
      future: getEventName(EventID),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.black, // Customize the border color here
                  width: 2.0, // Customize the border width here
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          snapshot.data!,
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(width: 10), // Add some spacing between the text and the icon

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(4), // Adjust the border radius as needed
                          ),
                          padding: EdgeInsets.all(4), // Adjust the padding as needed
                          child: (elements.contains(uid))
                              ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                              : Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Row(
                      children: [
                        Text(
                          "Capacity: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        FutureBuilder<int?>(
                          future: getEventCapacity(EventID),
                          builder: (BuildContext context, AsyncSnapshot<
                              int?> snapshot) {
                            if (snapshot.connectionState == ConnectionState
                                .waiting) {
                              // While the future is loading, display a loading indicator or placeholder
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurred while fetching the data, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // If the future completed successfully, display the data
                              if (snapshot.hasData) {
                                return Container(
                                  child: Text(snapshot.data!.toString()),
                                );
                              } else {
                                // Handle the case where the future returned null
                                return Text('No data available');
                              }
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 25,),

                    Row(
                      children: [
                        Text(
                          "Day: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<Timestamp?>(
                          future: getEventDate(EventID),
                          builder: (BuildContext context, AsyncSnapshot<
                              Timestamp?> snapshot) {
                            if (snapshot.connectionState == ConnectionState
                                .waiting) {
                              // While the future is loading, display a loading indicator or placeholder
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurred while fetching the data, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // If the future completed successfully, display the data
                              if (snapshot.hasData) {
                                return Container(
                                  child: Text(DateFormat.Hm().format(
                                      snapshot.data!.toDate()).toString()),
                                );
                              } else {
                                // Handle the case where the future returned null
                                return Text('No data available');
                              }
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 25,),

                    Row(
                      children: [
                        Text(
                          "Sport: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ), FutureBuilder<String?>(
                          future: getEventSport(EventID),
                          builder: (BuildContext context, AsyncSnapshot<
                              String?> snapshot) {
                            if (snapshot.connectionState == ConnectionState
                                .waiting) {
                              // While the future is loading, display a loading indicator or placeholder
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurred while fetching the data, display an error message
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // If the future completed successfully, display the data
                              if (snapshot.hasData) {
                                return Container(
                                  child: Text(snapshot.data!),
                                );
                              } else {
                                // Handle the case where the future returned null
                                return Text('No data available');
                              }
                            }
                          },
                        )
                      ],
                    ),


                    ElevatedButton(
                      onPressed: () async {
                        eventElements = await EventElements(EventID);

                        if (eventElements.contains(uid)) {
                          removeElementEvent(uid, EventID);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Container(
                                height: 90,
                                decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                child:
                                Row(
                                    children: [
                                      const SizedBox( width: 35,),
                                      Expanded(child: Row(
                                        children: const [
                                          Text("You are no longer part of this event", style: TextStyle(fontSize: 18, color: Colors.white),)

                                        ],
                                      ) )
                                    ]
                                )
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ));
                        } else {
                          addElementEvent(uid, EventID);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Container(
                                height: 90,
                                decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                child:
                                Row(
                                    children: [
                                      const SizedBox( width: 35,),
                                      Expanded(child: Row(
                                        children: const [
                                          Text("You are participating in the event", style: TextStyle(fontSize: 18, color: Colors.white),)

                                        ],
                                      ) )
                                    ]
                                )
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ));
                        }

                        reloadPage();
                      },
                      child: Builder(
                        builder: (BuildContext context) {
                          if (eventElements.contains(uid)) {
                            return Text("I'M OUT");
                          } else {
                            return Text("I'M IN");
                          }
                        },
                      ),
                    )


                  ],
                ),
              ));


/*          return ElevatedButton(
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
          );*/
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}



