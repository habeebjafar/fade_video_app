import 'package:fade_video_app/widgets/chewie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


import 'screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange
      ),
      darkTheme: ThemeData(

          brightness: Brightness.dark,
          primarySwatch: Colors.orange
      ),
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: ChewieListItem(
          videoPlayerController: VideoPlayerController.network(
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          ),

        ),
      ),
    );
  }
}


