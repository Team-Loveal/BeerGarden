import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/widgets/interests.dart';
import 'package:lovealapp/widgets/questionAnswer.dart';
import 'package:lovealapp/widgets/fullScreenImage.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  double sigmaX = 0;
  double sigmaY = 0;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    if (userData != null) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
              stops: [0.01, 0.2],
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 100.0,
                    child: AppBar(
                      flexibleSpace: Container(),
                      backgroundColor: Colors.transparent,
                      title: Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text("Logout",
                                style: TextStyle(
                                    fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            onPressed: () {
                              showAlertDialog(context);
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton.icon(
                          icon:
                              Icon(MdiIcons.cog, size: 28.0, color: Colors.white),
                          label: Text(""),
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed('/editProfile', arguments: {
                              'imgUrl': userData.imgUrl,
                              'nicknameEdit': userData.nickname,
                              'locationEdit': userData.location,
                              'occupationEdit': userData.occupation,
                              'aboutEdit': userData.about,
                              'ageEdit': userData.age,
                              'genderEdit': userData.gender,
                              'yodelingEdit': userData.yodeling,
                              'shoppingEdit': userData.shopping,
                              'makingBalloonAnimalsEdit':
                                  userData.makingBalloonAnimals,
                              'cookingEdit': userData.cooking,
                              'paintingEdit': userData.painting,
                              'moviesEdit': userData.movies,
                              'sportsEdit': userData.sports,
                              'writingEdit': userData.writing,
                              'drinkingEdit': userData.drinking,
                            });
                          },
                        ),
                      ],
                      elevation: 0.0,
                      centerTitle: false,
                      automaticallyImplyLeading: false,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return fullScreenImage(context, userData.imgUrl, 0.0, 0.0);
                    }));
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(userData.imgUrl),
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
                      Icon(MdiIcons.mapMarker, size: 20.0, color: Colors.white),
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
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              height: 40,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  if (userData.yodeling) interests("Yodeling"),
                                  if (userData.shopping) interests("Shopping"),
                                  if (userData.makingBalloonAnimals)
                                    interests("Making Balloon Animals"),
                                  if (userData.cooking) interests("Cooking"),
                                  if (userData.painting) interests("Painting"),
                                  if (userData.movies) interests("Movies"),
                                  if (userData.sports) interests("Sports"),
                                  if (userData.writing) interests("Writing"),
                                  if (userData.drinking) interests("Drinking"),
                                ],
                              ),
                            )
                          ]),
                    ),
                    questionAnswer("About me", userData.about),
                    //ANSWERS
                    questionAnswer("🛌 Do you make your bed in the morning?",
                        userData.bed ?? "fill it out!"),
                    questionAnswer(
                        "🤓 Do you read reviews, or just go with your gut?",
                        userData.reviews ?? "fill it out!"),
                    questionAnswer(
                        "🌮 If you could only eat one thing for the rest of your life, what would it be?",
                        userData.foreverEat),
                    questionAnswer(
                        "🌭 If you're eating a meal do you save the best thing for last or eat it first?",
                        userData.bestForLast ?? "fill it out!"),
                    questionAnswer("👽 Do you believe in aliens?",
                        userData.aliens ?? "fill it out!"),
                    questionAnswer(
                        "🚽 If you were a piece of furniture, what piece of furniture would you be?",
                        userData.furniture ?? "fill it out!"),
                    questionAnswer(
                        "🏠 Would you rather have a home in the beach or the mountains?",
                        userData.beachOrMountain ?? "fill it out!"),
                    questionAnswer(
                        "🍱 When you get take-out food do you eat out of the container or transfer the food to dishes?",
                        userData.takeOutFood ?? "fill it out!"),
                    questionAnswer(
                        "🏝 If you were deserted on an island what items would you bring with you?",
                        userData.desertedIsland ?? "fill it out!"),
                    questionAnswer(
                        "💒 If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?",
                        userData.wedding ?? "fill it out!"),
                    questionAnswer("🏡 Your place or mine?",
                        userData.yourPlaceOrMine ?? "fill it out!"),
                    //ANSWER MORE QUESTIONS BTN
                    Container(
                      height: 60.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                      child: PimpedButton(
                          particle: DemoParticle(),
                          pimpedWidgetBuilder: (context, controller) {
                            return RaisedButton(
                                child: Text('Answer some more questions!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                color: Colors.lightGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () => {
                                      controller.forward(from: 0.0),
                                      Navigator.of(context).pushNamed(
                                          '/moreQuestions',
                                          arguments: {
                                            'furniture': userData.furniture,
                                            'beachOrMountain':
                                                userData.beachOrMountain,
                                            'takeOutFood': userData.takeOutFood,
                                            'desertedIsland':
                                                userData.desertedIsland,
                                            'wedding': userData.wedding,
                                            'yourPlaceOrMine':
                                                userData.yourPlaceOrMine,
                                            'bed': userData.bed,
                                            'reviews': userData.reviews,
                                            'foreverEat': userData.foreverEat,
                                            'bestForLast': userData.bestForLast,
                                            'aliens': userData.aliens
                                          }),
                                    });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }

  // displayed to confirm User's logout
  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel",
          style: TextStyle(
              color: Hexcolor("#F4AA33"), fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes",
          style: TextStyle(
              color: Hexcolor("#F4AA33"), fontWeight: FontWeight.bold)),
      onPressed: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        await AuthService().signOut();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
