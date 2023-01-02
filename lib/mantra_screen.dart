
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'models/audio_player_common.dart';



class MantraScreen extends StatefulWidget {
  const MantraScreen({Key? key}) : super(key: key);

  @override
  State<MantraScreen> createState() => _MantraScreenState();
}



class _MantraScreenState extends State<MantraScreen> {
  late AudioPlayer _audioPlayer;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
            position,
            bufferedPosition,
            duration ?? Duration.zero,

          ),
      );


  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.pink,
        statusBarBrightness: Brightness.light
      )
    );

    // _audioPlayer = AudioPlayer()..setAsset("assets/theme_01.mp3");
    _audioPlayer = AudioPlayer()..setUrl(
        "https://firebasestorage.googleapis.com/v0/b/testingtubeapi.appspot.com/o/simpleaudio%2Famoloki_music.mp3?alt=media&token=696a7f47-2046-4824-8787-b95e3f1f5279"
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {

            });
          },
        child: ControlsButton(audioPlayer: _audioPlayer),),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                  barHeight: 50,
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: _audioPlayer.seek,
                );
              },
            ),

            //AUDIO_SPEED_CONTROL
            StreamBuilder<double>(
              stream: _audioPlayer.speedStream,
              builder: (context, snapshot) => IconButton(
                icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                    style:  const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink)),
                onPressed: () {
                  showSliderDialog(
                    context: context,
                    // title: "Adjust speed",
                    title: "স্পীড বাড়ান/কমান",
                    divisions: 10,
                    min: 0.5,
                    max: 1.5,
                    value: _audioPlayer.speed,
                    stream: _audioPlayer.speedStream,
                    onChanged: _audioPlayer.setSpeed,
                  );
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}




