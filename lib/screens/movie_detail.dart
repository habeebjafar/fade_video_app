import 'dart:ui';
import 'package:fade_video_app/models/movie.dart';
import 'package:fade_video_app/models/star.dart';
import 'package:fade_video_app/screens/play_video.dart';
import 'package:fade_video_app/services/stars_service.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
   final int index;
   final List<Movie> _list;

   MovieDetails(this._list,this.index);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  StarsService _starsService = StarsService();
  List<Star>_starList = List<Star>();
  List<String>crewList = List<String>();
  List<String>crewUrl;
  List<String> starNames;
  List<String> imgUrl;
  List<Movie> newList = List<Movie>();


  @override
  void initState() {
    super.initState();

   // print(widget._list[widget.index].url);
    _getArray();
   // mNewArray();
  }

  mNewArray(){
    newList = widget._list;
    newList.removeAt(widget.index);
    newList.shuffle();
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

  @override
  Widget build(BuildContext context) {
   // _getArray();
   // print("star crewListerry $crewList");

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
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

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
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

                    GestureDetector(
                      // Implementing download
                      onTap: (){
                        // download should take place where the download URL is passed
                        // This is the way the download url can be accessed **widget._list[widget.index].downloadUrl**
                        // The code can take place here or a method can and the download url will passed
                      },
                      child: Container(
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
                    ),

                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 80,),
          Text(
            '${widget._list[widget.index].description}'
          ),
          SizedBox(height: 15,),
          Text(
              'Directors: ${ widget._list[widget.index].directors}'
          ),

          SizedBox(height: 15,),
          Text(
              'Genres: ${ widget._list[widget.index].genres}'
          ),
          Container(
            height: 130,
            //color: Colors.blue,
            // color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cast and Crew"),
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
}
