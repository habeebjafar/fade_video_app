import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
       notchMargin: 5,
      child: Container(
       // padding: EdgeInsets.only(left: 25, right: 20),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 30,
                  onPressed: (){},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.movie,
                        color: Colors.white,

                      ),
                      Text(
                        'Movies',
                        //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.red,),

                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {},

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.laptop_chromebook,
                        color: Colors.white,
                      ),
                      Text(
                        'Quiz',
                        //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).primaryColor,),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {

                  },

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.local_movies,
                        color: Colors.white,
                      ),
                      Text(
                        'Series',
                        //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).primaryColor,),
                      ),
                    ],
                  ),
                ),

                MaterialButton(
                  minWidth: 30,
                  onPressed: () {},

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.cloud_download,
                        color: Colors.white,
                      ),
                      Text(
                        'Download',
                        //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).primaryColor,),
                      ),
                    ],
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
