import 'package:flutter/material.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Mytest extends StatefulWidget {
  @override
  _MytestState createState() => _MytestState();
}

class _MytestState extends State<Mytest> {
  String id = "";
  int epsno = 0;

  String url = "";

  _get_data() async {
    final repsonse = await http.get(
      Uri.parse("$URL/get_eps?id=$id&epsno=$epsno"),
    );
    final decode = json.decode(repsonse.body) as Map<String, dynamic>;
    setState(() {
      url = decode["url"];
    });
  }

  @override
  void initState() {
    _get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: AspectRatio(
          aspectRatio: 16 / 9,
          child: url.isNotEmpty
              ? const VideoPlayer(
                  url:
                      "https://movietrailers.apple.com/movies/fox/thefantasticfour/fantasticfour-tlr2_h480p.mov",
                )
              : Container(),
        ));
  }
}


// import 'package:flutter/material.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:video_player/video_player.dart';
// import 'package:vwatch/main.dart';

// class SamplePlayer extends StatefulWidget {
//   const SamplePlayer({Key? key}) : super(key: key);

//   @override
//   _SamplePlayerState createState() => _SamplePlayerState();
// }

// class _SamplePlayerState extends State<SamplePlayer> {
//   late FlickManager flickManager;
//   @override
//   void initState() {
//     super.initState();
    
//     flickManager = FlickManager(
//       autoPlay: true,
//       videoPlayerController:
//           VideoPlayerController.network("$URL/stream"),
//     );
//   }

//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FlickVideoPlayer(
          
//           flickManager: flickManager
//         ),
//       ),
//     );
//   }
// }