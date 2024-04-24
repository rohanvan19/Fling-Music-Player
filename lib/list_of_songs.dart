import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fling/now_playing.dart';

class MySongList extends StatefulWidget {
  const MySongList({super.key});

  @override
  State<MySongList> createState() => _MySongListState();
}

class _MySongListState extends State<MySongList> {
  @override
  void initState(){
    super.initState();
    requestPermission();
  }

  void requestPermission(){
    Permission.storage.request();
  }

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final AudioPlayer _audioPlayer = AudioPlayer();

  playSong(String? uri){
    try {
      _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(uri!))
      );
      _audioPlayer.play();
    } on Exception {
      print("Error Parsing Song");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(sortType: null, orderType: OrderType.ASC_OR_SMALLER, uriType: UriType.EXTERNAL, ignoreCase: true),
          builder: (context, item) {
            if (item.data == null){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty){
              return const Center(child: Text('No Songs Found'));
            }
            return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      leading: const Icon(Icons.queue_music_outlined),
                      title: Text(item.data![index].displayNameWOExt, style: GoogleFonts.blackOpsOne(fontSize : 14)),
                      subtitle: Text("${item.data![index].artist}",style: GoogleFonts.blackOpsOne()),
                      // onTap: playSong(item.data![index].uri),
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder:
                              (context) => NowPlaying(songModel: item.data![index], audioPlayer: _audioPlayer,),
                        ),
                      );
                      }
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}
