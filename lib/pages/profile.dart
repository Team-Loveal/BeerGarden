import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  final String userID;
  final String nickname;
  final String imgUrl;
  final String chatRoomID;
  Profile({
    Key key,
    this.userID,
    this.nickname,
    this.imgUrl,
    this.chatRoomID,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(
        userID,
        nickname,
        imgUrl,
        chatRoomID,
      );
}

class _ProfileState extends State<Profile> {
  _ProfileState(this.userID, this.nickname, this.imgUrl, this.chatRoomID);
  final String userID;
  final String nickname;
  final String imgUrl;
  final String chatRoomID;

  //to set blur
  double sigmaX;
  double sigmaY;

  //get blur value from the DB
  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('messages')
        .document(chatRoomID)
        .get()
        .then((doc) {
      setState(() {
        sigmaX = doc['blur'].toDouble();
        sigmaY = doc['blur'].toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance.collection('users').document(userID).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text('Profile')),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      Text(
                                          '${snapshot.data['location']}, Japan',
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
                                    child: Image.network(imgUrl,
                                        fit: BoxFit.cover),
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 380,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: sigmaX ?? 50,
                                            sigmaY: sigmaY ?? 50),
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
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (snapshot.data['shopping'])
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
                                if (snapshot.data['makingBalloonAnimals'])
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: OutlineButton(
                                          child: Text("Making Balloon Animals",
                                              style: TextStyle(
                                                  color: Colors.pink)),
                                          onPressed: null,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                if (snapshot.data['cooking'])
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
                                if (snapshot.data['painting'])
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
                                if (snapshot.data['movies'])
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
                                if (snapshot.data['sports'])
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
                                if (snapshot.data['writing'])
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
                                if (snapshot.data['drinking'])
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
                    //ANSWERS
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('🛌Do you make your bed in the morning?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(
                                snapshot.data['bed'] == ""
                                    ? "Ask me!"
                                    : snapshot.data['bed'],
                                style: TextStyle(fontSize: 16)),
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(children: <Widget>[
                        Text('🤓Do you read reviews, or just go with your gut?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Text(
                            snapshot.data['reviews'] == ""
                                ? "Ask me!"
                                : snapshot.data['reviews'],
                            style: TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(children: <Widget>[
                        Text(
                            '🌮If you could only eat one thing for the rest of your life, what would it be?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Text(
                            snapshot.data['foreverEat'] == ""
                                ? "Ask me!"
                                : snapshot.data['foreverEat'],
                            style: TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Wrap(children: <Widget>[
                        Text(
                            "🌭If you're eating a meal do you save the best thing for last or eat it first?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Text(
                            snapshot.data['bestForLast'] == ""
                                ? "Ask me!"
                                : snapshot.data['bestForLast'],
                            style: TextStyle(fontSize: 16)),
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('👽Do you believe in aliens?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(
                                snapshot.data['aliens'] == ""
                                    ? "Ask me!"
                                    : snapshot.data['aliens'],
                                style: TextStyle(fontSize: 16))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('🚽If you were a piece of furniture, what piece of furniture would you be?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(snapshot.data['furniture'] ?? "Ask me!", style: TextStyle(fontSize: 16))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Would you rather have a home in the beach or the mountains?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(snapshot.data['beachOrMountain'] ?? "Ask me!", style: TextStyle(fontSize: 16))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('🍱When you get take-out food do you eat out of the container or transfer the food to dishes?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(snapshot.data['takeOutFood'] ?? "Ask me!", style: TextStyle(fontSize: 16))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('🏝If you were deserted on an island what items would you bring with you?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(snapshot.data['desertedIsland'] ?? "Ask me!", style: TextStyle(fontSize: 16))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('💒If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(snapshot.data['wedding'] ?? "Ask me!", style: TextStyle(fontSize: 16))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('🏡Your place or mine?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(snapshot.data['yourPlaceOrMine'] ?? "Ask me!", style: TextStyle(fontSize: 16))
                          ]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
