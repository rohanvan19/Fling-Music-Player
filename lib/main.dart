import 'package:fling/favourite_songs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fling/list_of_songs.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Fling ',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
  // Index for Navbar
  int _selectedIndex = 0;

  // After clicking on navbar icons
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    MySongList(),
    MyFavouriteSongs(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text('F L I N G', style: GoogleFonts.blackOpsOne(
            fontWeight: FontWeight.w400,)
          ),
        elevation: 25,
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[200],
      ),
      endDrawer: EndDrawerButton(),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'S O N G S',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'L I K E D',
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[600],
        unselectedItemColor: Colors.black,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: GoogleFonts.blackOpsOne(),
        unselectedLabelStyle: GoogleFonts.blackOpsOne(),
        onTap: _onItemTapped,
        iconSize: 26,
        elevation: 15,
      ),
    );
  }
}