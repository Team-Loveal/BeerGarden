import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ProfilePreview extends StatefulWidget {
  ProfilePreview({Key key, @required this.profileImg}) : super(key: key);
  //instead of reading from db, could try and pass values from previous widgets
  final File profileImg;

  @override
  _ProfilePreviewState createState() => _ProfilePreviewState(profileImg);
}

class _ProfilePreviewState extends State<ProfilePreview> {
  _ProfilePreviewState(this.profileImg);

  final File profileImg;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //get userData from the DB
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          //snapshot is data coming down the stream
          UserData userData = snapshot.data;
          if (userData.imgUrl != null) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  DatabaseService(uid: user.uid).createMatches(userData.genderPreference,
                      userData.lowAge, userData.highAge);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                isExtended: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                icon: Icon(Icons.check),
                label: Text('CONFIRM'),
                backgroundColor: Colors.pink,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
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
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text('Profile Preview',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ))),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${userData.nickname}, ${userData.age}',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold)),
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
                        ],
                      ),
                    ),
                    //IMAGE
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
                                            sigmaX: 0, sigmaY: 0),
                                        child: Container(
                                            color:
                                                Colors.black.withOpacity(0))),
                                  )),
                            ],
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
                              child: Text(userData.occupation,
                                  style: TextStyle(fontSize: 16)),
                            )
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
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.shopping)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Shopping",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.makingBalloonAnimals)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("MakingBalloonAnimals",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.cooking)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Cooking",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.painting)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Painting",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.movies)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Movies",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.sports)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Sports",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.writing)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Writing",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (userData.drinking)
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Drinking",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                              ],
                            )
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('About me',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(userData.about,
                                style: TextStyle(fontSize: 16)),
                          ]),
                    ),
                    //ANSWERS
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(children: <Widget>[
                        Text('Do you make your bed in the morning?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Text(userData.bed, style: TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(children: <Widget>[
                        Text('Do you read reviews, or just go with your gut?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Text(userData.reviews, style: TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(children: <Widget>[
                        Text(
                            'If you could only eat one thing for the rest of your life, what would it be?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Text(userData.foreverEat,
                            style: TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(children: <Widget>[
                        Text(
                            "If you're eating a meal do you save the best thing for last or eat it first?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Text(userData.bestForLast,
                            style: TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Do you believe in aliens?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(userData.aliens,
                                style: TextStyle(fontSize: 16))
                          ]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
