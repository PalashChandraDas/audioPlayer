
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var heading = "অপরা একাদশী";
  var paragraph = "মহারাজ যুধিষ্ঠির শ্রীকৃষ্ণকে বললেন- হে কৃষ্ণ! জ্যৈষ্ঠ মাসের কৃষ্ণপক্ষীয়া একাদশীর নাম কী এবং তার মাহাত্ম্যই বা কী, "
      "আমি শোনার ইচ্ছা পোষণ করছি। আপনি অনুগ্রহ করে তা বর্ণনা করুন। শ্রীকৃষ্ণ বললেন- হে মহারাজ! মানুষের মঙ্গলের জন্য আপনি খুব "
      "ভাল প্রশ্ন করেছেন। বহু পুণ্য প্রদানকারী ব্যক্তি জগতে প্রসিদ্ধ লাভ করে। ব্রহ্মহত্যা, গোহত্যা, ভ্রূণহত্যা, পরনিন্দা, পরস্ত্রীগমন, "
      "মিথ্যাভাষণ প্রভৃতি গুরুতর পাপ এই ব্রত পালনে নষ্ট হয়ে যায়। যারা মিথ্যাসাক্ষ্যদান করে, ওজন বিষয়ে ছলনা করে, শাস্ত্রের মিথ্যা ব্যাখ্যা "
      "প্রদান করে, জ্যোতিষের মিথ্যা গণনা ও মিথ্যা চিকিৎসায় রত থাকে, তারা সকলেই নরক যাতনা ভোগ করে। এ সমস্ত ব্যক্তিরাও যদি এই ব্রত "
      "পালন করে, তবে তারা সমস্ত পাপ থেকে মুক্ত হয়। ক্ষত্রিয় যদি স্বধর্ম ত্যাগ করে যুদ্ধক্ষেত্র থেকে পালিয়ে যায়, তবে সে "
      "ঘোরতর নরকগামী হয়। কিন্তু সেও এই ব্রত পালনে মুক্ত হয়ে স্বর্গগতি লাভ করে। মকর রাশিতে সূর্য অবস্থানকালে মাঘ মাসে প্রয়াগ স্নানে "
      "যে ফল লাভ হয়; শিবরাত্রিতে কাশীধামে উপবাস করলে যে পুণ্য হয়; গয়াধামে বিষ্ণুপাদপদ্মে পিণ্ডদানে যে ফল পাওয়া যায়; সিংহ রাশিতে "
      "বৃহস্পতির অবস্থানে গৌতমী নদীতে স্নানে, কুম্ভে কেদারনাথ দর্শনে, বদরিকাশ্রম যাত্রায় ও বদ্রীনারায়ণ সেবায়; সূর্যগ্রহণে কুরুক্ষেত্রে "
      "স্নানে, হাতি-ঘোড়া, স্বর্ণ দানে এবং দক্ষিণাসহ যজ্ঞ সম্পাদনে যে ফল লাভ হয়ে থাকে, এই অপরা ব্রত পাপরূপ বৃক্ষের কুঠার স্বরূপ, "
      "পাপরূপ কাষ্ঠের দাবাগ্নির মতো, পাপরূপ অন্ধকারের সূর্যসদৃশ এবং পাপহস্তির সিংহস্বরূপ। এই ব্রত পালন করে যে ব্যক্তি জীবন ধারণ করে "
      "জলে বুদবুদের মতো তাঁদের জন্ম-মৃত্যুই কেবল সার হয়। অপরা একাদশীতে উপবাস করে বিষ্ণুপূজা করলে সর্বপাপমুক্ত হয়ে বিষ্ণুলোকে গতি হয়। "
      "এই ব্রতকথা পাঠ ও শ্রবণ করলে সহস্র গোদানের ফল লাভ হয়। ব্রহ্মাণ্ডপুরাণে এই ব্রত মাহাত্ম্য বর্ণনা করা হয়েছে। ইতি অপরা একাদশী "
      "ব্রত কথা সমাপ্ত।";

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
        // statusBarBrightness: Brightness.light
      )
    );

    // _audioPlayer = AudioPlayer()..setAsset("assets/theme_01.mp3");
    _audioPlayer = AudioPlayer()..setUrl(
        "https://firebasestorage.googleapis.com/v0"
            "/b/testingtubeapi.appspot"
            ".com/o/simpleaudio%2Famoloki_music.mp3?al"
            "t=media&token=696a7f47-2046-4824-8787-b95e3f1f5279");
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
      appBar: AppBar(
        toolbarHeight: 135,
        elevation: 0.0,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(top: 45.0, left: 10, right: 10),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //PLAYER_POSITION
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
        // backgroundColor: Colors.white.withOpacity(.9),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.pink.withOpacity(.3),
          elevation: 0.0,
        child: ControlsButton(audioPlayer: _audioPlayer),),

      body: Container(
        color: Colors.white,
          // padding: EdgeInsets.all(10),

          child: Column(
            children: [
              Expanded(
                child: Container(
                  // margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(top: 22),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(.1),
                    border: Border.all(color: Colors.pink.withOpacity(.2), width: 5),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(45),
                        topLeft: Radius.circular(45), ),
                  ),

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(heading, style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 70, left: 20, right: 20,),
                                child: Text(
                                  paragraph,
                                  textAlign: TextAlign.justify,
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(fontSize: 18,
                                     ),)),
                          ),

                        ],
                      ),
                    ),

                ),
              ),

            ],
          ),

      ),

    );
  }
}




