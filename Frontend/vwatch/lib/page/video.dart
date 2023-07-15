import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/video.dart';
import 'package:http/http.dart' as http;

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
  late FlickManager flickManager;
  late VideoPlayerController _videoplayercontoller;
  @override
  void initState() {
    add_history();
    super.initState();
    initPlayer(widget.url);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
            aspectRatio: 16 / 9,
            child: FlickVideoPlayer(flickManager: flickManager)),
      ],
    );
  }

  void initPlayer(url) {
    _videoplayercontoller = VideoPlayerController.network(url);
    flickManager = FlickManager(videoPlayerController: _videoplayercontoller);
    flickManager.flickControlManager!.enterFullscreen();
  }

  add_history() async {
    final repsonse = await http.get(Uri.parse(
        "$URL/add_history?token=${USER.token}&id=${widget.id}&profile=${PROFILE.username}"));
    // final decode = json.decode(repsonse.body);
    // print(decode);
  }
}
