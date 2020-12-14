import 'package:fade_video_app/widgets/chewie_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String videoIndex;
  final String videoTitle;
  VideoPlayer(this.videoIndex, this.videoTitle);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  String videoURL;

  YoutubePlayerController _controller;

  @override
  void initState() {
    videoURL = widget.videoIndex;
    /* _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoURL),
    );*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*   return Scaffold(
      body: youtubeHierarchy(),
    );*/
    /*return WillPopScope(
      onWillPop: _onWillPop,
      child: OrientationBuilder(builder:
          (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
            body: youtubeHierarchy(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.videoTitle),
            ),
            body: youtubeHierarchy(),
          );
        }
      }),
    );*/

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoTitle),
      ),
      body: Center(
        child: ChewieListItem(
          videoPlayerController: VideoPlayerController.network(videoURL
              //'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
              ),
        ),
      ),
    );
  }

  youtubeHierarchy() {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fill,
          child: YoutubePlayer(
            controller: _controller,
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    /*_controller.pause();
    _controller.dispose();
    Navigator.pop(context);*/
    Navigator.pop(context);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }
}
