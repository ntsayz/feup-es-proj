import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:trabalho/screens/home.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/components/widgets.dart';


class UserInformations extends StatefulWidget {


  const UserInformations({Key? key, required this.uid}) : super(key: key);

  final uid;

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {

  _UserInformationsState({Key? key,});


  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  DateTime _dateTime  = DateTime.now();

  Future<DateTime> _ShowDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _dateTime = selectedDate;
      });
    }

    return selectedDate ?? DateTime.now();
  }

  var formatter = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ return false;},
      child: Scaffold(
        appBar: CustomAppBar(title: ("USER INFO"),),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
            Column(
          children: [
            const Padding(padding: EdgeInsets.all(20.0),
              child: Text("Enter your full name"),),

            TextFormField(
              controller: _fullNameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "Full name",
                  prefixIcon: Icon(Icons.person)
              ),
            ),
            const Padding(padding: EdgeInsets.all(20.0),
              child: Text("Enter your phone number"),),

            TextFormField(
              controller: _phoneNumber,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  hintText: "Phone Number",
                  prefixIcon: Icon(Icons.phone)
              ),
            ),
            const Padding(padding: EdgeInsets.all(20.0),
              child: Text("Enter your username"),),

            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "User name",
                  prefixIcon: Icon(Icons.person)
              ),
            ),


            const Padding(padding: EdgeInsets.all(20.0),
              child: Text("Enter your Birth Date"),),
            TextFormField(

              decoration: InputDecoration(hintText: formatter.format(DateTime.now()) ,
                  icon: Icon(Icons.calendar_today)),
              readOnly: true,
              onTap: () => _ShowDatePicker(),
            ),


            SizedBox(height: 35,),
            RawMaterialButton(
                padding: EdgeInsets.all(20.0),
                fillColor: Colors.blue,
                child: const Text('Confirm',
                  style: TextStyle(fontSize: 20),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                ),
                onPressed: () {
                    addUserDetails(context, _dateTime , widget.uid, _fullNameController.text.trim(), _phoneNumber.text.trim(), _usernameController.text.trim());

                })


          ],
        )),



      ), );





    return const Placeholder();
  }
}




addUserDetails (BuildContext context, DateTime date, String uid, String name, String phone, String user) async {
  FirebaseFirestore.instance.collection('user').doc(uid).set({
    'Birth Date' : date,
    'Full name': name,
    'Phone number' : int.parse(phone),
    'Username' : user,
  });





  return   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen(uid: uid)));


  // return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
}
