import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:trabalho/backend/event.dart';
import 'package:trabalho/screens/home.dart';
import 'package:trabalho/screens/components/widgets.dart';
import 'package:trabalho/backend/Groups.dart';



// Create a Form widget.
class CreateEventScreen extends StatefulWidget {
  final String uid;
  const CreateEventScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => CreateEventScreenState();
}

class CreateEventScreenState extends State<CreateEventScreen> {

  final _formKey = GlobalKey<FormState>();


  TextEditingController _sportController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _capacity = TextEditingController();
  String? selectedItem;
  String? selectedGroup;
  String? groupTo;


  TextEditingController _dateController = TextEditingController();
  DateTime _dateTime  = DateTime.now();

  Future<DateTime> _ShowDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );

    if (selectedDate != null) {
      setState(() {
        _dateTime = selectedDate;
        _dateController.text = formatter.format(selectedDate);
      });
    }

    return selectedDate ?? DateTime.now();
  }

  var formatter = new DateFormat('dd-MM-yyyy');


  TextEditingController _timeController = TextEditingController();
  final DateFormat _timeFormatter = DateFormat('h:mm a');



  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = _timeFormatter.format(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            pickedTime.hour,
            pickedTime.minute,
          ),
        );
      });
    }
  }

  void showSuccessScreenAndPop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your event has been created'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Pop the current screen
              },
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _timeController.clear();
        _sportController.clear();
        _nameController.clear();
        _capacity.clear();
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "NEW EVENT"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Enter the name of the event"),
              ),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Name of the event",
                  prefixIcon: Icon(Icons.sports_cricket),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("How many people are left?"),
              ),
              TextFormField(
                controller: _capacity,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Capacity",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Choose a sport"),
                        ),
                        DropdownButton<String>(
                          value: selectedItem,
                          hint: Text('Select a sport'),
                          itemHeight: 60, // Adjust the item height to make the dropdown larger
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Football',
                              child: Text('Football'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Padel',
                              child: Text('Padel'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Running',
                              child: Text('Running'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Gym',
                              child: Text('Gym'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Cycle',
                              child: Text('Cycle'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedItem = newValue;
                              _sportController.text = newValue ?? ''; // Set the selected value to the controller
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Choose a group"),
                        ),
                        FutureBuilder<List<String>>(
                          future: getUIDGroups(widget.uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // Show a loading indicator while fetching data
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Show an error message if an error occurs
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Build the dropdown menu items
                              List<DropdownMenuItem<String>> dropdownItems = (snapshot.data ?? []).map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: FutureBuilder<String?>(
                                    future: getGroupName(item),
                                    builder: (context, groupNameSnapshot) {
                                      if (groupNameSnapshot.connectionState == ConnectionState.waiting) {
                                        // Show a loading indicator while fetching the group name
                                        return Text('Loading...');
                                      } else if (groupNameSnapshot.hasError) {
                                        // Show an error message if an error occurs while fetching the group name
                                        return Text('Error: ${groupNameSnapshot.error}');
                                      } else {
                                        return Text(groupNameSnapshot.data ?? '');
                                      }
                                    },
                                  ),
                                );
                              }).toList();

                              return DropdownButton<String>(
                                value: selectedGroup,
                                hint: Text('Select a group'),
                                itemHeight: 60, // Adjust the item height to make the dropdown larger
                                items: dropdownItems,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedGroup = newValue;
                                    // Handle group selection here
                                  });
                                },
                              );
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              const Padding(padding: EdgeInsets.all(10.0),
                child: Text("When is the event?"),
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: formatter.format(DateTime.now()),
                  icon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _ShowDatePicker(),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("What time is the event?"),
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  hintText: _timeFormatter.format(DateTime.now()),
                  icon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => _showTimePicker(),
              ),
              SizedBox(height: 20,),
              RawMaterialButton(
                padding: EdgeInsets.all(10.0),
                fillColor: Colors.blue,
                child: const Text(
                  'CREATE',
                  style: TextStyle(fontSize: 20),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  if (_nameController.text.isEmpty || _capacity.text.isEmpty || _sportController.text.isEmpty || _dateTime.toString().isEmpty || _timeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Container(
                          height: 90,
                          decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          child:
                          Row(
                              children: [
                                const SizedBox( width: 35,),
                                Expanded(child: Row(
                                  children: const [
                                    Text("ALL FIELDS SHOULD BE FILLED", style: TextStyle(fontSize: 18, color: Colors.white),)

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
                    DateTime timeSelected = joinDateTimeWithTime(_dateTime, _timeController);
                    createEvent(widget.uid, _nameController.text, int.parse(_capacity.text), _sportController.text, timeSelected, selectedGroup!);
                    showSuccessScreenAndPop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}