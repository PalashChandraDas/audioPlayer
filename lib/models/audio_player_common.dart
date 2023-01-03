
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';

class ControlsButton extends StatelessWidget {
  const ControlsButton({
    super.key,
    required this.audioPlayer,
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
            _myConnection(context);
          return const CircularProgressIndicator(color: Colors.pink);
        } else if (playing != true) {
          return Ink(
              decoration: ShapeDecoration(
                color: Colors.pink.withOpacity(.8),
                shape: const CircleBorder(),
              ),
            child: IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              iconSize: 32.0,
              onPressed: audioPlayer.play,
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return Ink(
            decoration: ShapeDecoration(
              color: Colors.pink.withOpacity(.8),
              shape: const CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.pause, color: Colors.white),
              iconSize: 32.0,
              onPressed: audioPlayer.pause,
            ),
          );
        } else {
          return Ink(
            decoration: ShapeDecoration(
              color: Colors.pink.withOpacity(.8),
              shape: const CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.replay, color: Colors.white),
              iconSize: 32.0,
              onPressed: () => audioPlayer.seek(Duration.zero),
            ),
          );
        }
      },
    );
  }

 //CUSTOM_METHOD here
   _myConnection(context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "শ্লোকের উচ্চারণ শুনতে আপনার\nইন্টারনেট কানেকশনটি চালু করুন");
      audioPlayer.stop();
      // audioPlayer.play;
    }
  }
} //stateless_widget...END

//NEW_CLASS1****************************

class PositionData {
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