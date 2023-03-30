import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/screens/main.dart';
import 'profilepicture.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  final Map<String, dynamic>? userData;

  const ProfileScreen({Key? key, required this.uid, required this.userData}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6B95D),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Profile"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 353,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color.fromRGBO(241, 245, 244, 1),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => _signOut(context),
                  child: Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFF6B95D),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              D8ddzukxuaaxldy1Widget(),
            ],
          ),
        ),
      ),
    );
  }
}





