import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.audioPlayer ,
  });

  final AudioPlayer audioPlayer;



  @override
  Widget build(BuildContext context) {
    return
      // This StreamBuilder rebuilds whenever the player state changes, which
      // includes the playing/paused state and also the
      // loading/buffering/ready state. Depending on the state we show the
      //appropriate button or loading indicator.
      StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 34.0,
              height: 34.0,
              child: const CircularProgressIndicator(color: Colors.white),
            );
          } else if (playing != true) {
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 34.0,
              onPressed: audioPlayer.play,
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 34.0,
              onPressed: audioPlayer.pause,
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.replay),
              iconSize: 34.0,
              onPressed: () => audioPlayer.seek(Duration.zero),
            );
          }
        },
      );
  }
}

//NEW_CLASS1****************************

class PositionData{
  late final Duration position;
  late final Duration bufferedPosition;
  late final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);


}



void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}