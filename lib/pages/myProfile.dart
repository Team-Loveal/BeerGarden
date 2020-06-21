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
        backgroundColor: Hexcolor("#F4AA33"),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 70.0,
                child: AppBar(
                  backgroundColor: Hexcolor("#F4AA33"),
                  leading: IconButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        await _auth.signOut();
                      },
                      icon: Icon(MdiIcons.arrowLeft)),
                  actions: <Widget>[
                    FlatButton.icon(
                      icon: Icon(MdiIcons.accountCog,
                          size: 28.0, color: Colors.white),
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
                  centerTitle: true,
                ),
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(userData.imgUrl),
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
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  _buildQuestion("Occupation", userData.occupation),
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
                                _buildInterests("Yodeling"),
                              if (userData.shopping)
                                _buildInterests("Shopping"),
                              if (userData.makingBalloonAnimals)
                                _buildInterests("Making Balloon Animals"),
                              if (userData.cooking)
                                _buildInterests("Cooking"),
                              if (userData.painting)
                                _buildInterests("Painting"),
                              if (userData.movies)
                                _buildInterests("Movies"),
                              if (userData.sports)
                                _buildInterests("Sports"),
                              if (userData.writing)
                                _buildInterests("Writing"),
                              if (userData.drinking)
                                _buildInterests("Drinking"),
                            ],
                          )
                        ]),
                  ),
                  _buildQuestion("About me", userData.about),
                  //ANSWERS
                  _buildQuestion("🛌 Do you make your bed in the morning?",
                      userData.bed ?? "fill it out!"),
                  _buildQuestion(
                      "🤓 Do you read reviews, or just go with your gut?",
                      userData.reviews ?? "fill it out!"),
                  _buildQuestion(
                      "🌮 If you could only eat one thing for the rest of your life, what would it be?",
                      userData.foreverEat),
                  _buildQuestion(
                      "🌭 If you're eating a meal do you save the best thing for last or eat it first?",
                      userData.bestForLast ?? "fill it out!"),
                  _buildQuestion("👽 Do you believe in aliens?",
                      userData.aliens ?? "fill it out!"),
                  _buildQuestion(
                      "🚽 If you were a piece of furniture, what piece of furniture would you be?",
                      userData.furniture ?? "fill it out!"),
                  _buildQuestion(
                      "🏠 Would you rather have a home in the beach or the mountains?",
                      userData.beachOrMountain ?? "fill it out!"),
                  _buildQuestion(
                      "🍱 When you get take-out food do you eat out of the container or transfer the food to dishes?",
                      userData.takeOutFood ?? "fill it out!"),
                  _buildQuestion(
                      "🏝 If you were deserted on an island what items would you bring with you?",
                      userData.desertedIsland ?? "fill it out!"),
                  _buildQuestion(
                      "💒 If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?",
                      userData.wedding ?? "fill it out!"),
                  _buildQuestion("🏡 Your place or mine?",
                      userData.yourPlaceOrMine ?? "fill it out!"),
                  //ANSWER MORE QUESTIONS BTN
                  Container(
                    height: 60.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                    child: RaisedButton(
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
                              Navigator.of(context)
                                  .pushNamed('/moreQuestions', arguments: {
                                'furniture': userData.furniture,
                                'beachOrMountain': userData.beachOrMountain,
                                'takeOutFood': userData.takeOutFood,
                                'desertedIsland': userData.desertedIsland,
                                'wedding': userData.wedding,
                                'yourPlaceOrMine': userData.yourPlaceOrMine,
                                'bed': userData.bed,
                                'reviews': userData.reviews,
                                'foreverEat': userData.foreverEat,
                                'bestForLast': userData.bestForLast,
                                'aliens': userData.aliens
                              }),
                              //Navigator.of(context).pushNamed('/moreQuestions')
                            }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }

  Widget _buildInterests(String interest) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        child: OutlineButton(
            child: Text(interest, style: TextStyle(color: Hexcolor("#8CC63E"))),
            onPressed: null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))));
  }

  Widget _buildQuestion(String title, String body) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 5),
            Text(body, style: TextStyle(fontSize: 16.0))
          ]),
    );
  }
}
