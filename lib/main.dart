import 'package:fade_video_app/bloc/download_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DownloadBloc>(
            create: (context) => DownloadBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.orange),
        darkTheme: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.orange),
        home: HomePage(),
      ),
    );
  }
}
