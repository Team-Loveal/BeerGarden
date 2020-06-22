import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/widgets/interests.dart';
import 'package:lovealapp/widgets/questionAnswer.dart';
import 'package:lovealapp/widgets/fullScreenImage.dart';

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
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: userID).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
              backgroundColor: Hexcolor("#F4AA33"),
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      child: AppBar(
                        backgroundColor: Hexcolor("#F4AA33"),
                        elevation: 0.0,
                        centerTitle: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return fullScreenImage(
                              context, userData.imgUrl, sigmaX, sigmaY);
                        }));
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(userData.imgUrl)),
                          Positioned.fill(
                              child: ClipOval(
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: sigmaX ?? 50,
                                        sigmaY: sigmaY ?? 50),
                                    child: Container(
                                        color: Colors.black.withOpacity(0))),
                              )),
                        ],
                      ),
                    ),
                    Text('${userData.nickname},  ${userData.age.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(MdiIcons.mapMarker,
                              size: 20.0, color: Colors.white),
                          Text('${userData.location}, Japan',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: ListView(
                      children: <Widget>[
                        questionAnswer("Occupation", userData.occupation),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Interests',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: 5),
                                Wrap(
                                  children: <Widget>[
                                    //WHEN REFACTORING CREATE SEPARATE WIDGET AND MAP THROUGH INTERESTS
                                    if (userData.yodeling)
                                      interests("Yodeling"),
                                    if (userData.shopping)
                                      interests("Shopping"),
                                    if (userData.makingBalloonAnimals)
                                      interests("Making Balloon Animals"),
                                    if (userData.cooking)
                                      interests("Cooking"),
                                    if (userData.painting)
                                      interests("Painting"),
                                    if (userData.movies)
                                      interests("Movies"),
                                    if (userData.sports)
                                      interests("Sports"),
                                    if (userData.writing)
                                      interests("Writing"),
                                    if (userData.drinking)
                                      interests("Drinking"),
                                  ],
                                )
                              ]),
                        ),
                        questionAnswer("About me", userData.about),
                        //ANSWERS
                        questionAnswer(
                            "🛌 Do you make your bed in the morning?",
                            userData.bed ?? "Ask me!"),
                        questionAnswer(
                            "🤓 Do you read reviews, or just go with your gut?",
                            userData.reviews ?? "Ask me!"),
                        questionAnswer(
                            "🌮 If you could only eat one thing for the rest of your life, what would it be?",
                            userData.foreverEat),
                        questionAnswer(
                            "🌭 If you're eating a meal do you save the best thing for last or eat it first?",
                            userData.bestForLast ?? "Ask me!"),
                        questionAnswer("👽 Do you believe in aliens?",
                            userData.aliens ?? "Ask me!"),
                        questionAnswer(
                            "🚽 If you were a piece of furniture, what piece of furniture would you be?",
                            userData.furniture ?? "Ask me!"),
                        questionAnswer(
                            "🏠 Would you rather have a home in the beach or the mountains?",
                            userData.beachOrMountain ?? "Ask me!"),
                        questionAnswer(
                            "🍱 When you get take-out food do you eat out of the container or transfer the food to dishes?",
                            userData.takeOutFood ?? "Ask me!"),
                        questionAnswer(
                            "🏝 If you were deserted on an island what items would you bring with you?",
                            userData.desertedIsland ?? "Ask me!"),
                        questionAnswer(
                            "💒 If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?",
                            userData.wedding ?? "Ask me!"),
                        questionAnswer("🏡 Your place or mine?",
                            userData.yourPlaceOrMine ?? "Ask me!"),
                        //ANSWER MORE QUESTIONS BTN
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
