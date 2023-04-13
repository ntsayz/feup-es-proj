import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho/screens/BirthDateSelector.dart';
import 'package:trabalho/screens/components/appicon.dart';
import 'package:trabalho/screens/home.dart';
import 'package:trabalho/screens/main.dart';
import 'profilepicture.dart';
import 'MyDropdownmenu.dart';

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
              appiconWidget(),
              D8ddzukxuaaxldy1Widget(),
              SizedBox(height: 10),
              Text(
                widget.userData?['email'] ?? 'Username',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(113, 127, 127, 1),
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
              SizedBox(height: 18),
              Container(
                width: 353,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(241, 245, 244, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        width:350,
                        height:60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        child: MyDropdownMenu(),
                      ),
                      SizedBox(height:10),
                      Container(
                        width:350,
                        height:60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        child: BirthDateSelector(),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFF6B95D),
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height:20),
              ElevatedButton(
                  onPressed: () => _signOut(context),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize:20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF6B95D),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







