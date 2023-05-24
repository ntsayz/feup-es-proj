import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/main.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    bool? change;

    TextEditingController _emailController = TextEditingController();


    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
        return true;
        },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                const SizedBox( height: 130,),
                Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.arrow_back, color: Color.fromRGBO(246, 185, 93, 1),),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
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
              ),
            ),
      const SizedBox(height: 40,),
      SizedBox(
          width: 300,
          height: 60,
      child: RawMaterialButton(
        fillColor: Color.fromRGBO(246, 185, 93, 1),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0)
      ),
      onPressed: () async {
        auth.sendPasswordResetEmail(email: _emailController.text);
        showDialog(context: context,

        builder: (BuildContext context) { return SimpleDialog(
          title: Text("Check your email", style: TextStyle(fontSize: 30),),
          children: <Widget>[
            ButtonTheme(
                minWidth: 50,
                child:
        ElevatedButton(
            onPressed: () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp())),

          child: Text("Back to Login Page"))
            ),

          ],


        ); },
        );
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));

      },
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: const Text(
          "Send Request",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ))
          ],
        ),
      ),
    );
  }
}
