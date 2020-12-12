import 'package:fade_video_app/models/episode.dart';
import 'package:fade_video_app/models/movie.dart';
import 'package:fade_video_app/models/star.dart';
import 'package:fade_video_app/screens/play_video.dart';
import 'package:fade_video_app/services/movie_service.dart';
import 'package:fade_video_app/services/stars_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SeriesMoviesDetails extends StatefulWidget {
  List<Movie> _list;
  int seriesId;
  String title;
  int index;
  SeriesMoviesDetails(this._list, this.title,  this.seriesId,this.index);
  @override
  _SeriesMoviesDetailsState createState() => _SeriesMoviesDetailsState();
}

class _SeriesMoviesDetailsState extends State<SeriesMoviesDetails> {

  MovieService _movieService  = MovieService();
  //List<Movie> _movieList = List<Movie>();
  List<Episode> _movieList = List<Episode>();
  List<Episode> _movieListEpisode = List<Episode>();


  List<String>seasonNumberId = List<String>();

  int _selectedIndex = 0;

  StarsService _starsService = StarsService();
  List<Star>_starList = List<Star>();
  List<String>crewList = List<String>();
  List<String>crewUrl;
  List<String> starNames;
  List<String> imgUrl;
  List<Movie> newList = List<Movie>();

  @override
  void initState(){
    super.initState();
    _getSeasonsBySeriesId();
    //_getEpisodesBySeasonsId(seasonNumberId.length-1);
   // _getEpisodesBySeasonsId();
    _getArray();


  }

  _getArray() async{

    var response = await _starsService.getAllStars();
    print(response);
    response['data'].forEach((data){
      var model = Star();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      setState(() {

        _starList.add(model);

        starNames = List<String>(_starList.length);
        imgUrl = List<String>(_starList.length);

        for(int i =0; i<_starList.length; i++){

          starNames[i] = _starList[i].name;
          imgUrl[i] = _starList[i].photo;
        }

        String crew = widget._list[widget.index].crew;
        List<String> stringList = crew.split(",");

        crewList = [...{...stringList}];


        crewUrl = List<String>(crewList.length);

        for(int i = 0; i<starNames.length; i++){

          for(int g = 0; g<crewList.length; g++){

            if(starNames[i] == crewList[g]){

              crewUrl[g] = imgUrl[i];
            }
          }

        }

      });
    });

    /*starNmaes = List<String>(_list.length);
    imgUrl = List<String>(_list.length);

    for(int i =0; i<_list.length; i++){

      starNmaes[i] = _list[i].name;
      imgUrl[i] = _list[i].photo;
    }

    String crew = widget._list[widget.index].crew;
    List<String> stringList = crew.split(",");

      crewList = [...{...stringList}];


    crewUrl = List<String>(crewList.length);

    for(int i = 0; i<starNmaes.length; i++){

      for(int g = 0; g<crewList.length; g++){

        if(starNmaes[i] == crewList[g]){

            crewUrl[g] = imgUrl[i];
        }
      }

    }*/

    print("star crewUrl $crewUrl");
    print("star crewList $crewList");




    //print("value is stringList = $stringList");
    //print("value is new List = $crewList");

  }


  _getSeasonsBySeriesId() async{
    var response = await _movieService.getSeasonsBySeriesId(widget.seriesId);
    //print(response);
    response['data'].forEach((data){
      var model = Episode();
      model.id = data['id'];
      model.seriesTitle = data['series_title'];
      model.seasonNumber = data['season_number'];
      model.episodeNumber = data['episode_number'];
      model.episodeThumbnail = data['episode_thumbnail'];
      model.episodeUrl = data['episode_url'];
      model.episodeDownloadUrl = data['episode_download_url'];
     /* model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.url = data['download_url'];*/

      setState(() {
        _movieList.add(model);
      });

    });

    List<String>seasonNumber = List<String>(_movieList.length);


    for(int i = 0; i < _movieList.length; i++){

      seasonNumber[i] = _movieList[i].seasonNumber;

    }

    seasonNumberId = [...{...seasonNumber}];

    _getEpisodesBySeasonsId(widget.seriesId,seasonNumberId.last);

    _selectedIndex = seasonNumberId.length-1;




    print('season list $seasonNumber');
    print('season list unrepeated $seasonNumberId');



  }

  _getEpisodesBySeasonsId(seriesId,seasonId) async{
    var response = await _movieService.getEpisodesBySeasonsId(seriesId,seasonId);
    print(' new apis now $response');
    response['data'].forEach((data){
      var model = Episode();
      model.id = data['id'];
      model.seriesTitle = data['series_title'];
      model.seasonNumber = data['season_number'];
      model.episodeNumber = data['episode_number'];
      model.episodeThumbnail = data['episode_thumbnail'];
      model.episodeUrl = data['episode_url'];
      model.episodeDownloadUrl = data['episode_download_url'];
      /* model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.url = data['download_url'];*/

      setState(() {
        _movieListEpisode.add(model);
      });

    });

    //print('episode list ${_movieListEpisode[1].episodeNumber}');

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.only(top: 30,right: 10,left: 10),
       // padding: EdgeInsets.all(10),
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: 250,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: new BoxDecoration(
                  color:  Colors.black,
                  image: new DecorationImage(
                    colorFilter:
                    ColorFilter.mode(Colors.black.withOpacity(0.2),
                        BlendMode.dstATop),
                    image: NetworkImage(widget._list[widget.index].poster),
                    fit: BoxFit.cover,
                  ),
                ),
                //color: Colors.blue,
                /* child: Image(
                    //height: 160.0,
                    //width: 125.0,
                  color: Colors.black12,
                    image: NetworkImage(widget._list[widget.index].poster),
                    fit: BoxFit.cover,
              )*/
                /* child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.black.withOpacity(0.7)),
          ),
        ),*/
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: 30,
                    //color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        iconSize: 30,
                        //color: Colors.black,
                        icon: Icon(Icons.favorite_border),

                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        iconSize: 25.0,
                        //color: Colors.white70,
                        icon: Icon(Icons.share),

                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                  left: 20,
                  bottom: -50,
                  child:  ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Image(
                        height: 200.0,
                        width: 130.0,
                        image: NetworkImage(widget._list[widget.index].thumbnail),
                        fit: BoxFit.cover,
                      )
                  )
              ),
              Positioned(
                right: 20,
                bottom: -25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget._list[widget.index].title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),

                    ),
                    SizedBox(height: 15,),
                    Text("${widget._list[widget.index].genres}"),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => VideoPlayer(widget._list[widget.index].url,widget._list[widget.index].title),
                        ));
                      },
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3)
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,

                            ),
                            Text(
                              "WATCH NOW",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14
                              ),

                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_download,
                            color: Colors.black,

                          ),
                          Text(
                            "DOWNLOAD",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14

                            ),

                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 80,),

          Text(
            "Select Season:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),

          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: seasonNumberId.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: (){

                      _movieListEpisode.clear();
                      _getEpisodesBySeasonsId(widget.seriesId,seasonNumberId[index]);

                      print('my Index $index');
                      setState(() {
                        _selectedIndex = index;
                      });

                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: _selectedIndex  == index  ? Colors.green : Colors.red,
                      ),
                      child: Text(
                          seasonNumberId[index]
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 150,
            child: ListView.builder(
              itemCount: _movieListEpisode.length,
                scrollDirection: Axis.horizontal,

                itemBuilder: (BuildContext context, index){
                  return Container(
                    margin: EdgeInsets.all(5),
                    //width: 150,
                    //height: 1000,
                    // color: Colors.red,
                    child: GestureDetector(
                      onTap: (){
                       /* Navigator.push(context, MaterialPageRoute(
                          // builder: (context)=>MovieDetails(_movieList,index)
                        ));*/
                       _displayDialog(context,_movieListEpisode,index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Image.network(_list[index].genreIcon),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image(
                              height: 100.0,
                              width: 160.0,
                              image: NetworkImage(_movieListEpisode[index].episodeThumbnail),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Season ${_movieListEpisode[index].seasonNumber + " Epi#"+ _movieListEpisode[index].episodeNumber}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            //textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5,),
                          /* Row(
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
            )*/
                        ],
                      ),
                    ),


                  );
                }

            ),
          ),


          Text(
            'Storyline:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,

            ),
          ),

          SizedBox(height: 2,),
          Html(
              data:widget._list[widget.index].description
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Text('Directors: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,

                ),
              ),
              SizedBox(width: 10,),
              Text(
                  widget._list[widget.index].directors
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Text('Genres: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,

                ),
              ),
              SizedBox(width: 10,),
              Text(
                   widget._list[widget.index].genres
              ),
            ],
          ),
          SizedBox(height: 15,),
          Container(
            height: 150,
            //color: Colors.blue,
            // color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cast and Crew:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,

                  ),
                ),

                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: crewList.length,
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
                                  image: NetworkImage(crewUrl[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                               crewList[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                                //textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),


                        );*/

                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(crewUrl[index]),
                                radius: 35.0,
                              ),
                              SizedBox(height: 8.0,),
                              Text(
                                crewList[index],
                                style: TextStyle(
                                  //fontSize: 18.0,
                                  //fontWeight: FontWeight.w600,

                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 210,
            // color: Colors.blue,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newList.length,
                itemBuilder: (BuildContext context, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        // builder: (context)=>MovieDetails(newList,index)
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
                              image: NetworkImage(newList[index].thumbnail),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            newList[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                            //textAlign: TextAlign.left,
                          ),


                        ],
                      ),

                    ),
                  );
                }
            ),
          )


        ],
      ),
    );

  }


  _displayDialog(BuildContext context, List<Episode> movieList, int index) {
    return showDialog(context: context, barrierDismissible: true,builder: (param){

      return AlertDialog(
        backgroundColor: Colors.black,

        title:      Text(
          'Season ${_movieListEpisode[index].seasonNumber + " Epi#"+ _movieListEpisode[index].episodeNumber}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
          //textAlign: TextAlign.left,
        ),
        content: SingleChildScrollView(

          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => VideoPlayer(_movieListEpisode[index].episodeUrl,_movieListEpisode[index].seriesTitle),
                  ));
                },
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3)
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,

                      ),
                      Text(
                        "WATCH NOW",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14
                        ),

                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: 150,
                height: 40,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_download,
                      color: Colors.black,

                    ),
                    Text(
                      "DOWNLOAD",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14

                      ),

                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [

          FlatButton(
            onPressed:(){
              Navigator.pop(context);
            } ,
            child: Text("Cancel"),
          ),

        ],
      );

    });

  }


}


















/*class SeriesMoviesDetails extends StatefulWidget {
  List<Movie> _list;
  int seriesId;
  String title;
  SeriesMoviesDetails(this._list, this.title,  this.seriesId);
  @override
  _SeriesMoviesDetailsState createState() => _SeriesMoviesDetailsState();
}

class _SeriesMoviesDetailsState extends State<SeriesMoviesDetails> {

  MovieService _movieService  = MovieService();
  //List<Movie> _movieList = List<Movie>();
  List<Episode> _movieList = List<Episode>();
  List<Episode> _movieListEpisode = List<Episode>();


  List<String>seasonNumberId = List<String>();

  int _selectedIndex = 0;

  //var seasonNumberId;

  @override
  void initState(){
    super.initState();
    _getSeasonsBySeriesId();
    //_getEpisodesBySeasonsId(seasonNumberId.length-1);
    // _getEpisodesBySeasonsId();


  }


  _getSeasonsBySeriesId() async{
    var response = await _movieService.getSeasonsBySeriesId(widget.seriesId);
    //print(response);
    response['data'].forEach((data){
      var model = Episode();
      model.id = data['id'];
      model.seriesTitle = data['series_title'];
      model.seasonNumber = data['season_number'];
      model.episodeNumber = data['episode_number'];
      model.episodeThumbnail = data['episode_thumbnail'];
      model.episodeUrl = data['episode_url'];
      model.episodeDownloadUrl = data['episode_download_url'];
      *//* model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.url = data['download_url'];*//*

      setState(() {
        _movieList.add(model);
      });

    });

    List<String>seasonNumber = List<String>(_movieList.length);


    for(int i = 0; i < _movieList.length; i++){

      seasonNumber[i] = _movieList[i].seasonNumber;

    }

    seasonNumberId = [...{...seasonNumber}];

    _getEpisodesBySeasonsId(widget.seriesId,seasonNumberId.last);

    _selectedIndex = seasonNumberId.length-1;




    print('season list $seasonNumber');
    print('season list unrepeated $seasonNumberId');



  }

  _getEpisodesBySeasonsId(seriesId,seasonId) async{
    var response = await _movieService.getEpisodesBySeasonsId(seriesId,seasonId);
    print(' new apis now $response');
    response['data'].forEach((data){
      var model = Episode();
      model.id = data['id'];
      model.seriesTitle = data['series_title'];
      model.seasonNumber = data['season_number'];
      model.episodeNumber = data['episode_number'];
      model.episodeThumbnail = data['episode_thumbnail'];
      model.episodeUrl = data['episode_url'];
      model.episodeDownloadUrl = data['episode_download_url'];
      *//* model.description = data['description'];
      model.directors = data['directors'];
      model.crew = data['crew'];
      model.url = data['download_url'];*//*

      setState(() {
        _movieListEpisode.add(model);
      });

    });

    print('episode list ${_movieListEpisode[1].episodeNumber}');

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    "Select a movie to watch or  download",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0),
                  ),
                  Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: seasonNumberId.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){

                              _movieListEpisode.clear();
                              _getEpisodesBySeasonsId(widget.seriesId,seasonNumberId[index]);

                              print('my Index $index');
                              setState(() {
                                _selectedIndex = index;
                              });

                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              color: _selectedIndex  == index  ? Colors.green : Colors.red,
                              child: Text(
                                  seasonNumberId[index]
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
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
                  childCount: _movieListEpisode.length,
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
            // builder: (context)=>MovieDetails(_movieList,index)
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
                image: NetworkImage(_movieListEpisode[index].episodeThumbnail),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              'Season ${_movieListEpisode[index].seasonNumber + " epi"+ _movieListEpisode[index].episodeNumber}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
              //textAlign: TextAlign.left,
            ),
            SizedBox(height: 5,),
            *//* Row(
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
            )*//*
          ],
        ),
      ),


    );
  }
}*/

