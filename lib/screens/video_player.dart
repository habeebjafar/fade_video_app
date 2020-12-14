import 'dart:io';
import 'package:fade_video_app/helpers/functions.dart';
import 'package:fade_video_app/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fade_video_app/bloc/download_bloc.dart';

class Player extends StatefulWidget {
  final Movie movie;
  final bool isYT;
  Player({this.movie, this.isYT = false});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    play();
  }

  void play() async {
    _controller = VideoPlayerController.file(
      widget.isYT
          ? File(
              '${await getDownloadedPath(getYoutubeId(widget.movie.downloadUrl), isYT: widget.isYT)}')
          : File('${await getDownloadedPath(widget.movie.downloadUrl)}'),
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _controller != null
          ? _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container()
          : Container(),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
