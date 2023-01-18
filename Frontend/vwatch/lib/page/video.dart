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
    super.initState();
    print(widget.url);
    initPlayer();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  int curr_eps = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
            aspectRatio: 16 / 9,
            child: FlickVideoPlayer(flickManager: flickManager)),
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
                  widget.url = decode["url"];
                  print(widget.url);
                  // flickManager.dispose();
                  // _videoplayercontoller.dispose();
                  // _videoplayercontoller.value;
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
    );
  }

  void initPlayer() {
    
    _videoplayercontoller = VideoPlayerController.network(widget.url);
    flickManager = FlickManager(videoPlayerController: _videoplayercontoller);
    flickManager.flickControlManager!.enterFullscreen();
  }
}
