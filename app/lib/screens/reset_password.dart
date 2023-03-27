import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/screens/main.dart';

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
        appBar: AppBar(title: const Text("RESET PASSWORD"),
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.all(20.0),
              child: Text("Enter your mail"),),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "USER EMAIL",
                    prefixIcon: Icon(Icons.mail)
                ),
            ),
      const SizedBox(height: 20,),
      SizedBox(

      width: 150,
      child: RawMaterialButton(
      fillColor: Colors.blue,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0)
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
        child: const Text("Send Request"),
      ))
          ],
        ),
      ),
    );
  }
}
