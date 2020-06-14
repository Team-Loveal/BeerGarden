import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:hexcolor/hexcolor.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  double sigmaX = 0;
  double sigmaY = 0;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userData = Provider.of<UserData>(context);

    if (userData != null) {
      return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
            stops: [0.2, 0.7],
          )),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text("logout"),
                      onPressed: () async {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        await _auth.signOut();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        size: 35,
                        color: Colors.orange,
                      ),
                      onPressed: () async {
                       // Navigator.of(context).pushNamed('/editProfile');
                        Navigator.pushReplacementNamed(context, '/editProfile', arguments: {
                          'nicknameEdit': userData.nickname,
                          'locationEdit': userData.location,
                          'occupationEdit': userData.occupation,
                          'aboutEdit': userData.about,
                        });
                      },
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                  '${userData.nickname}, ${userData.age}',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(MdiIcons.mapMarker,
                                    size: 18, color: Colors.grey),
                                Text('${userData.location}, Japan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey))
                              ],
                            ),
                          ]),
                    ),
                    //IMAGE
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                width: 380,
                height: 380,
                child: Stack(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 380,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(userData.imgUrl,
                                  fit: BoxFit.cover),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 380,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: sigmaX, sigmaY: sigmaY),
                                  child: Container(
                                      color: Colors.black.withOpacity(0))),
                            )),
                      ],
                    ),
//CAN THIS BE DELETED?
//                          Positioned(
//                            bottom: 0,
//                            child: Container(
//                                height: 80,
//                                width: double.infinity,
//                                padding: const EdgeInsets.fromLTRB(35, 5, 0, 5),
//                                decoration: BoxDecoration(
//                                  color: Colors.white.withOpacity(0.7),
//                                  borderRadius: BorderRadius.circular(10.0),
//                                ),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Container(
//                                        child: Text("John Smith, 28",
//                                            style: TextStyle(
//                                              fontSize: 23,
//                                              fontWeight: FontWeight.bold,
//                                            )),
//                                      ),
//                                    ),
//                                    Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Row(
//                                        children: <Widget>[
//                                          Icon(MdiIcons.mapMarker,
//                                              size: 18, color: Colors.pink),
//                                          Text('Tokyo, Japan',
//                                              style: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 18,
//                                                  color: Colors.pink))
//                                        ],
//                                      ),
//                                    ),
//                                  ],
//                                )),
//                          ),
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Occupation',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Expanded(
                          child: Text(userData.occupation,
                              style: TextStyle(fontSize: 16)))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Interests',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Wrap(
                        children: <Widget>[
                          //WHEN REFACTORING CREATE SEPARATE WIDGET AND MAP THROUGH INTERESTS
                          if (userData.yodeling)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Yodeling",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.shopping)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Shopping",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.makingBalloonAnimals)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("MakingBalloonAnimals",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.cooking)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Cooking",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.painting)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Painting",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.movies)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Movies",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.sports)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Sports",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.writing)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Writing",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.drinking)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Drinking",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                        ],
                      )
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('About me',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.about, style: TextStyle(fontSize: 16))
                    ]),
              ),
            ],
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
