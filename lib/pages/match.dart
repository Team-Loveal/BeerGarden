import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:ui';

class Match extends StatefulWidget {
  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text("Today's Match",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ))),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            // width: 380,
            // height: 380,
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 380,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                              'https://cdn.nybooks.com/wp-content/uploads/2018/05/foujita-self-portrait1.jpg',
                              fit: BoxFit.cover),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 380,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                  color: Colors.black.withOpacity(0))),
                        )),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                      height: 80,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(35, 5, 0, 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Text("John Smith, 28",
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(MdiIcons.mapMarker,
                                    size: 18, color: Colors.pink),
                                Text('Tokyo, Japan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.pink))
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(60, 5, 60, 0),
            child: ButtonTheme(
              height: 40.0,
              child: RaisedButton(
                  child: Text('MESSAGE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () => {}),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 1, items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.favorite),
          title: new Text('Match'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.message),
          title: new Text('Messages'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ]),
    );
  }
}
