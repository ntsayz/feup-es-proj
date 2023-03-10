import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');  // Sai do aplicativo TODO: HAS TO BE BETTER IMPLEMENTED
        return false; // NÃO PERMITE QUE O UTILIZADOR VOLTE PARA A PÁGINA ANTERIOR (LOGIN-REGISTRO)
      },
      child: Scaffold(
          appBar: CustomAppBar(title: 'Sports App'),
        backgroundColor: Colors.blueGrey,
        body: ListView(
          shrinkWrap: false,
          children: [
            CustomSearchBar(),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Events nearby"),
                ),
                Spacer(),
                Icon(Icons.location_on),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 30, 20),
                  child: Text("Porto"), //TODO: Placeholder
                ),
              ],
            ),
            EventList(),
          ],
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: ListTile(
                  title: Center(child: Text('Event $index')), // TODO: remove Center(). the subtitle will prob go as well
                  subtitle: Text(''),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // Do something when user icon is pressed
          },
        ),
        IconButton(
          icon: Icon(Icons.message),
          onPressed: () {
            // Do something when message icon is pressed
          },
        ),
      ],
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border:InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
