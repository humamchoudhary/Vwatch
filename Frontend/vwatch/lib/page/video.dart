import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';
import 'package:vwatch/main.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
   VideoPlayerController? videoPlayerController;
   ChewieController? chewieController;

  @override
  void initState() {
    if (widget.url.isNotEmpty) {
      videoPlayerController = VideoPlayerController.network(widget.url);
      chewieController = ChewieController(
          autoInitialize: true,
          additionalOptions: (BuildContext) {
            return [
              OptionItem(
                  onTap: () {
                    print("forward");
                  },
                  iconData: CupertinoIcons.forward,
                  title: "forward")
            ];
          },
          videoPlayerController: videoPlayerController!,
          aspectRatio: 16 / 9,
          autoPlay: true,
          allowFullScreen: false,
          fullScreenByDefault: true,
          cupertinoProgressColors: ChewieProgressColors(
              playedColor: CTAColor,
              bufferedColor: AccentColor,
              handleColor: CTAColor,
              backgroundColor: BackgroundColor),
          materialProgressColors: ChewieProgressColors(
              playedColor: CTAColor,
              bufferedColor: AccentColor,
              handleColor: CTAColor,
              backgroundColor: BackgroundColor));
    }
    print("url: ${widget.url}");

    super.initState();
  }
  @override
  void dispose() {
    chewieController!.pause();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.url.isNotEmpty? Chewie(controller: chewieController!):Container();
  }
}
