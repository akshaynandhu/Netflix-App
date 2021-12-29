import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:netflix/screen/screen_comingSoon/comingsoon.dart';
import 'package:netflix/screen/screen_downloads/downloads.dart';
import 'package:netflix/screen/screen_fastLaugh/fastlaugh.dart';
import 'package:netflix/screen/screen_home/screen_main.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _navPages = <Widget>[
    MainScreen(),
    ComingSoon(),
    FastLaugh(),
    Downloads()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _selectedIndex == 2 ?Colors.black.withOpacity(0.2):Colors.black,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey.shade800,
        onTap: (index){
          _onItemTapped(index);
          debugPrint(_selectedIndex.toString());
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Elusive.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined),
            label: "Coming soon",
          ),BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            label: "Fast Laughs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: "Downloads",
          ),
        ],
      ),
      body: _navPages.elementAt(_selectedIndex),
    );
  }
}
