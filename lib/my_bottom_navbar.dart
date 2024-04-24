import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBottomNavbar extends StatefulWidget {
  const MyBottomNavbar({super.key});

  @override
  State<MyBottomNavbar> createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Songs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.heart_broken_rounded),
          label: 'Liked',
        )
      ],
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[300],
      unselectedItemColor: Colors.white,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: GoogleFonts.blackOpsOne(),
      unselectedLabelStyle: GoogleFonts.blackOpsOne(),
      onTap: _onItemTapped,
      iconSize: 26,
      elevation: 0,
    );
  }
}
