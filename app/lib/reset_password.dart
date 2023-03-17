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

    TextEditingController _emailController = TextEditingController();


    return Scaffold(
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
                      Text("Email sent ", style: TextStyle(fontSize: 18, color: Colors.white),)

                    ],
                  ) )
                ]
            )
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));

    },
      elevation: 0.0,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: const Text("Send Request"),
    ))
        ],
      ),
    );
  }
}
