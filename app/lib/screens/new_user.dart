import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:trabalho/screens/home.dart';
import 'package:trabalho/main.dart';
import 'package:trabalho/backend/Groups.dart';
import 'package:trabalho/screens/profile_screen.dart';
import 'package:trabalho/screens/user_info.dart';
import 'package:trabalho/screens/components/appicon.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }


  @override
  Widget build(BuildContext context){
    return WillPopScope(
        onWillPop: () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
      return true;
    },
    child: Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return NewUserScreen();
          }
          return const Center(child: CircularProgressIndicator(),
          );
        },
      ),)
    );
  }
}


class NewUserScreen extends StatefulWidget {
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {

  static Future<User?> createUserWithEmailAndPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordController2 = TextEditingController();
    TextEditingController _birthdateController = TextEditingController();


  var _isObscured =true;
  var _isObscured2 =true;

  @override
  void dispose() {
    _passwordController.dispose(); // Dispose the controller object when the widget is disposed
    _passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all (16.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appiconWidget(),
                Text(
                  'SportsStack',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                // Insert appiconWidget() here
              ],
            ),
          ),
          const SizedBox(height: 140,),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromRGBO(241, 245, 244, 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "USER EMAIL",
                prefixIcon: Icon(Icons.mail),
              ),
            ),
          ),
          const SizedBox(
              height: 20
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromRGBO(241, 245, 244, 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              obscureText: _isObscured,
              controller: _passwordController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: _isObscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                hintText: "PASSWORD",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromRGBO(241, 245, 244, 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              obscureText: _isObscured2,
              controller: _passwordController2,
              decoration: InputDecoration(
                hintText: "CONFIRM PASSWORD",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: _isObscured2 ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured2 = !_isObscured2;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 90,
          ),
          SizedBox(
              width: 300,
              height: 60,
              child: RawMaterialButton(
                fillColor: Color.fromRGBO(246, 185, 93, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                ),
                onPressed: () async {

                  final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text);

                  if (list.isNotEmpty){
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
                                    Text("Email already in use", style: TextStyle(fontSize: 18, color: Colors.white),)

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


              else if (_passwordController.text.length <=6 || _passwordController2.text.length <=6){
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
                              Text("Password is too weak", style: TextStyle(fontSize: 18, color: Colors.white),)

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

              else if (_passwordController.text.length >=6 || _passwordController2.text.length >=6){
                if (_passwordController2.text != _passwordController.text){
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
                                  Text("Passwords are not the same", style: TextStyle(fontSize: 18, color: Colors.white),)

                                ],
                              ) )
                            ]
                        )
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ));
                }}
    if(_passwordController2.text == _passwordController.text) {
                User? user = await createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
                if (user != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserInformations(uid: user.uid.toString(),user: user,)));
                }
              }


             /* else{
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
                                Text("Email already in use", style: TextStyle(fontSize: 18, color: Colors.white),)

                              ],
                            ) )
                          ]
                      )
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ));
              }*/
            },
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: const Text(
                  "Create User",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),


          )
        )

        ],
      ),

    );

    return const Placeholder();
  }
}