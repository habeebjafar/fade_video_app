import 'package:fade_video_app/models/movie.dart';
import 'package:fade_video_app/screens/series_movies_details.dart';
import 'package:fade_video_app/services/movie_service.dart';
import 'package:flutter/material.dart';

class SeriesMovies extends StatefulWidget {
  @override
  _SeriesMoviesState createState() => _SeriesMoviesState();
}

class _SeriesMoviesState extends State<SeriesMovies> {

  MovieService _movieService = MovieService();
  List<Movie> _list = List<Movie>();

  @override
  void initState() {
    super.initState();
    _getAllSeriesMovies();

  }


  _getAllSeriesMovies() async{
    var response = await _movieService.getAllSeries();
    print(response);
    response['data'].forEach((data){
      var model = Movie();
      model.id = data['id'];
      model.title = data['title'];
      model.url = data['series_url'];
      model.thumbnail = data['series_thumbnail'];
      model.quality = data['series_quality'];
      model.releaseDate = data['release_date'];
      model.genres = data['genres'];
      model.poster = data['series_poster'];
      model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.downloadUrl = data['download_url'];

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
                'Series Movies',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),

              Text(
                'View All',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),

        Container(
          height: 210,
          // color: Colors.blue,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>SeriesMoviesDetails(_list,_list[index].title,_list[index].id,index)
                    ));
                  },
                  child: Container(
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
                            image: NetworkImage(_list[index].thumbnail),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          _list[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                          //textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _list[index].quality,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _list[index].releaseDate.substring(0,4),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
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
