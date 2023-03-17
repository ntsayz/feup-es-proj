import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int _selectedIndex = 0;

  var username = "username";

  static final List<Widget> _widgetOptions = <Widget>[
    const Text('Home Screen'),
    const Text('Favorites Screen'),
    const Text('Profile Screen'),
    const Text('Settings Screen'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');  // Sai do aplicativo
        return false; // NÃO PERMITE QUE O UTILIZADOR VOLTE PARA A PÁGINA ANTERIOR (LOGIN-REGISTO)\\\\\\\\\\\\\]
      },
      child: Scaffold(
        extendBody: true,
          appBar: CustomAppBar(title: ''),
        backgroundColor: Colors.white,
        body: SafeArea(
          top:false,
          child: ListView(
            shrinkWrap: false,
            children: [
              profileArea(),
              CustomSearchBar(),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(25,0,0,0),
                    child: Text("Eventos nearby:",style: TextStyle(fontSize: 16,color: Color(0xFFA0A0A0)),),
                  ),
                  Spacer(),
                  Icon(Icons.location_on,color:Color(0xFFA0A0A0) ,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 30, 20),
                    child: Text("Porto",style: TextStyle(color: Color(0xFFA0A0A0)),), //TODO: Placeholder
                  ),
                ],
              ),
            EventCards(),
          const createEvent(),

          ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'My teams',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_sharp),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_handball_sharp),
              label: 'All places',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFF6B95D),
          unselectedItemColor:const  Color(0xFFA0A0A0),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class createEvent extends StatelessWidget {
  const createEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(80,40,80,80),
      child: Card(
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              //do smtg
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF6B95D),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'CREATE EVENT',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class EventList extends StatefulWidget {
  const EventList({
    super.key,
  });

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,10),
      child: Container(
        decoration:BoxDecoration(
          color: const Color(0xFFF6B95D),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6,20,6,20),
                child: SizedBox(
                  width: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const ListTile(
                      title: Center(child: Text('Evento',style: TextStyle(color: Color(0xFFA0A0A0)),)), // TODO: remove Center(). the subtitle will prob go as well
                      subtitle: Text(''),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
    );
  }
}

Widget profileArea() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0,5,20,2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'username',
              style: TextStyle(
                  fontSize: 16.0,color: Color(0xFFA0A0A0)
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.email_outlined,
                    size: 30.0,
                    color: Color(0xFFA0A0A0),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 8.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    'https://picsum.photos/id/64/200',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}





class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFF1F5F4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search,color:Color(0xFFA0A0A0)),
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

class EventCard extends StatefulWidget {
  final String title;
  final String imageUrl;

  const EventCard({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isSelected ? Colors.green : Colors.white10,
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



class EventCards extends StatelessWidget {
  final List<String> sportsCards = ['https://picsum.photos/200/300?random=1','https://picsum.photos/200/300?random=2',
    'https://picsum.photos/200/300?random=3', 'https://picsum.photos/200/300?random=4',
    'https://picsum.photos/200/300?random=5','https://picsum.photos/200/300?random=6','https://picsum.photos/200/300?random=7',
    'https://picsum.photos/200/300?random=8','https://picsum.photos/200/300?random=9','https://picsum.photos/200/300?random=10',  ];

  final List<String> locationPlaceholder = ['Nome do Campo','Localização','Nome do Campo',
    'Nome do Campo','Localização','Nome do Campo','Nome do Campo','Localização','Nome do Campo','Localização',];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,10),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF6B95D),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              String imageUrl = sportsCards[Random().nextInt(sportsCards.length)];
              String title = locationPlaceholder[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(6,20,6,20),
                child: EventCard(title: title, imageUrl: imageUrl),
              );
            },
          ),
        ),
      ),
    );
  }
}

