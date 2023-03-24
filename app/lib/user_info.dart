import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:trabalho/home.dart';

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

            MaterialButton(
                onPressed: _ShowDatePicker,
                child: const Padding(padding: EdgeInsets.all(20.0),
                child: Text('Birth date', style: TextStyle(color: Colors.amber),),

                ),),

            RawMaterialButton(
                fillColor: Colors.blue,
                child: const Text('send'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
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




addUserDetails (BuildContext context, DateTime date, String uid, String name, String phone, String user){
  FirebaseFirestore.instance.collection('user').doc(uid).set({
    'Birth Date' : date,
    'Full name': name,
    'Phone number' : int.parse(phone),
    'Username' : user,
  });




  return   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen(uid: uid)));


  // return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
}
