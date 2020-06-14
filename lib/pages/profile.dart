import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  final String userID;
  final String nickname;
  final String imgUrl;
  Profile({Key key, this.userID, this.nickname, this.imgUrl}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(userID, nickname, imgUrl);
}

class _ProfileState extends State<Profile> {
  final String userID;
  final String nickname;
  final String imgUrl;
  _ProfileState(this.userID, this.nickname, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance.collection('users').document(userID).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(MdiIcons.arrowLeft)),
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
                                Text(
                                    '${snapshot.data['nickname']}, ${snapshot.data['age']}',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: <Widget>[
                                    Icon(MdiIcons.mapMarker,
                                        size: 18, color: Colors.grey),
                                    Text('${snapshot.data['location']}, Japan',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey))
                                  ],
                                ),
                              ]),
                        ),
                        Expanded(
                          child: CircleAvatar(
                              radius: 65,
                              backgroundImage: NetworkImage(imgUrl)),
                        ),
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
                              child: Text(snapshot.data['occupation'],
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
                              if (snapshot.data['yodeling'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Yodeling",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['shopping'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Shopping",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['makingBalloonAnimals'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Making Balloon Animals",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['cooking'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Cooking",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['painting'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Painting",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['movies'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Movies",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['sports'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Sports",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['writing'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Writing",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (snapshot.data['drinking'])
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Drinking",
                                            style:
                                                TextStyle(color: Colors.pink)),
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
                          Text(snapshot.data['about'],
                              style: TextStyle(fontSize: 16))
                        ]),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Couldn\'t find user...'),
            );
          }
        });
  }
}