import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:trabalho/profile_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return const MaterialApp(
      home: HomePage(),
    );

    throw UnimplementedError();
  }


}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();


}

class _HomePageState extends State<HomePage>{

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return LoginScreen();
          }
          return const Center(child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{





  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user=userCredential.user;
    }on FirebaseAuthException catch(e){
      if (e.code=="user-not-found"){
        print ("No user found for that email");
      }
    }
    return user;

  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Enter your mail"),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "USER EMAIL",
                prefixIcon: Icon(Icons.mail)
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Enter your password"),
          TextField(
            obscureText: true,
            controller: _passwordController,
            decoration: const InputDecoration(
                hintText: "PASSWORD",
                prefixIcon: Icon(Icons.lock)
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            child: Text ("FORGOT YOUR PASSWORD?"),
  /* to be changed to new passord screen */          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileScreen())),

          ),

          const SizedBox(
            height: 80,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
              ),
              onPressed: () async {
                User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                print (user);

                if (user!=null){
      /* to be changed top main screen*/            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileScreen()));
                }
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
                                  Text("ENTER A VALID COMBINATION", style: TextStyle(fontSize: 18, color: Colors.white),)

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
              child: const Text("Login"),
            )
            ,),
          const SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              child: const Text("DON'T HAVE A USER YET"),
   /*to be change to new user */           onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileScreen())),

            )

          )
        ],
      ),


    );


    // TODO: implement build
    throw UnimplementedError();
  }
}
