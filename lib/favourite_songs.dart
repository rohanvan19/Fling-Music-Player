import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFavouriteSongs extends StatefulWidget {
  const MyFavouriteSongs({super.key});

  @override
  State<MyFavouriteSongs> createState() => _MyFavouriteSongsState();
}

class _MyFavouriteSongsState extends State<MyFavouriteSongs> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.music_note),
            title: Text("Song Name $index"),
            subtitle: Text('Artist Name'),
          );
        }
    );
  }
}
