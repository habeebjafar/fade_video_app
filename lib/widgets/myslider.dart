import 'package:fade_video_app/screens/movie_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fade_video_app/services/slider_service.dart';
import 'package:fade_video_app/models/slider.dart';


class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {

  SliderService _sliderService = SliderService();
  List<SliderModel> _list = List<SliderModel>();
  static List<String> imgList2 = [];
  static List<String> titleList = [];
  List<Widget> imageSliders = [];

  @override
  void initState() {
    super.initState();
    _getAllSliders();
  }



  static List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];


  _getAllSliders() async{
    var sliders = await _sliderService.getSliders();
    sliders['data'].forEach((data){
      var model = SliderModel();
      model.id= data['id'];
      model.title = data['title'];
      model.imgageUrl = data['image_url'];
      model.message = data['message'];
      setState(() {
        _list.add(model);

      });
    });

    imgList2 = List<String>(_list.length);
    titleList = List<String>(_list.length);
    for(int i = 0; i<_list.length; i++){
      imgList2[i] = _list[i].imgageUrl;
      titleList[i] = _list[i].title;
    }


    imageSliders = imgList2.map((item) => Container(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            //builder: (context) => MovieDetails(imgList2.indexOf(item)),
          ));
        },
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      child: Text(
                        '${titleList[imgList2.indexOf(item)]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    )).toList();



/*    print("list of category $imgList2");

    print("sliderURL $imgList");
    print("titleList $titleList");

    print("new array formed $imageSliders");*/

  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              //reverse: true,
              //scrollDirection: Axis.vertical

            ),
            items: imageSliders,
          ),
        ],)
    );
  }
}
