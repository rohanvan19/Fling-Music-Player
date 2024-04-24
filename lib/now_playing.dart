import 'package:fling/neu_box.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:google_fonts/google_fonts.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key, required this.songModel, required this.audioPlayer});

  final SongModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  bool isPlaying = true;
  bool isRepeatOn = false;
  double _sliderValue = 0.0;

  @override
  void initState(){
    super.initState();
    playSong();
  }

  void playSong(){
    try{
      widget.audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
      widget.audioPlayer.play();

      // Listen to the audio player position and update the slider value accordingly
      widget.audioPlayer.positionStream.listen((position) {
        setState(() {
          _sliderValue = position.inMilliseconds.toDouble();
        });
      });

      widget.audioPlayer.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          if (isRepeatOn) {
            // If repeat mode is on, seek to the beginning of the song
            widget.audioPlayer.seek(Duration.zero);
            widget.audioPlayer.play();
          } else {
            // If repeat mode is off, stop playing the song
            setState(() {
              isPlaying = false;
            });
          }
        }
      });

    } on Exception {
      print("Cannot Parse Song");
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('P L A Y I N G', style: GoogleFonts.blackOpsOne(),),
        centerTitle: true,
        elevation: 25,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      const Neubox(
                        child: Icon(Icons.music_note_outlined, size: 250,),
                      ),
                      const SizedBox(height: 40,),
                      Text(widget.songModel.displayNameWOExt.toUpperCase(), style: GoogleFonts.blackOpsOne(fontSize: 16,)),
                      const SizedBox(height: 20,),
                      Text(widget.songModel.artist.toString() == "<unknown>"
                          ? "U N K N O W N    A R T I S T"
                          : widget.songModel.artist.toString(),
                      style: GoogleFonts.blackOpsOne(fontSize : 12),),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(Duration(milliseconds: _sliderValue.toInt())),
                            style: GoogleFonts.blackOpsOne(fontSize : 14),
                          ),
                          Text(
                            _formatDuration(widget.audioPlayer.duration ?? Duration.zero),
                            style: GoogleFonts.blackOpsOne(fontSize : 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Slider(
                                value: _sliderValue,
                                min: 0.0,
                                max: widget.audioPlayer.duration?.inMilliseconds.toDouble() ?? 1.1,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                  widget.audioPlayer.seek(Duration(milliseconds: value.toInt()));
                                  },
                              ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Neubox(child: IconButton(onPressed: (){
                            setState(() {
                              isRepeatOn = !isRepeatOn; // Toggle repeat mode
                            });
                            }, icon: Icon(isRepeatOn ? Icons.repeat_on : Icons.repeat,size: 30,),)),
                          Neubox(child: IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous,size: 30,),)),
                          Neubox(child: IconButton(onPressed: (){
                            setState(() {
                              if (isPlaying){
                                widget.audioPlayer.pause();
                              } else {
                                widget.audioPlayer.play();
                              }
                              isPlaying = !isPlaying;
                            });
                            }, icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,size: 30,),)),
                          Neubox(child: IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next,size: 30,),)),
                          Neubox(child: IconButton(onPressed: (){}, icon: const Icon(Icons.star,size: 30,),)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
