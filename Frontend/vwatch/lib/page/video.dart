// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // ignore: depend_on_referenced_packages
// import 'package:video_player/video_player.dart';
// import 'package:vwatch/main.dart';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/video.dart';
import 'package:http/http.dart' as http;
// class VideoPlayer extends StatefulWidget {
//   const VideoPlayer({Key? key, required this.url}) : super(key: key);
//   final String url;

//   @override
//   State<VideoPlayer> createState() => _VideoPlayerState();
// }

// class _VideoPlayerState extends State<VideoPlayer> {
//   VideoPlayerController? videoPlayerController;
//   ChewieController? chewieController;

//   @override
//   void initState() {

//     if (widget.url.isNotEmpty) {
//       videoPlayerController = VideoPlayerController.network(widget.url);
//       chewieController = ChewieController(
//         customControls: Column(children: [

//           AppBar(
//             title: Text("hello"),
//           ),

//         ],),
//           autoInitialize: true,

//           videoPlayerController: videoPlayerController!,
//           autoPlay: true,
//           allowFullScreen: false,
//           fullScreenByDefault: true,
//           cupertinoProgressColors: ChewieProgressColors(
//               playedColor: CTAColor,
//               bufferedColor: AccentColor,
//               handleColor: CTAColor,
//               backgroundColor: BackgroundColor),
//           materialProgressColors: ChewieProgressColors(
//               playedColor: CTAColor,
//               bufferedColor: AccentColor,
//               handleColor: CTAColor,
//               backgroundColor: BackgroundColor));
//     }
//     print("url: ${widget.url}");

//     super.initState();
//   }

//   @override
//   void dispose() {
//     print(chewieController!.videoPlayerController.position);
//     chewieController!.pause();
//     chewieController!.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screensize = MediaQuery.of(context).size;
//     return Chewie(controller: chewieController!);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String? content_type;
  String url;
  final String id;

  VideoPlayer(
      {Key? key, required this.url, this.content_type, required this.id})
      : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  FlickManager? flickManager;
  @override
  void initState() {
    super.initState();
    print(widget.url);
    initPlayer();
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  int curr_eps = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Column(
        children: [
          FlickVideoPlayer(flickManager: flickManager!),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Prev",
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: WhiteColor,
                      fontSize: 10,
                    ),
                  ),
                  maxLines: 10,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  print(
                      "$URL/nexteps?content_type=${widget.content_type}&token=${USER.token}&profile=${PROFILE.username}&epsno=${curr_eps}&id=${widget.id}");
                  final repsonse = await http.get(Uri.parse(
                      "$URL/nexteps?content_type=${widget.content_type}&token=${USER.token}&profile=${PROFILE.username}&epsno=${curr_eps}&id=${widget.id}"));
                  final decode = json.decode(repsonse.body)["result"];
                  print(decode);

                  setState(() {
                    flickManager!.dispose();
                    widget.url = decode["url"];
                    initPlayer();
                  });
                },
                child: Text(
                  "Next",
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: WhiteColor,
                      fontSize: 10,
                    ),
                  ),
                  maxLines: 10,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void initPlayer() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.url
            // "https://t-ca-2.24hoursuptodatecdn.net/_v9/01b3e0bf48e643923f849702a32bd97a5c4360797759b0838c8f34597271ed8bf541e616b85a255a1320417863fe1980c9c6d12d471fb6d7961711321a2d9cb1be23897428798cbcc3b97d9d706357ecaf127160cd768dfb682e9ce7eb2b448fe4b666b1fc5140d0424780d130011176a68f498a71ec8324c681732255ce3d0a/720/index.m3u8"),
            ));
    flickManager!.flickControlManager!.enterFullscreen();
  }
}
