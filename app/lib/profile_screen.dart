import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho/home.dart';
import 'package:trabalho/main.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  final Map<String, dynamic>? userData;
  
  const ProfileScreen({Key? key, required this.uid, required this.userData}) : super(key: key);



  
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen(uid:widget.uid,)));
          },
        ),
        title: Text("Profile"),
      ),
      body: ElevatedButton(
        onPressed: () => _signOut(context),
        child: Text('Sign Out'),
      ),
    );
  }

  static void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e.toString());
    }
  }
}

