// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // ignore: depend_on_referenced_packages
// import 'package:video_player/video_player.dart';
// import 'package:vwatch/main.dart';

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

class SamplePlayer extends StatefulWidget {
  final String url;
  const SamplePlayer({Key? key, required this.url}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  FlickManager? flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          widget.url),
    );
    flickManager!.flickControlManager!.enterFullscreen();
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(flickManager: flickManager!),
    );
  }
}
