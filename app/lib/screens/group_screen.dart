import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/backend/Groups.dart';
import 'components/widgets.dart';

class groupScreen extends StatefulWidget {
  final String uid;

  const groupScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<groupScreen> createState() => _groupScreenState();
}

class _groupScreenState extends State<groupScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getUsersofGroup(widget.uid),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // while the future is still running, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // if the future encountered an error, show an error message
          return Center(child: Text('Error22: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          // if the future completed but returned no data, show an empty message
          return Center(child: Text('No data found'));
        } else {
          // if the future completed and returned data, build the UI with the data
          List<String> users = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("USERS: ", style: TextStyle(fontSize: 30),),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserButton(userId: users[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}


class UserButton extends StatelessWidget {
  final String userId;

  const UserButton({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserName(userId),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: 80.0,
            height: 80.0,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                snapshot.data!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
