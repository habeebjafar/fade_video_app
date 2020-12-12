import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fade_video_app/models/genre.dart';
import 'package:fade_video_app/screens/genres_page.dart';
import 'package:fade_video_app/services/genre_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieGenres extends StatefulWidget {
  @override
  _MovieGenresState createState() => _MovieGenresState();
}

class _MovieGenresState extends State<MovieGenres> {

  GenreService _genreService = GenreService();
  List<Genre> _list = List<Genre>();

  @override
  void initState() {
    super.initState();
    _getAllGenres();

  }


  _getAllGenres() async{
    var response = await _genreService.getGenres();
    print(response);
    response['data'].forEach((data){
      var model = Genre();
      model.id = data['id'];
      model.genreName = data['genreName'];
      model.genreIcon = data['genreIcon'];

      setState(() {
        _list.add(model);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Explore By Genre',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),

              /*Text(
                'View All',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
            ],
          ),
        ),
        SizedBox(height: 10,),

        Container(
          height: 80,
         // color: Colors.blue,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, index){
                /*return Container(
                  margin: EdgeInsets.all(5),
                  width: 125,
                 // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Image.network(_list[index].genreIcon),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3.0),
                        child: Image(
                          height: 160.0,
                          width: 125.0,
                          image: NetworkImage(_list[index].genreIcon),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                          _list[index].genreName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                        //textAlign: TextAlign.left,
                      ),
                     // SizedBox(height: 5,),

                    ],
                  ),


                );*/

                return Container(
                  margin: EdgeInsets.all(3),
                  child: MaterialButton(
                    elevation: 1.0,
                    highlightElevation: 1.0,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => GenrePage(_list[index].genreName)
                      ));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //color: Colors.grey.shade800,
                    color: Color((Random().nextDouble()*0xFFFFFF).toInt()<<0).withOpacity(1.0),

                    textColor: Colors.white70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (_list[index].genreIcon != null) Image.network(
                          _list[index].genreIcon,
                          width: 40,
                          height: 40,
                        ),
                        if (_list[index].genreIcon != null) SizedBox(height: 3.0),
                        AutoSizeText(
                          _list[index].genreName,
                          minFontSize: 10.0,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          wrapWords: false,
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        )

      ],
    );
  }
}



