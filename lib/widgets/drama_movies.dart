import 'package:fade_video_app/bloc/download_bloc.dart';
import 'package:fade_video_app/models/movie.dart';
import 'package:fade_video_app/screens/movie_detail.dart';
import 'package:fade_video_app/services/movie_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DramaMovies extends StatefulWidget {
  @override
  _DramaMoviesState createState() => _DramaMoviesState();
}

class _DramaMoviesState extends State<DramaMovies> {
  MovieService _movieService = MovieService();
  List<Movie> _list = List<Movie>();

  @override
  void initState() {
    super.initState();
    _getAllDramas();
  }

  _getAllDramas() async {
    var downloadBloc = Provider.of<DownloadBloc>(context, listen: false);
    var response = await _movieService.getDramaMovies();
    print(response);
    response['data'].forEach((data) {
      var model = Movie();
      model.id = data['id'];
      model.title = data['title'];
      model.url = data['movie_url'];
      model.thumbnail = data['movie_thumbnail'];
      model.quality = data['movie_quality_id'];
      model.releaseDate = data['release_date'];
      model.genres = data['genres'];
      model.poster = data['movie_poster'];
      model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.downloadUrl = data['download_url'];
      _list.add(model);
    });

    /// pass the list of movies returned from the api through the downloadPipeline in [download_bloc.dart] line 25
    var pipedlist = await downloadBloc.downloadPipeline(_list);
    setState(() {
      _list = pipedlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Drama',
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
        SizedBox(
          height: 10,
        ),
        Container(
          height: 210,
          // color: Colors.blue,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetails(_list, index)));
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _list[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                          //textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 5,
                        ),
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
                              _list[index].releaseDate.substring(0, 4),
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
              }),
        )
      ],
    );
  }
}
