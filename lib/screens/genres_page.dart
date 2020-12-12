import 'package:fade_video_app/models/movie.dart';
import 'package:fade_video_app/screens/movie_detail.dart';
import 'package:fade_video_app/services/movie_service.dart';
import 'package:flutter/material.dart';

class GenrePage extends StatefulWidget {

  String genreName;

  GenrePage(this.genreName);

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {

  MovieService _movieService  = MovieService();
  List<Movie> _movieList = List<Movie>();

  @override
  void initState(){
    super.initState();
    _getMoviesByGenreName();
  }


  _getMoviesByGenreName() async{
    var response = await _movieService.getMoviesByGenreName(widget.genreName);
    print(response);
    response['data'].forEach((data){
      var model = Movie();
      model.id = data['id'];
      model.title = data['title'];
      model.thumbnail = data['movie_thumbnail'];
      model.quality = data['movie_quality_id'];
      model.releaseDate = data['release_date'];
      model.genres = data['genres'];
      model.poster = data['movie_poster'];
      model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.url = data['download_url'];

      setState(() {
        _movieList.add(model);
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text(widget.genreName),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Select a movie to watch or  download",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width >
                        1000
                        ? 7
                        : MediaQuery.of(context).size.width > 600 ? 5 : 3,
                    childAspectRatio: .49,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0),
                delegate: SliverChildBuilderDelegate(
                  _buildCategoryItem,
                  childCount: _movieList.length,
                )),
          ),
        ],
      ),

    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {


    return Container(
      margin: EdgeInsets.all(5),
      //width: 150,
      //height: 1000,
      // color: Colors.red,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>MovieDetails(_movieList,index)
          ));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image.network(_list[index].genreIcon),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image(
                height: 160.0,
                width: 125.0,
                image: NetworkImage(_movieList[index].thumbnail),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              _movieList[index].title,
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
                  _movieList[index].quality,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _movieList[index].releaseDate.substring(0,4),
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

}
