import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:trabalho/main.dart';

import 'package:trabalho/profile_screen.dart';

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
          appBar: AppBar(title: const Text("CREATE YOUR USER")),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            const Test();
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




  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordController2 = TextEditingController();




    return Padding(
      padding: const EdgeInsets.all (16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const Text("Enter your email"),
        TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: "USER EMAIL",
            prefixIcon: Icon(Icons.mail)
          ),
        ),
        const SizedBox(
          height: 20
        ),
        const Text("Enter your password"),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: const InputDecoration(
              hintText: "PASSWORD",
              prefixIcon: Icon(Icons.lock)
          )
        ),
        const SizedBox(
          height: 20,
        ),
          const Text("Confirm your password"),
          TextField(
              obscureText: true,
              controller: _passwordController2,
              decoration: const InputDecoration(
                  hintText: "CONFIRM PASSWORD",
                  prefixIcon: Icon(Icons.lock)
              )
          ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: double.infinity,
          child: RawMaterialButton(
            fillColor: Colors.blue,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12.0)
             ),
            onPressed: () async {
              User? user = await createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
              print(user);

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


    if (_passwordController2.text == _passwordController.text) {
                if (user != null) {

                  showDialog(context: context,

                    builder: (BuildContext context) { return SimpleDialog(
                      title: Text("USER CREATED", style: TextStyle(fontSize: 30),),
                      children: <Widget>[
                        ButtonTheme(
                            minWidth: 50,
                            child:
                            ElevatedButton(
                                onPressed: () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp())),

                                child: Text("Back to Login Page"))
                        ),

                      ],


                    ); });
                  }
              }

              if (_passwordController.text.length <=6 || _passwordController2.text.length <=6){
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
                                Text("Passwords are not tha same", style: TextStyle(fontSize: 18, color: Colors.white),)

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



              else{
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
            },
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),

            child: const Text("Create USer"),


          )
        )

        ],
      ),




    );




    return const Placeholder();
  }
}

class Test extends StatelessWidget{
  const Test({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("CREATE YOUR USER")),
      body:Column(
        children: const [
          Text("THIS IS IT"),
        ],
      ) ,);

    // TODO: implement build
    throw UnimplementedError();
  }

}