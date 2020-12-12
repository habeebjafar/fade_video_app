import 'package:fade_video_app/services/genre_service.dart';
import 'package:fade_video_app/widgets/bottom_nav.dart';
import 'package:fade_video_app/widgets/drama_movies.dart';
import 'package:fade_video_app/widgets/series_movies.dart';
import 'package:flutter/material.dart';

import '../widgets/movie_genres.dart';
import '../widgets/myslider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  GenreService _genreService = GenreService();

  @override
  void initState() {
    super.initState();
    //_getAllGenres();
    WidgetsBinding.instance.addObserver(this);
    test();
  }

  test(){
    var x = ["a","b","c","d","e","f"];
    var y = ["a","c","f","a","e","c"];
    var v = [...{...y}];
    var w = y.toSet().toList();
    var u  = ["1","2","3","4","5","6"];

    var m = List<String>(v.length);

    for(int i = 0; i<x.length; i++){

     for(int g = 0; g<v.length; g++){

       if(x[i] == v[g]){
          m[g] = u[i];
          break;
       }

      }

    }
    print("vlaue is m = $m");
    print("vlaue is v = $v");
    print("vlaue is w = $w");

    String myString = "foo,bar,foobar";

    List<String> stringList = myString.split(",");

   // print("vlaue is stringList = $stringList");

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    //inform listeners and rebuild widget tree
  }

  _getAllGenres() async{
    var genres = await _genreService.getGenres();
    //var response = json.decode(genres.body);
    print(genres);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(),
      body: ListView(
        padding: EdgeInsets.only(bottom: 25),
        children: [
          MySlider(),
          SizedBox(height: 10,),
          MovieGenres(),
          SizedBox(height: 25,),
          DramaMovies(),
          SizedBox(height: 25,),
          SeriesMovies()

        ],
      ),

      bottomNavigationBar: BottomNav(),

       floatingActionButton: FloatingActionButton(

        child: Icon(
            Icons.home,
          color: Colors.white,
          size: 35,
        ),
        backgroundColor: Colors.black,
        onPressed: (){
       /*   Navigator.pushReplacement(context, new MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage()
          )
          );*/
        },

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
