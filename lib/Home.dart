import 'package:flutter/material.dart';
import 'package:make_my_show/AllMovie.dart';
import 'package:make_my_show/Search.dart';
import 'package:make_my_show/Details.dart';
class HOME extends StatefulWidget {

  @override
  State<HOME> createState() => _NavPageState();
}
class _NavPageState extends State<HOME> {
  int _currentIndex = 0;
  final List<Widget> _pages = [AllMovie(),Search(),Search(),AllMovie(),Details()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 93, 40, 40), 
        child: BottomNavigationBar(
          // fixedColor: Color.fromARGB(255, 0, 161, 51),
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movies',
               backgroundColor:  Color.fromARGB(255, 37, 16, 16),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor:  Color.fromARGB(255, 37, 16, 16),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
              backgroundColor: Color.fromARGB(255, 37, 16, 16),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download),
              label: 'Download',
               backgroundColor: Color.fromARGB(255, 37, 16, 16),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor:Color.fromARGB(255, 37, 16, 16),
            ),
            
          ],
        ),
      ),
    );
  }
}

