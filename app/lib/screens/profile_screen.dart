import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho/screens/BirthDateSelector.dart';
import 'package:trabalho/screens/components/appicon.dart';
import 'package:trabalho/main.dart';
import 'profilepicture.dart';
import 'MyDropdownmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho/backend/Groups.dart';


class ProfileScreen extends StatefulWidget {
  final String uid;
  final Map<String, dynamic>? userData;

  const ProfileScreen({Key? key, required this.uid, required this.userData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username = ""  ;

  static void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('user').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data;
    } else {
      // handle the case where the document doesn't exist
      return null;
    }
  }
  void setData() async {
    Map<String, dynamic>? userData = await getUserData(widget.uid);
    if (userData != null) {
      setState(() {
        username = userData['Username'];
      });
    } else {
      //
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
              FutureBuilder<String?>(
                future: getUserName(widget.uid), // Call the getUserName function with the desired ID
                builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Display an error message if an error occurs
                  } else {
                    final username = snapshot.data ?? ""; // Get the result of the future
                    return Text(
                      username, // Use the username in the Text widget
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(113, 127, 127, 1),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    );
                  }
                },
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
                        child: BirthDateSelector(uid: widget.uid),
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
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  _signOut(context);
                },
                child: Text(
                  "Sign out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







